return {
	"Mofiqul/vscode.nvim",
	priority = 1000,
	config = function()
		require("vscode").setup({
			italic_comments = true,
		})
	end,
}
