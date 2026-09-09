-- Yazi file manager
return {
	"mikavilpas/yazi.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"<leader>af",
			"<cmd>Yazi<cr>",
			desc = "Open y[A]zi at the current [F]ile",
		},
		{
			"<leader>aw",
			"<cmd>Yazi cwd<cr>",
			desc = "Open y[A]zi in nvim's [W]orking directory",
		},
	},
	---@type YaziConfig | {}
	opts = {
		open_for_directories = true,
	},
	init = function()
		vim.g.loaded_netrwPlugin = 1
	end,
}
