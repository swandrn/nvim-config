return {
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
			require('lspconfig').cssmodules_ls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').twiggy_language_server.setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').gopls.setup {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr) -- Preserve existing keymaps

					vim.api.nvim_create_autocmd("BufWritePre", {
						pattern = "*.go",
						callback = function()
							local params = vim.lsp.util.make_range_params()
							params.context = { only = { "source.organizeImports" } }
							-- buf_request_sync defaults to a 1000ms timeout. Depending on your
							-- machine and codebase, you may want longer. Add an additional
							-- argument after params if you find that you have to write the file
							-- twice for changes to be saved.
							-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
							local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
							for cid, res in pairs(result or {}) do
								for _, r in pairs(res.result or {}) do
									if r.edit then
										local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
										vim.lsp.util.apply_workspace_edit(r.edit, enc)
									end
								end
							end
							vim.lsp.buf.format({ async = false })
						end
					})
				end,
				capabilities = capabilities,
			}
		end
	}
}
