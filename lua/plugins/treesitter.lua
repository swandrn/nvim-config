return {
	'nvim-treesitter/nvim-treesitter',
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = { "python", "javascript", "typescript", "dockerfile", "yaml", "vim", "lua", "bash", "css", "html", "tsx" },
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
			},
		}
	end
}

