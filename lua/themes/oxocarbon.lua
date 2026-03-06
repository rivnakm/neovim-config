return {
	"nyoom-engineering/oxocarbon.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("oxocarbon")
		vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#525252", bg = "NONE" })
		vim.api.nvim_set_hl(0, "NvimTreeGitFolderIgnoredHL", { fg = "#525252", bg = "NONE" })
		vim.api.nvim_set_hl(0, "NvimTreeGitFileIgnoredHL", { fg = "#525252", bg = "NONE" })
	end,
}
