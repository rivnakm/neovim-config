return {
	"nxuv/just.nvim",
	opts = {},
	keys = {
		{
			"<leader>jr",
			function()
				require("just").run_task_select()
			end,
			desc = "[J]ust [R]un task",
		},
		{
			"<leader>js",
			function()
				require("just").stop_current_task()
			end,
			desc = "[J]ust [S]top task",
		},
		{
			"<leader>jt",
			function()
				require("just").add_task_template()
			end,
			desc = "[J]ust create [T]emplate",
		},
	},
}
