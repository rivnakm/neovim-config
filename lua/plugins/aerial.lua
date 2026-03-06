return {
	"stevearc/aerial.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	opts = {},
	keys = {
		{
			"<leader>oo",
			"<cmd>AerialToggle<CR>",
			desc = "[O]utline toggle",
		},
		{
			"<leader>of",
			"<cmd>AerialGo<CR>",
			desc = "[O]utline [F]ocus symbol",
		},
		{
			"<leader>on",
			function()
				require("aerial").next()
			end,
			desc = "[O]utline [N]ext symbol",
		},
		{
			"<leader>op",
			function()
				require("aerial").prev()
			end,
			desc = "[O]utline [P]rev symbol",
		},
	},
}
