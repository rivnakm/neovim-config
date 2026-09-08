-- Misc small plugins
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<leader>tj",
			function()
				Snacks.terminal.toggle()
			end,
			desc = "Toggle terminal",
		},
	},
	opts = {
		indent = {},
		notifier = {
			enabled = true,
			top_down = false,
		},
		terminal = {},
	},
}
