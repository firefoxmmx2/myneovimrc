return {
  -- 覆盖 LazyVim Vue extra 配置，适配 Vue 2 项目
  -- 核心问题：@vue/language-server v3 仅支持 Vue 3，项目使用 Vue 2
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- 禁用 vue_ls（Volar v3，仅兼容 Vue 3），它在 Vue 2 项目上会崩溃
      if opts.servers.vue_ls then
        opts.servers.vue_ls.enabled = false
      end

      -- 从 vtsls 中移除 vue 文件类型及 @vue/typescript-plugin
      -- 避免 vue_ls + vtsls 同时处理 .vue 文件产生冲突
      if opts.servers.vtsls then
        opts.servers.vtsls.filetypes = vim.tbl_filter(function(ft)
          return ft ~= "vue"
        end, opts.servers.vtsls.filetypes or {})

        if opts.servers.vtsls.settings
          and opts.servers.vtsls.settings.vtsls
          and opts.servers.vtsls.settings.vtsls.tsserver
          and opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins
        then
          opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins = vim.tbl_filter(function(plugin)
            return plugin.name ~= "@vue/typescript-plugin"
          end, opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins)
        end
      end
    end,
  },
}
