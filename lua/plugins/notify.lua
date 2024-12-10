-- Nicer looking notifications
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
			top_down = false,
		})
		vim.notify = require("notify")
	end,
}
