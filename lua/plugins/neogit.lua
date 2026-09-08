-- Git UI
return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim", -- optional
	},
	keys = {
		{
			"<leader>ng",
			"<Cmd>Neogit<CR>",
			noremap = true,
			silent = true,
			desc = "Neogit",
		},
	},
}
