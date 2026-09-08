-- Pretty diff view
return {
	"sindrets/diffview.nvim",
	keys = {
		{
			"<leader>dvo",
			"<Cmd>DiffviewOpen<CR>",
			noremap = true,
			silent = true,
			desc = "Diffview Open",
		},
		{
			"<leader>dvc",
			"<Cmd>DiffviewClose<CR>",
			noremap = true,
			silent = true,
			desc = "Diffview Close",
		},
	},
}
