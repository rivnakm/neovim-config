return {
	"miikanissi/modus-themes.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("modus-themes").setup({
			style = "modus_vivendi",
			variants = "default",
		})
		vim.cmd.colorscheme("modus_vivendi")
	end,
}
