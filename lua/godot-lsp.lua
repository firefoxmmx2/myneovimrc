-- Function for buffers attached to lsp server
local on_attach = function()

  -- (Optional) User command with autocompletion
  if vim.fn.exists(':GodotDoc') == 0 then
    vim.api.nvim_create_user_command("GodotDoc", function(cmd)
      -- Change the function depending on your preferences
      require('gdscript_extended').open_doc_in_vsplit_win(cmd.args, true)
    end,{
    nargs = 1,
    complete = function()
      return require('gdscript_extended').get_native_classes()
    end
    })
  end

  -- keymaps
  vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
  vim.keymap.set("n", "gD", "<Cmd>lua require('gdscript_extended').open_doc_on_cursor_in_vsplit_win(true)<CR>", {buffer=0})
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer=0})
  vim.keymap.set("n", "<leader>D", "<Cmd>Telescope gdscript_extended vsplit<CR>", {buffer=0})
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {buffer=0})
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {buffer=0})
  vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, {buffer=0})
end

-- Function for documentation buffers
local doc_conf = function(bufnr)
  -- /!\ Don't forget to give the buffer handle to your keymaps, etc /!\
  vim.keymap.set("n", "gD", "<Cmd>lua require('gdscript_extended').open_doc_on_cursor_in_vsplit_win(true)<CR>", {buffer=bufnr})
  vim.keymap.set("n", "<leader>D", "<Cmd>Telescope gdscript_extended vsplit<CR>", {buffer=bufnr})
end

-- Setup with values we changed
require('gdscript_extended').setup({
  on_attach = on_attach,
  doc_keymaps = {
    user_config = doc_conf
  },
})
