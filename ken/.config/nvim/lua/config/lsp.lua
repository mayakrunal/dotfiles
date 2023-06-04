local M = {}


function M.setup()
	local lsp = require('lsp-zero').preset('recommended')

	lsp.on_attach(function(client, bufnr)
		lsp.default_keymaps({ buffer = bufnr })
	end)

	-- (Optional) Configure lua language server for neovim
	require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

	-- manual setup for java
	lsp.skip_server_setup({ 'jdtls' })

	lsp.setup()

	-- Make sure you setup `cmp` after lsp-zero

	local cmp = require('cmp')

	cmp.setup({
		preselect = 'item',
		completion = {
			completeopt = 'menu,menuone,noinsert'
		},
		mapping = {
			['<CR>'] = cmp.mapping.confirm({ select = false }),
		},
		window = {
			completion = cmp.config.window.bordered({ side_padding = 0 }),
			documentation = cmp.config.window.bordered({ side_padding = 0 }),
		},
		formatting = {
			format = require('lspkind').cmp_format({
				mode = 'symbol_text', -- show only symbol annotations
				maxwidth = 80, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

				-- The function below will be called before any actual modifications from lspkind
				-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				before = function(entry, vim_item)
					return vim_item
				end
			})
		}
	})
end

return M
