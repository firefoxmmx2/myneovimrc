---
name: dsh-bot-worktree-orchestration
description: 在 DSH / ds-bot 多 Bot 团队里用 git worktree 隔离任务、通过临时群指定工作目录派活、完成后等用户确认再合并回收时使用。用户明确说「用并行」「用工作树 / worktree 方式做」「开个隔离分支」时触发；也用于排查 Bot 写不进项目目录的权限问题。小修、单文件改动不适用。
---

# DSH Bot 工作树协作

用 worktree 把一次任务隔离出来，用临时群把工作目录指过去，干完**等用户确认**再合并回收。

**建树、合并、回收一律走 worktree-space 插件工具（`wts_worktree_space`），不要让 Bot 自己敲 git 命令。** 原因见下面的「权限」一节。

## 何时用

- 用户明确要求：并行开发、用工作树 / worktree、开隔离分支。
- 一个任务要多个 Bot 同时改同一个仓库。
- 需要在不动主工作区的前提下试一套改动。

**不适用**：改一行、单文件、顺手修一个小东西。用户没说要用工作树时不要自己升级成这套流程。

## 核心事实（先看这条，否则会白干）

- Bot 在**群会话**里的工作目录就是该群的 `work_dir`。
- Bot 的**私有窗口会话**固定在自己的 workspace（通常 `~/.dsh/bot/workspace`），不在项目目录里。
- 所以要在项目目录里改文件，**必须在群会话里派活**；私聊里派，写文件会触发权限审批，甚至直接被拒。
- Main Bot 不能自己改成员 Bot 的 `work_dir`（属于 Bot 设置，要用户自己操作）。

### 权限：为什么必须用插件工具

沙箱只把两处挂成可写：会话工作区（`~/.dsh/bot/workspace`）和当前群的 `work_dir`。`/home` 其余部分一律只读。由此有两条硬结论：

- **Bot 的 bash 写不了任务目录之外的东西。** 工作树的 git 元数据在 `<源仓库>/.git/worktrees/<名字>`，**不在**任务目录里，所以 `git commit` / `git merge` / `git worktree remove` 会报 `index.lock: 只读文件系统`。
- **插件工具跑在宿主进程里，不受这个沙箱约束。** `wts_worktree_space` 的 `create` / `done`、群管理、定时任务都属于这一类，调用时不会弹审批。

所以：建树、合并、删分支、回收工作树，全部交给插件；只有**任务目录内部**的文件改动和 `git add/commit` 才让 Bot 自己做。

## 三个状态

1. **进行中**：worktree 已建、临时群已设好目录、活已派出。
2. **待确认**：活干完了。**不自动合并**，先向用户汇报改了什么、验证结果、遗留问题，问一句还有没有别的想法。
3. **已确认**：用户明确说「合并」「回收」「这版就这样」，才合并 → 回收 worktree → 删任务分支。

中间那一步是硬停点。不能由主 Bot 或执行 Bot 自己判断「看起来做完了就合」。

## 流程

1. **建任务空间（用插件）**
   - 先调 `load_worktree_space` 一次，把 `wts_worktree_space` 和 `wts_session_tool` 挂进当前会话。
   - 再调 `wts_worktree_space` 的 `create`：给出容器根（tasksRoot）、project、task 名、要纳入的仓库。它会建 `<容器根>/<项目>/<任务>/<repo>`、建 `task/<任务名>` 分支、登记任务。
   - **不要**用 `git worktree add`——会撞只读挂载，而且绕过插件登记。

2. **建临时群，再单独设工作目录**
   - 先 `create_group` 建群（`members` 放需要的 Bot）。注意 `create_group` **没有 `work_dir` 参数**，建群时给不了目录。
   - 建完立刻用 `update_group` 补上：
     `update_group(group="<群名>", work_dir="/home/<用户>/Work/worktree-space/<项目>/<任务>")`
   - `work_dir` 必须是真实存在的绝对路径；改目录会让成员会话重开，所以尽量一次写对。
   - 目录生效后，群里 Bot 写文件才落在任务目录；它们各自的私聊窗口仍在自己 workspace，别在私聊里派改文件的活。

3. **统一权限（只能由用户设置）**
   - 群可以指定成员在该群里的 sandbox 权限：`read-only` / `workspace-write` / `danger-full-access`。
   - **Bot 自己设不了**：`update_group` 带 `permission` 会被 roster 拒绝，原话是 `Only the user can set the permissions of "<群名>"`（见 `ds-bot/src/host/roster.js:557-559`）。
   - 所以这一步是**请用户在界面里设**：群设置里把权限调到 `workspace-write`——够改任务目录，又碰不到系统。
   - 用户设完再派活。没设就派，Bot 写文件会弹审批或被直接拒，白跑一轮。
   - 这一步和 `work_dir` 是两件事：`work_dir` 决定写在哪，`permission` 决定能不能写。

4. **派活**
   - 在群里 `@Bot` 派，写清目标、范围、验收标准、交付物路径。
   - 明确要求对方完成后回一句结论。
   - 涉及跨目录写的步骤（合并、回收、切换源仓库分支）不要派给 Bot 的 bash，留在主 Bot 用插件工具做。

5. **审查**
   - 代码审查 Bot 或主 Bot 复核；测试在任务目录里跑。
   - 验证要给出实际命令和结果，不接受「应该没问题」。

6. **待确认（硬停）**
   - 不合并、不删 worktree、不删分支。
   - 汇报：改动文件、验证命令与结果、剩余风险。
   - 问用户是否还有要补的。

6. **合并与回收（仅在用户明确要求后，全部走插件）**
   - 提交在任务目录里做：执行方 `git add <具体文件>` 后 `git commit`（工作树的 git 元数据在源仓库下，提交这一步若被拒，走**授权提权**，不要绕道去源仓库改）。
   - 合并、删任务分支、回收工作树用**一次** `wts_worktree_space` 的 `done`：`merge: true`、`deleteBranch: true`。它在宿主侧执行，不弹审批。
   - `done` 返回 `needsCommit`：还有没提交的东西，先补齐再调。
   - `done` 返回 `mergeInProgress` / `dirtyCheckout`：停下来人工处理，读 worktree-space 技能的 `references/conflicts.md`；不要硬解。
   - `done` 返回 E5012（有会话还在这个任务空间里跑）：先让相关会话结束，再重调。
   - 插件**从不 push**；要推送必须用户在**当前消息**里明确要求。

7. **收尾核对**
   - `git worktree list` 只剩源仓库；分支已删；任务目录已删。
   - 临时群 `delete_group` 归档。
   - 源仓库 `git status` 干净（或只剩明确的未跟踪项）。

## 坑

- 没 commit 就合并会被 `needsCommit` 闸门拦下，先提交再合。
- 同一个 Bot 同时只能在一件事上推进；多个临时群并行会让它来回切，别给它排两条并行的。
- 临时群干完要 `delete_group` 归档，worktree 要回收，分支要删，否则越积越多。
- 合并冲突时会留下 `MERGE_HEAD`，必须人工解，不能硬来。
- 有会话正在该任务空间里跑时，`done` 会被拒绝（E5012），先让相关会话结束。
- 在 Bot 会话里看见 `index.lock: 只读文件系统`，说明这一步在写任务目录之外——换插件工具或走授权提权，不要在源仓库里绕。
- Bot 的 bash 一旦需要跨目录写会弹审批卡片，而卡片出在**它自己的会话**里：没人翻到那个窗口就会一直挂着（有 Bot 因此卡过十几个小时）。派活前先判断这一步要不要跨目录写。

## 交付

完成后给用户：改了哪些文件、怎么验证的、worktree 当前保留在哪个路径、分支名是什么、等确认后要怎么回收。