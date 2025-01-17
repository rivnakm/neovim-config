-- Formatter
return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		async = true,
		lsp_fallback = true,
		format_on_save = {
			timeout_ms = 2000,
		},

		formatters_by_ft = {
			astro = { "prettier" },
			javascript = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt" },
			typescript = { "prettier" },
			vue = { "prettier" },
		},
		formatters = {
			prettier = {
				args = function(_, ctx)
					if vim.endswith(ctx.filename, ".astro") then
						return {
							"--stdin-filepath",
							"$FILENAME",
							"--plugin",
							"prettier-plugin-astro",
							"--plugin",
							"prettier-plugin-tailwindcss",
						}
					end
					return { "--stdin-filepath", "$FILENAME", "--plugin", "prettier-plugin-tailwindcss" }
				end,
			},
		},
	},
}
