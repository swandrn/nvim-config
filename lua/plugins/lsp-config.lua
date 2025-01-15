return {
	{
		'williamboman/mason.nvim',
		config = function()
			require("mason").setup()
		end
	},
	{
		'williamboman/mason-lspconfig.nvim',
		requires = {
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig'
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls",
					"pyright",
					"html",
					"intelephense",
					"ts_ls",
					"yamlls",
					"sqlls",
					"cssls",
					"tailwindcss"
				},
				automatic_installation = true
			})
		end
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			local on_attach = function(_, _)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
				vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
				vim.keymap.set('n', '<leader>of', vim.diagnostic.open_float, {})
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require('lspconfig').lua_ls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').pyright.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').html.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').intelephense.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').ts_ls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').yamlls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {
					"yaml",
					"yml",
				}
			}
			require('lspconfig').sqlls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = function() return vim.loop.cwd() end,
			}
			require('lspconfig').cssls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').tailwindcss.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
		end
	}
}
