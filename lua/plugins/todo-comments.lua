-- Highlight TODO and other special comments
return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false,
		keywords = {
			TODO = { alt = { "todo!()" } },
		},
	},
}
