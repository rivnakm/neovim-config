return {
	"miikanissi/modus-themes.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("modus-themes").setup({
			style = "modus_vivendi",
			variant = "default",
		})
		vim.cmd.colorscheme("modus_vivendi")
		vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#6f6f6f", bg = "NONE" })
	end,
}
