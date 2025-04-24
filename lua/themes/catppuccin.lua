return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	flavour = "mocha",
	config = function()
		require("catppuccin").setup({
			term_colors = true,
			color_overrides = {
				mocha = {
					base = "#141417",
					mantle = "#101010",
					crust = "#0C0C0C",
				},
			},
			highlight_overrides = {
				mocha = function(_)
					return {
						NeogitDiffContextHighlight = { bg = "#272734" },
						NeogitCursorLine = { bg = "#272734" },
						YankyPut = { bg = "#CDD6F4", fg = "#141417" },
						YankyYanked = { bg = "#CDD6F4", fg = "#141417" },
						BufferCurrentERROR = { bg = "#45475A", fg = "#F38BA8" },
						BufferCurrentWarn = { bg = "#45475A", fg = "#F9E2AF" },
					}
				end,
			},
			integrations = {
				barbar = true,
				cmp = true,
				dap = true,
				dap_ui = true,
				gitsigns = true,
				mason = true,
				neogit = true,
				notify = true,
				telescope = true,
				ufo = true,
				which_key = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
