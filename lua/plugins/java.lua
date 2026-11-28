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
      local jdtls_bin = vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls"
      -- JVM 参数常量表（回调内拼装为 --jvm-arg= 形式）
      local vmargs = {
        -- 初始堆调小，避免 JVM 默认按物理内存 1/4 分配过大
        "-Xms128m",
        -- 堆上限收紧为 4G，防止内存占用过高
        "-Xmx4G",
        -- 显式指定 G1 垃圾收集器
        "-XX:+UseG1GC",
        -- 元空间上限 1G，避免元数据区无限膨胀
        "-XX:MaxMetaspaceSize=1G",
      }

      -- Lombok：把 lombok.jar 作为 javaagent 挂到 jdtls 自己的 JVM 上
      -- 否则 @Data/@Getter/@Slf4j 生成的 getXxx/setXxx/log 在 JDT 编译器里不可见（报 undefined）
      -- jar 版本与项目依赖对齐：spring-boot-starter-parent 2.7.16 -> lombok 1.18.30
      local lombok_jar = vim.fs.joinpath(vim.fn.stdpath("data"), "lombok", "lombok-1.18.30.jar")
      if (vim.uv or vim.loop).fs_stat(lombok_jar) then
        table.insert(vmargs, "-javaagent:" .. lombok_jar)
      end

      -- 监听 java 文件类型，延迟启动 jdtls
      -- config 仅在 lazy 加载插件时执行一次，不会重复注册 autocmd
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function(args)
          local bufname = vim.api.nvim_buf_get_name(args.buf)
          -- 优先以 .git 作为项目根，其次兜底 pom.xml
          local root_dir = vim.fs.root(bufname, ".git") or vim.fs.root(bufname, "pom.xml")
          -- 无法确定项目根时兜底当前工作目录，避免 fnamemodify 收到 nil
          root_dir = root_dir or vim.fn.getcwd()
          -- 固定数据目录（按项目名区分），复用已有索引缓存，避免每次全量索引
          local data_dir = vim.fs.joinpath(
            vim.fn.stdpath("cache"),
            "jdtls",
            vim.fn.fnamemodify(root_dir, ":t"),
            "workspace"
          )
          -- 每次回调构造全新的 cmd 表，避免共享表被反复追加导致无限增长
          local cmd = { jdtls_bin, "--java-executable=/usr/lib/jvm/java-21-openjdk/bin/java" }
          vim.list_extend(cmd, vim.tbl_map(function(arg)
            return "--jvm-arg=" .. arg
          end, vmargs))
          -- 追加 -data 参数（mason 的 jdtls.py 只认单横线 -data），指定 jdtls 工作区数据目录
          vim.list_extend(cmd, { "-data", data_dir })
          local config = {
            cmd = cmd,
            root_dir = root_dir,
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
                    { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk", default = true },
                  },
                },
              },
            },
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