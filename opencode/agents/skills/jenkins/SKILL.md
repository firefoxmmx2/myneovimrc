---
name: jenkins
description: |
  Jenkins pipeline 部署管理工具。当用户提到以下内容时**必须**使用此 skill：
  - Jenkins / 部署 / 发布 / 构建任务 / 管道 / pipeline
  - 创建新部署任务、修改任务配置、导出配置、更新任务、删除任务
  - 触发构建、查看构建状态、查询构建日志
  - 配置 Jenkins job、批量操作 job
  - 部署到测试/预发布/生产环境
  - 任何涉及 Jenkins CI/CD 的操作
  即使用户没有明确说"Jenkins"，只要涉及部署、CI/CD、任务配置，都应该考虑是否要调用此 skill。
---

# Jenkins 部署管理

## 工具概览

此 skill 提供一个 `jenkins` 脚本（已打包在 `scripts/` 目录），封装了 Jenkins 的 CLI jar + REST API，支持所有常见部署操作。

**脚本位置**（按优先级）：
1. `~/bin/jenkins`（如果用户已安装，已在 PATH 中，推荐）
2. `~/.agents/skills/jenkins/scripts/jenkins`（skill 内置，备用）

## 连接配置

用户需配置凭据，按优先级读取：

| 方式 | 位置 | 格式 |
|---|---|---|
| 环境变量 | `JENKINS_USER` + `JENKINS_TOKEN` | 直接在 shell 中 export |
| 配置文件 | `~/.config/jenkins/credentials` | `export JENKINS_USER="..."` `export JENKINS_TOKEN="..."`, `chmod 600` |
| `.netrc` | `~/.netrc` | `machine 36.133.39.139 login <user> password <token>`, `chmod 600` |

默认 Jenkins URL：`http://36.133.39.139:50001`（可通过 `JENKINS_URL` 环境变量覆盖）

> ⚠ **必须使用 IP 地址**（如 `36.133.39.139`），不要用域名（如 `aisino-server`）。Jenkins 2.533+ 启用了 origin 校验，域名访问会报 403。

## 可用命令

| 命令 | 实现 | 用途 |
|---|---|---|
| `jenkins list` | REST API | 列出所有 job（名称、颜色、最后构建结果） |
| `jenkins get-config <job>` | CLI jar | 导出 job 配置为 XML |
| `jenkins update-config <job> <file>` | CLI jar | **更新 job 配置（核心操作）** |
| `jenkins create <name> <file>` | CLI jar | 从 XML 模板创建新 job |
| `jenkins trigger <job> [KV...]` | REST API | 触发构建（支持参数化） |
| `jenkins delete <job>` | CLI jar | 删除 job（带确认） |
| `jenkins whoami` | REST API | 查看当前认证用户 |
| `jenkins status` | REST API | Jenkins 总体状态 |
| `jenkins help` | — | 查看完整帮助 |

> 读操作（list / whoami / status / trigger）走 REST API，快；写操作（get-config / update-config / create / delete）走 CLI jar，更稳。

## 核心工作流：更新部署任务配置

这是最常见的操作。**严格按照以下步骤**：

```bash
# 1. 导出当前配置
jenkins get-config <job-name> > /tmp/<job-name>.xml

# 2. 备份（这条是保命线）
cp /tmp/<job-name>.xml /tmp/<job-name>.xml.bak

# 3. 编辑配置（用 python 改 XML，不要用 sed，XML 格式极易改坏）
python3 << 'EOF'
import re
with open('/tmp/<job-name>.xml') as f: s = f.read()
# 例 1: 改 timeout
s = re.sub(r'<timeout>\d+</timeout>', '<timeout>60</timeout>', s, count=1)
# 例 2: 改参数默认值
s = re.sub(r'<defaultValue>.*?</defaultValue>', '<defaultValue>main</defaultValue>', s, count=1)
# 例 3: 改 git 分支
s = re.sub(r'<branch>.*?</branch>', '<branch>refs/heads/master</branch>', s, count=1)
with open('/tmp/<job-name>.xml', 'w') as f: f.write(s)
EOF

# 4. diff 检查改动
diff /tmp/<job-name>.xml.bak /tmp/<job-name>.xml

# 5. 推回 Jenkins
jenkins update-config <job-name> /tmp/<job-name>.xml

# 6. 验证
jenkins get-config <job-name> | grep <关注字段>
```

### Python 改 XML 常用片段

```python
# 改 description
s = re.sub(r'<description>.*?</description>', '<description>新描述</description>', s, count=1)

# 改 git repository URL
s = re.sub(r'<url>[^<]*</url>', '<url>git@new-repo:org/project.git</url>', s, count=1)

# 改触发器 cron 表达式
s = re.sub(r'<spec>[^<]*</spec>', '<spec>H 2 * * *</spec>', s, count=1)

# 改 build 参数
s = re.sub(r'<name>BRANCH</name>\s*<defaultValue>[^<]*</defaultValue>',
           r'<name>BRANCH</name>\n      <defaultValue>main</defaultValue>', s, count=1)
```

## 其他工作流

### 触发构建（无参数）
```bash
jenkins trigger <job-name>
```

### 触发构建（有参数）
```bash
jenkins trigger <job-name> BRANCH=develop DEBUG_MODE=true ENV=staging
```

### 创建新部署任务（从模板）
```bash
# 先导出一个已有的同类 job 作为模板
jenkins get-config <similar-existing-job> > /tmp/new-job.xml

# 编辑（改 name、git URL 等）

# 创建
jenkins create new-job-name /tmp/new-job.xml
```

### 批量操作（先列出再遍历）
```bash
jenkins list
# 找到目标 job，写个循环
for job in prod-yantai-*; do
  echo "=== $job ==="
  jenkins get-config "$job" > /tmp/$job.xml
  # 改 ...
  jenkins update-config "$job" /tmp/$job.xml
done
```

## 首次使用 setup（仅在新机器上需要）

如果用户第一次在新机器上用这个工具：

```bash
# 1. 从 Jenkins 服务器下载 CLI jar（约 12MB）
curl -sL -o ~/bin/jenkins-cli.jar \
  http://36.133.39.139:50001/jnlpJars/jenkins-cli.jar

# 2. 配置凭据
mkdir -p ~/.config/jenkins
cat > ~/.config/jenkins/credentials <<'EOF'
export JENKINS_USER="<用户名>"
export JENKINS_TOKEN="<API Token>"
EOF
chmod 600 ~/.config/jenkins/credentials

# 3. 验证
jenkins whoami
```

### 生成 Jenkins API Token

1. 浏览器登录 Jenkins `http://36.133.39.139:50001`
2. 右上角头像 → Security → Add new Token
3. 命名（如 `opencode`）→ Generate → **立即复制保存**

## 重要提醒

1. **URL 必须用 IP**：Jenkins 2.533+ 的 origin 校验要求请求 Origin 头匹配 Jenkins 配置的 root URL（配置的是 IP）。用 IP `36.133.39.139` 访问才能通过，用 `aisino-server` 域名会被 403 拒绝。

2. **update-config 前必须备份**：Jenkins 配置 XML 格式严格，推错了就覆盖。`cp file.xml file.xml.bak` 能救命。

3. **XML 编辑必须用 python，不要用 sed**：sed 处理 XML 极易改坏结构（CDATA、特殊字符、多行值等）。

4. **给新手用户的建议**：如果用户说要"改部署任务的配置"，但说不清具体改哪，先 `jenkins get-config <job>` 导出给他看结构，再引导他说要改什么字段。
