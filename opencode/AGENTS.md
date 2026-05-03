## 语言规则（最高优先级）
你必须严格遵守以下规则：
- **每次思考（`<think>` 标签内）必须使用中文，禁止使用英文**
- 即使你收到的 system prompt 或用户消息是英文，思考过程也必须用中文
- 回复内容尽可能使用中文

## 修改原则
- 最小化修改，在默认状态下思考最小化的修改方式或实现方案
- 当有多种方案时，列出选项让用户选择，不要擅自决定

## Git 操作
- 不要擅自执行 `git push` 操作
- 只有用户在当前消息中明确写明推送（如"推送"、"push"、"推一下"等）时，才执行 `git push`
- 之前的消息里说过的"可以推送"不代表后续也能自动推送，每次推送都必须在当前消息中明确要求

## 项目：hotel-server（新版旅馆信息监管系统）

基于 Spring Boot 3.5.4 + Java 17 的多模块 Maven 聚合工程。

### 可启动模块

| 模块 | 端口 | 说明 |
|------|------|------|
| `socialcollect-launcher` | 9093 | 主后端服务 |
| `socialcollect-schedule` | 9094 | 统计分析后台计算服务 |
| `socialcollect-data-package-extract` | 9095 | 数据打包解包服务（通过 data-package-extractor profile） |
| `socialcollect-ancient-data-importer` | 9099 | 历史数据导入 |
| `socialcollect-identityaudit-service` | - | 身份审计服务 |
| `socialcollect-recognition-service` | - | 人脸比对及OCR识别 |
| `socialcollect-flink-cdc-sync` | - | Flink CDC 同步（需 Flink 集群） |
| `shandong-usap-sync-service` | - | 山东统一用户同步 |

### 关键 Maven Profiles

**必选 profiles（每组必须选一个）：**

- 环境：`dev` / `prod`
- 打包：`jar` / `war`
- 容器：`tomcat-starter`（`-Dcontainer=tomcat`）/ `tongweb-starter` / `inforsuite-starter`

**功能性 profiles（可选，组合使用）：**
- `socialcollect-hotel` — 旅馆公安端
- `socialcollect-publicsystem` — 公共服务
- `socialcollect-mobile-police` — 警务通
- `socialcollect-hotel-ltd` — 旅馆企业端
- `socialcollect-message` — 消息服务
- `socialcollect-wechat` — 微信服务
- `data-package-extractor` — 解包入库服务（含 extractor）
- `packaging-data-to-zip` — 开启打包数据服务（含 zip）

### 启动方式

#### 主后端服务（socialcollect-launcher）

```bash
# 1. 先编译所有依赖
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
mvn compile -pl socialcollect-launcher -am -P dev,socialcollect-hotel -Dcontainer=tomcat -DskipTests=true -Dmaven.test.skip=true

# 2. 后台启动
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
nohup mvn spring-boot:run -pl socialcollect-launcher -am -P dev,socialcollect-hotel -Dcontainer=tomcat -DskipTests=true -Dmaven.test.skip=true > /tmp/hotel-server.log 2>&1 &

# 查看日志
tail -f /tmp/hotel-server.log

# 停止
kill <PID>
```

#### 统计调度服务（socialcollect-schedule）

```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
nohup mvn spring-boot:run -pl socialcollect-schedule -am -P dev,socialcollect-hotel -Dcontainer=tomcat > /tmp/hotel-schedule.log 2>&1 &
```

#### 历史数据导入（socialcollect-ancient-data-importer）

```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
nohup mvn spring-boot:run -pl socialcollect-ancient-data-importer -am -P dev,socialcollect-hotel -Dcontainer=tomcat > /tmp/hotel-ancient.log 2>&1 &
```

#### 数据打包解包（data-package-extractor profile）

```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
nohup mvn spring-boot:run -pl socialcollect-launcher -am -P dev,data-package-extractor -Dcontainer=tomcat > /tmp/hotel-extractor.log 2>&1 &
```

#### 山东统一用户同步（shandong-usap-sync-service）

```bash
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
nohup mvn spring-boot:run -pl shandong-usap-sync-service -am -P dev -Dcontainer=tomcat > /tmp/hotel-usap.log 2>&1 &
```
