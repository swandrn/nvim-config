return {
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			"windwp/nvim-ts-autotag",
			opts = {},
		},
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { "python",
					"javascript",
					"typescript",
					"dockerfile",
					"yaml",
					"vim",
					"lua",
					"bash",
					"css",
					"html",
					"tsx",
					"markdown",
					"markdown_inline",
					"php",
					"nginx" },
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
			}
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require('treesitter-context').setup {
				on_attach = function(_)
					vim.api.nvim_set_hl(0, 'TreeSitterContext', { bg = '#2D2D2D' })
				end
			}
		end
	}
}
