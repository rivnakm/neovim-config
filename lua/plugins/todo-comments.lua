-- Highlight TODO and other special comments
return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "BufEnter",
	opts = {
		signs = false,
		keywords = {
			TODO = { alt = { "todo!()" } },
		},
	},
}
