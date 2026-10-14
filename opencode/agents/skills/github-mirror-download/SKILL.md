---
name: github-mirror-download
description: 加速下载 GitHub 上的文件（Release 资产、raw 文件、源码压缩包 archive、codeload 压缩包）。当需要从 GitHub 下载文件、GitHub 直连缓慢或失败、curl/wget 拉取 GitHub 资源超时、或安装 AUR 包/构建时需从 GitHub Release 获取二进制时使用。
---

# GitHub 加速下载技能

在国内网络环境下，GitHub 直连经常超时或 TLS 中断（典型报错：`curl: (35) TLS connect error: error:0A000126:SSL routines::unexpected eof while reading`）。
本技能用**第三方公益加速节点**做 HTTP 前缀转发，绕过直连问题。

核心原理是**前缀拼接**，不改变原始 URL 的任何部分：

```text
https://<加速节点>/<完整的 GitHub 原始 URL>
```

## 1. 何时使用

命中以下任一场景就使用本技能：

- 从 GitHub Release 下载二进制/安装包/模型文件（`https://github.com/<owner>/<repo>/releases/download/...`）
- 拉取 raw 文件（`https://raw.githubusercontent.com/...`）
- 下载仓库源码包（`https://github.com/<owner>/<repo>/archive/refs/tags/....tar.gz`、`https://codeload.github.com/...`）
- 调用 GitHub API 拿 JSON（`https://api.github.com/...`）
- 下载 Gist 内容（`https://gist.github.com/...`）
- AUR / makepkg / Docker 构建 / CI 脚本里需要从 GitHub 取源码或产物，而直连超时
- `curl`、`wget`、`git clone`（部分节点可代理 clone）拉 GitHub 资源卡住或失败

## 2. 推荐做法：直接调用脚本

脚本就打包在本技能目录下的 `scripts/ghdl`（已 `chmod 755`，可执行）。本文档所有命令统一用 `SKILL_DIR` 指向技能目录，先定义一次即可（复制到 shell 里执行或用它拼命令）：

```bash
# 技能目录（DSH 用户级技能根目录，支持自定义 DSH_AGENTS_HOME）
SKILL_DIR="${DSH_AGENTS_HOME:-$HOME/.agents}/skills/github-mirror-download"
```

`SKILL_DIR` 只是便捷变量：如果本技能被安装到其它技能根目录（例如项目级 `.agents/skills`），把 `SKILL_DIR` 指向实际的 `github-mirror-download` 目录即可，下面的命令不需要其它改动，因此换任何用户名、任何安装位置都能用。

只依赖 `bash` + `curl` + `sha256sum`，不需要 python/node。

### 2.1 基本下载

```bash
bash "$SKILL_DIR/scripts/ghdl" -O <github-url>
```

`-O` 表示用「URL 最后一段」作为文件名，也是默认行为，例如：

```bash
bash "$SKILL_DIR/scripts/ghdl" -O \
  "https://github.com/herdrdev/herdr/releases/download/v0.9.4/herdr-linux-x86_64"
# → 得到 ./herdr-linux-x86_64
```

指定文件名 / 路径（路径含空格也可以，务必加引号）：

```bash
bash "$SKILL_DIR/scripts/ghdl" \
  -o "/tmp/my dir/app.bin" "https://github.com/owner/repo/releases/download/v1.0.0/app"
```

### 2.2 需要校验完整性时（强烈建议）

```bash
bash "$SKILL_DIR/scripts/ghdl" \
  -o /tmp/app.bin \
  --sha256 493304fbefb0ed0ea0455f373b47f48d24e8774bc7974f4c916ad2e937675b23 \
  "https://github.com/owner/repo/releases/download/v1.0.0/app"
```

- 哈希不匹配 → 打印期望/实际哈希，**自动删除坏文件**，退出码 `3`。
- 目标文件已存在且哈希一致 → 直接跳过下载。
- 退出码：`0` 成功 / `1` 所有节点与直连均失败 / `2` 参数或 URL 错误 / `3` sha256 校验失败。

### 2.3 先测速选最快节点

```bash
bash "$SKILL_DIR/scripts/ghdl" --best \
  -o /tmp/app.bin "https://github.com/owner/repo/releases/download/v1.0.0/app"
```

`--best` 会并发对 4 个节点各采样最多 1MB，按实测吞吐排序，用最快的节点下载；失败节点自动排到最后。
不指定 `--best` 时按内置优先级顺序依次 fallback。

### 2.4 断点续传（大文件）

```bash
bash "$SKILL_DIR/scripts/ghdl" -C \
  -o big.tar.gz "https://codeload.github.com/owner/repo/tar.gz/refs/tags/v1.0.0"
```

### 2.5 其它选项

```bash
bash "$SKILL_DIR/scripts/ghdl" --list   # 查看内置节点清单与支持类型
bash "$SKILL_DIR/scripts/ghdl" -h       # 完整帮助
bash "$SKILL_DIR/scripts/ghdl" -q ...   # 安静模式，只输出错误
```

脚本行为要点：

1. 校验入参必须是 `github.com` / `raw.githubusercontent.com` / `api.github.com` / `codeload.github.com` / `gist.github.com` 的 https 链接，否则报错退出（退出码 2）。
2. 按优先级对 4 个节点依次尝试：`https://<节点>/<原URL>`；每个节点内部 `--retry 3 --retry-delay 2 --retry-all-errors --connect-timeout 15`。
3. 单节点失败判定：curl 退出码非 0、结果 0 字节、或返回内容明显是 HTML 错误页 → 自动切下一个节点。
4. 4 个节点全部失败 → 回退直连原始 URL。
5. 进度日志（当前节点、耗时、平均速度）全部走 **stderr**，stdout 不被污染，方便脚本管道使用。

## 3. 手动用法（不依赖脚本）

一行命令即可，本质就是前缀拼接：

```bash
curl -fL --retry 3 --retry-delay 2 --connect-timeout 15 \
  -o app-linux-x86_64 \
  "https://gh.acmsz.top/https://github.com/herdrdev/herdr/releases/download/v0.9.4/herdr-linux-x86_64"
```

多节点顺序重试（手工版）：

```bash
URL="https://github.com/owner/repo/releases/download/v1.0.0/app"
for N in gh.acmsz.top github.ednovas.xyz gh.meali.top github.ikgy.top; do
  echo "尝试 $N" >&2
  curl -fL --retry 3 --retry-delay 2 --retry-all-errors --connect-timeout 15 \
       -o app.bin "https://$N/$URL" && break
done
```

### 3.1 节点优先级表（实测 65 个节点后筛出的可用节点）

| 优先级 | 节点 | 实测速度 | Release | Raw | Archive | API |
|---|---|---|---|---|---|---|
| 1 | `gh.acmsz.top` | ≈11.7 MB/s（30MB/2.6s） | ✅ | ✅ | ✅ | ⚠️异常 |
| 2 | `github.ednovas.xyz` | ≈2.1 MB/s | ✅ | ✅ | ❌ | – |
| 3 | `gh.meali.top` | ≈1.9 MB/s | ✅ | ✅ | ✅ | ✅ |
| 4 | `github.ikgy.top` | ≈0.46 MB/s | ✅ | ✅ | – | – |

筛选标准：每个节点连续 3 次下载全部成功，且下载内容的 `sha256` 与 GitHub 官方完全一致（证明节点只做纯转发、未篡改内容）。

> 注意：上表速度是调研时的实测值，实际速度随节点负载、时段、运营商而变化；本机复测可能明显低于该值。

## 4. 重要安全提示

1. **这些是第三方公益节点，仅做 HTTP 纯转发**（`https://<节点>/<原URL>`），请求的 URL、你的出口 IP、User-Agent 对节点运营者可见。
2. **私有仓库、带 token 的 API 请求、机密/内部/敏感文件，禁止走加速节点**。请用官方地址或企业代理。
3. 调研时实测 sha256 与官方一致，但这**不能保证节点永远可信**；重要文件务必用 `--sha256 <官方哈希>`、或下载后手工 `sha256sum <文件>` 与官方发布页（Release Notes / `SHA256SUMS`）比对。
4. 节点随时可能失效、变慢或被劫持；脚本失败时不要盲目重试，先用第 5 节方法换节点。
5. 脚本不保存、不上传、不硬编码任何凭据或个人信息。

## 5. 节点失效时如何自查更新

节点失效是常态，请按以下流程自查新节点并更新脚本里的 `NODE_ENTRIES`。

### 5.1 获取新节点

访问节点聚合导航站（自带测速与状态）：

```text
https://github.akams.cn
```

从站点给出的可用节点列表里挑几个域名，逐个验证后再写入 `NODE_ENTRIES`（格式：`域名|支持类型|实测速度`）。

### 5.2 快速验证单个节点是否可用

用 HEAD 请求验证（8 秒超时即可判断连通性与响应头）：

```bash
curl -sIL --max-time 8 "https://<节点>/https://github.com/curl/curl/releases/download/curl-8_5_0/curl-8.5.0.tar.gz" | head -20
```

- 返回 `HTTP/2 200` 或 `HTTP/2 302`（且最终跟到 `200`）→ 基本可用；`-L` 已跟随跳转。
- 返回 `403 / 404 / 502 / 503`、`curl: (35) TLS ...`、超时无输出 → 该节点已失效或不可用。
- raw 文件也可验证：
  ```bash
  curl -sIL --max-time 8 "https://<节点>/https://raw.githubusercontent.com/hunshcn/gh-proxy/master/README.md" | head -5
  ```

### 5.3 验证节点内容未被篡改

```bash
curl -fsSL --max-time 60 -o /tmp/_probe "https://<节点>/<小文件原始URL>"
sha256sum /tmp/_probe
# 与官方哈希 / 另一个可用节点下载结果比对，二者一致才可信任
```

### 5.4 更新脚本节点表

编辑 `"$SKILL_DIR/scripts/ghdl"`（即本技能目录下的 `scripts/ghdl`）顶部的：

```bash
NODE_ENTRIES=(
  "新节点域名|支持类型|实测速度"
  ...
)
```

然后 `bash -n "$SKILL_DIR/scripts/ghdl"` 做语法检查，并重新验证一次真实下载。

## 6. 已知不适用的方案（避免重复踩坑）

1. **高校镜像的 `github-release` 服务**（USTC、清华 TUNA、南大等）
   只同步**热门仓库**的 Release，对小众仓库/临时资产普遍返回 `404`，不能作为通用加速手段。
2. **知名老牌加速站当前已失效**（实测 3/3 全失败，不要再用）：
   `gh-proxy.com`、`ghproxy.net`、`gh.llkk.cc`、`ghp.ci`、`github.moeyy.xyz`、`ghproxy.cc`、`ghps.cc`、`gh.9kr.cc`、`slink.ltd`、`gh.xxooo.cf`、`hub.gitmirror.com`、`kkgithub.com`、`bgithub.xyz`、`gitclone.com`、`ghproxy.cfd`、`gh.ddlc.top`，以及绝大多数其它同类域名。
3. **不要用 `git clone` 替换方案去下 Release 资产**：Release 资产不在 git 历史里，`git clone` 拿不到，只能走 HTTP。
4. **不要相信"永久可用节点列表"**：公益节点生命周期通常很短（数周到数月），任何写死的列表都需要按第 5 节定期自检。

## 7. 快速自检清单

```bash
SKILL_DIR="${DSH_AGENTS_HOME:-$HOME/.agents}/skills/github-mirror-download"
S="$SKILL_DIR/scripts/ghdl"
bash "$S" --list                 # 节点表还在不在
bash "$S" -O <小文件URL>          # 小文件能不能过
bash "$S" --sha256 <官方哈希> -o /tmp/t.bin <大文件URL> && sha256sum /tmp/t.bin
```
