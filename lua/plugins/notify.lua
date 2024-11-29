return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			icons = {
				ERROR = "",
				WARN = "",
				INFO = "",
				DEBUG = "",
				TRACE = "✎",
			},
			stages = "slide",
		})
		vim.notify = require("notify")
	end,
}
