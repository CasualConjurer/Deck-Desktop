vim.pack.add({ 'https://github.com/saghen/blink.lib', 'https://github.com/saghen/blink.cmp' })
local cmp = require('blink.cmp')

-- cmp.setup({
--     -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
--     -- 'super-tab' for mappings similar to vscode (tab to accept)
--     -- 'enter' for enter to accept
--     -- 'none' for no mappings
--     --
--     -- All presets have the following mappings:
--     -- C-space: Open menu or open docs if already open
--     -- C-n/C-p or Up/Down: Select next/previous item
--     -- C-e: Hide menu
--     -- C-k: Toggle signature help (if signature.enabled = true)
--     --
--     -- See :h blink-cmp-config-keymap for defining your own keymap
--     keymap = { preset = 'enter' },
--
--     -- (Default) Only show the documentation popup when manually triggered
--     completion = { documentation = { auto_show = false } },
--
--     -- (Default) list of enabled providers defined so that you can extend it
--     -- elsewhere in your config, without redefining it, due to `opts_extend`
--     sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
--
--     -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
--     -- You may use a lua implementation instead by using `implementation = "lua"`
--     -- See the fuzzy documentation for more information
--     fuzzy = { implementation = "lua" },
--   }
-- )

cmp.build():wait(60000)

-- vim.pack.add({
-- 	{
-- 		src = "https://github.com/saghen/blink.lib",
-- 		src = "https://github.com/saghen/blink.cmp",
-- 	},
-- })
--
-- Lazy load on first insert mode entry (may not necessary)
local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
			keymap = { preset = "enter" },
			appearance = {
				nerd_font_variant = "mono",
				use_nvim_cmp_as_default = true,
			},
			completion = {
				documentation = { auto_show = true },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "lua" },
		})
	end,
})


-- vim.pack.del({
--   'https://github.com/saghen/blink.lib', 'https://github.com/saghen/blink.cmp'
-- })

