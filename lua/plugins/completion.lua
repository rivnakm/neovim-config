return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"brenoprata10/nvim-highlight-colors",
	},
	version = "1.*",
	opts = {
		keymap = {
			preset = "default",
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		completion = {
			menu = {
				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local icon = ctx.kind_icon
								if ctx.item.source_name == "LSP" then
									local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
									if color_item and color_item.abbr ~= "" then
										icon = color_item.abbr
									end
								end
								return icon .. ctx.icon_gap
							end,
							highlight = function(ctx)
								local highlight = "BlinkCmpKind" .. ctx.kind
								if ctx.item.source_name == "LSP" then
									local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
									if color_item and color_item.abbr_hl_group then
										highlight = color_item.abbr_hl_group
									end
								end
								return highlight
							end,
						},
					},
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
