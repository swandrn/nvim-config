return {
    {
	"tpope/vim-fugitive",
    },
    {
	"catppuccin/nvim",
	lazy = false,
	name = "catppuccin",
	priority = 1000,
	config = function ()
	    vim.cmd.colorscheme = "catppuccin-mocha"
	end
    }
}
