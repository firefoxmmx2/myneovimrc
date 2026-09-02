return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      root_dir = function(path)
        return vim.fs.root(path, ".git") or vim.fs.root(path, "pom.xml")
      end,
      dap_main = {
        config_overrides = {
          console = "integratedTerminal",
        },
      },
    },
    config = function(_, opts)
      -- jdtls 启动脚本路径（由 mason 安装）
      local cmd = {
        vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls",
        -- 初始堆调小，避免 JVM 默认按物理内存 1/4 分配过大
        "--jvm-arg=-Xms128m",
        -- 堆上限收紧为 4G，防止内存占用过高
        "--jvm-arg=-Xmx4G",
        -- 显式指定 G1 垃圾收集器
        "--jvm-arg=-XX:+UseG1GC",
        -- 元空间上限 1G，避免元数据区无限膨胀
        "--jvm-arg=-XX:MaxMetaspaceSize=1G",
      }

      -- 监听 java 文件类型，延迟启动 jdtls
      -- config 仅在 lazy 加载插件时执行一次，不会重复注册 autocmd
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function(args)
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          local config = {
            cmd = cmd,
            -- 优先以 .git 作为项目根，其次兜底 pom.xml
            root_dir = vim.fs.root(bufname, ".git") or vim.fs.root(bufname, "pom.xml"),
            settings = { java = {} },
          }
          if opts.on_attach then
            config.on_attach = opts.on_attach
          end
          -- start_or_attach 内部依赖 vim.lsp.start 自动去重，无需额外判断
          require("jdtls").start_or_attach(config)
        end,
      })
    end,
  },
}