-- Nicer looking notifications
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		notifier = {
			enabled = true,
			top_down = false,
		},
	},
}
