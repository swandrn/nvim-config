return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme "catppuccin-mocha"
			vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'red' })
			vim.api.nvim_set_hl(0, 'LineNr', { fg = 'red' })
			vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'red' })
		end
	}
}
