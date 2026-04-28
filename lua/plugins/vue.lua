return {
  -- 覆盖 LazyVim 的 Vue extra 配置，适配 Vue 2 项目
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- 禁用 vue_ls（volor v3，仅支持 Vue 3）
      opts.servers.vue_ls = vim.tbl_deep_extend("force", opts.servers.vue_ls or {}, {
        enabled = false,
      })

      -- 从 vtsls 中移除 vue 文件类型，避免 vtsls + vue_ls 冲突
      if opts.servers.vtsls then
        opts.servers.vtsls.filetypes = vim.tbl_filter(function(ft)
          return ft ~= "vue"
        end, opts.servers.vtsls.filetypes or {})
        -- 移除 @vue/typescript-plugin，它只支持 Vue 3
        if opts.servers.vtsls.settings
          and opts.servers.vtsls.settings.vtsls
          and opts.servers.vtsls.settings.vtsls.tsserver
        then
          opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins = vim.tbl_filter(function(plugin)
            return plugin.name ~= "@vue/typescript-plugin"
          end, opts.servers.vtsls.settings.vtsls.tsserver.globalPlugins or {})
        end
      end
    end,
  },
}
