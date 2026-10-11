vim.pack.add( {'https://github.com/mason-org/mason.nvim'} )

require("mason").setup()

-- require('mason-tool-installer').setup({
--   ensure_installed = {
--     'lua_ls',
--     'gopls',
--     'ts_ls',
--     'jsonls',
--     'stylua',
--     'prettier',
--   },
-- })
--
--
-- require('mason-lspconfig').setup({
--   automatic_enable = false,
-- })
