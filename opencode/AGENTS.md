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

## 代理模式规则

- **主代理负责规划**：主代理接收用户请求后，分析需求、拆解任务、制定执行计划，不亲自执行具体工作
- **子代理负责执行**：具体任务（搜索、代码编写、代码审查等）委托给子代理执行
- **尽可能使用子代理**：任何可委托的具体工作都应优先交给子代理，不要在主代理中直接执行大量搜索/读写/编辑操作
- **结果整合**：子代理完成后，主代理整合结果并输出最终答案

## 包管理器规则

- Node.js 包管理优先使用 `pnpm`，除非项目已锁定 `npm` 或 `yarn`
- Python 包管理优先使用 `uv`（含 `uv add`、`uv pip`、`uv run` 等），除非项目已明确要求 `pip` 或 `poetry`

<!-- context7 -->
Use Context7 MCP to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service -- even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, library-specific debugging, setup instructions, and CLI tool usage. Use even when you think you know the answer -- your training data may not reflect recent changes. Prefer this over web search for library docs.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

## Steps

1. Always start with `resolve-library-id` using the library name and the user's question, unless the user provides an exact library ID in `/org/project` format
2. Pick the best match (ID format: `/org/project`) by: exact name match, description relevance, code snippet count, source reputation (High/Medium preferred), and benchmark score (higher is better). If results don't look right, try alternate names or queries (e.g., "next.js" not "nextjs", or rephrase the question). Use version-specific IDs when the user mentions a version
3. `query-docs` with the selected library ID and the user's full question (not single words)
4. Answer using the fetched docs
<!-- context7 -->
