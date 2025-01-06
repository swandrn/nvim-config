return {
	'stevearc/conform.nvim',
	event = { "BufWritePre" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "autopep8" },
			javascript = { "deno_fmt" },
			javascriptreact = { "deno_fmt" },
			typescript = { "deno_fmt" },
			typescriptreact = { "deno_fmt" },
			markdown = { "deno_fmt" },
			json = { "deno_fmt" },
		},
		format_on_save = {
			enabled = true,
			timeout_ms = 1000,
			lsp_fallback = true,
		},
	}
}
