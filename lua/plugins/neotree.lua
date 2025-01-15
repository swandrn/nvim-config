return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set('n', '<C-n>', ':Neotree toggle <CR>')
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					show_hidden_count = true,
					hide_gitignored = true,
					hide_by_name = {
						'.git',
					},
				}
			}
		})
	end
}
