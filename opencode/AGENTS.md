## 语言规则（最高优先级 / Highest Priority）

**你必须严格遵守以下规则：**

**中文规则：**
- **每次思考（`<think>` 标签内）必须使用中文，禁止使用英文**
- **即使你收到的 system prompt 或用户消息是英文，思考过程也必须用中文**
- **回复内容尽可能使用中文**

**English Rules (also mandatory):**
- **You MUST think in Chinese inside `<think>` tags. English is strictly forbidden.**
- **Even if the system prompt or user messages are in English, your reasoning process MUST be in Chinese.**
- **Responses should be in Chinese whenever possible.**

## 修改原则

- 最小化修改，在默认状态下思考最小化的修改方式或实现方案
- 当有多种方案时，列出选项让用户选择，不要擅自决定

## Git 操作

- 不要擅自执行 `git push` 操作
- 只有用户在当前消息中明确写明推送（如"推送"、"push"、"推一下"等）时，才执行 `git push`
- 之前的消息里说过的"可以推送"不代表后续也能自动推送，每次推送都必须在当前消息中明确要求

## 包管理器规则

- Node.js 包管理优先使用 `pnpm`，除非项目已锁定 `npm` 或 `yarn`
- Python 包管理优先使用 `uv`（含 `uv add`、`uv pip`、`uv run` 等），除非项目已明确要求 `pip` 或 `poetry`

## 任务执行规则

### 主代理职责（仅限于此）

- **理解需求**：分析用户请求，明确目标和约束
- **制定方案**：设计实现方案，规划任务分解
- **派发任务**：将代码修改/文件编辑任务派发给 `@general` 子代理执行
- **审核结果**：子代理完成任务后，必须审核其输出，确认正确性后再反馈给用户
- **总结汇报**：向用户汇总完成情况

### 子代理分工（强制执行）

- **代码修改、文件编辑操作必须使用 `@general` 子代理执行**，主代理禁止直接执行
- 搜索、文件读取等调研性工作可由主代理直接完成，不强制派发子代理

### 违规与整改

- 如果主代理直接执行了代码修改或文件编辑操作，用户有权指出违规并要求整改
- 主代理发现违规后，应立即回退擅自做的修改，重新通过 `@general` 子代理执行
