local util = require('lspconfig.util')

vim.api.nvim_create_user_command('Format', vim.lsp.buf.formatting_seq_sync, {})

vim.keymap.set('n', '<leader>ca', ':CodeActionMenu<CR>')
vim.keymap.set('v', '<leader>ca', ':CodeActionMenu<CR>')
vim.keymap.set('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')

-- vim.lsp.set_log_level("debug")

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    source = true,
    focus = false,
    format = function(diagnostic)
      if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
        return string.format('%s: %s', diagnostic.user_data.lsp.code, diagnostic.message)
      end
      return diagnostic.message
    end,
  },
})

local on_attach = function(_, bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { buffer = bufnr })
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { buffer = bufnr })
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = bufnr })
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { buffer = bufnr })
  -- vim.keymap.set(bufnr, 'n', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { buffer = bufnr })
  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { buffer = bufnr })
  -- vim.keymap.set(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { buffer = bufnr })
  vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>', { buffer = bufnr })

  -- vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { buffer = bufnr })
  -- vim.keymap.set('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', { buffer = bufnr })
  -- vim.keymap.set('n', '<leader>ca', ':Telescope lsp_code_actions<CR>', { buffer = bufnr })
  -- vim.keymap.set('v', '<leader>ca', ':Telescope lsp_range_code_actions<CR>', { buffer = bufnr })
  -- vim.keymap.set('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', { buffer = bufnr })
  -- vim.keymap.set('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], { buffer = bufnr })
end

-- nvim-cmp supports additional completion capabilities
--local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true
--local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require('lspconfig').html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require('lspconfig').cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require('lspconfig').emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
    init_options = {
        html = {
            options = {
                ["bem.enabled"] = true,
            },
        },
    }
})

require('lspconfig').clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities
})
--vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
--vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
--vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
--vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-- suppress error messages from lang servers
-- vim.notify = function(msg, log_level, _)
--   if msg:match 'exit code' then
--     return
--   end
--   if log_level == vim.log.levels.ERROR then
--     vim.api.nvim_err_writeln(msg)
--   else
--     vim.api.nvim_echo({ { msg } }, true, {})
--   end
-- end
