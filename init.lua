vim.pack.add {
	-- treesitter
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/nvim-treesitter/nvim-treesitter-context',

	-- lsp
	'https://github.com/neovim/nvim-lspconfig',

	-- fuzzyfinder
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',

	-- colorscheme
	{ src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },

	-- lualine
	'https://github.com/nvim-lualine/lualine.nvim',

	-- filetree
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/MunifTanjim/nui.nvim',
	'https://github.com/nvim-neo-tree/neo-tree.nvim',

	-- autocompletion
	'https://github.com/nvim-mini/mini.completion',
	'https://github.com/nvim-mini/mini.pairs',

	-- git
	'https://github.com/lewis6991/gitsigns.nvim',

	-- formatter
	'https://github.com/stevearc/conform.nvim',
}

vim.cmd.packadd('nvim.undotree')

require('catppuccin').setup({
	transparent_background = true,
})
vim.cmd.colorscheme('catppuccin-mocha')

vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'white' })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'white' })

require('neo-tree').setup({
	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			show_hidden_count = true,
			hide_gitignored = true,
			hide_by_name = {
				'.git',
			},
		},
	},
})

require('mini.pairs').setup()

require('lualine').setup()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.background = 'dark'
vim.opt.autowrite = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true
vim.opt.scrolloff = 5
vim.opt.cursorline = true

vim.api.nvim_create_autocmd('FileType', {
	callback = function() pcall(vim.treesitter.start) end,
})

-- keymaps
local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fif', function()
	telescope.find_files({
		find_command = { 'rg', '--files', '--no-ignore' },
		hidden = true,
		no_ignore = true,
		desc = 'Telescope find hidden files'
	})
end)
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', {})
vim.keymap.set('n', '<leader>gr', ':Gitsigns reset_hunk<CR>', {})

vim.keymap.set('n', '<C-n>', '<Cmd>Neotree toggle<CR>')

-- Setup servers
local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('*', {
	capabilities = capabilities
})

-- lua
vim.lsp.config('lua_ls', {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	},
})


-- html
vim.lsp.config('html', {
	capabilities = capabilities,
})

-- typescript
vim.lsp.config('ts_ls', {
	capabilities = capabilities,
})

-- css
vim.lsp.config('cssls', {
	capabilities = capabilities,
})

vim.lsp.config('cssmodules_ls', {
	capabilities = capabilities,
})

-- python
vim.lsp.config('pyright', {
	capabilities = capabilities,
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				typeCheckingMode = 'basic',
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

vim.lsp.config('ruff', {
	cmd = vim.fn.executable('ruff') == 1
			and { 'ruff', 'server' }
			or { 'uv', 'run', 'ruff', 'server' },
	capabilities = capabilities,
	init_options = {
		settings = {
			configuration = {
				format = {
					['quote-style'] = 'double',
				},
			},
		},
	},
})

-- c
vim.lsp.config('clangd', {
	cmd = { 'clangd-19' },
	capabilities = capabilities,
})

-- enable servers
vim.lsp.enable({
	'lua_ls',
	'pyright',
	'html',
	'intelephense',
	'ts_ls',
	'cssls',
	'cssmodules_ls',
	'ruff',
	'clangd',

})

-- lsp keymaps
local on_attach = function(_, bufnr)
	local map = function(lhs, rhs, desc)
		vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = desc })
	end

	map('<leader>rn', vim.lsp.buf.rename, 'LSP rename')
	map('<leader>ca', vim.lsp.buf.code_action, 'LSP code action')

	map('gd', vim.lsp.buf.definition, 'Go to definition')
	map('gi', vim.lsp.buf.implementation, 'Go to implementation')
	map('gr', telescope.lsp_references, 'References')
	map('K', vim.lsp.buf.hover, 'Hover')
	map('<leader>of', vim.diagnostic.open_float, 'Open diagnostic float')
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			on_attach(client, args.buf)
		end
	end,
})

-- formatter conf
local conform = require('conform')
conform.setup({
	formatters_by_ft = {
		lua = { 'stylua' },
		python = { 'ruff_fix', 'ruff_format' },
		javascript = { 'deno_fmt' },
		javascriptreact = { 'deno_fmt' },
		typescript = { 'deno_fmt' },
		typescriptreact = { 'deno_fmt' },
		markdown = { 'deno_fmt' },
		json = { 'deno_fmt' },
		sql = { 'sql_formatter' },
		mysql = { 'sql_formatter' },
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = 'fallback',
	},
})

vim.api.nvim_create_autocmd('BufWritePre', {
	callback = function(args)
		conform.format({
			bufnr = args.buf,
			timeout_ms = 1000,
			lsp_format = 'fallback',
		})
	end,
})
