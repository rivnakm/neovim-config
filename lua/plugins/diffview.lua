return {
	"sindrets/diffview.nvim",
	config = function()
		require("diffview").setup({})
		vim.keymap.set(
			"n",
			"<leader>dvo",
			"<Cmd>DiffviewOpen<CR>",
			{ noremap = true, silent = true, desc = "Diffview Open" }
		)
		vim.keymap.set(
			"n",
			"<leader>dvc",
			"<Cmd>DiffviewClose<CR>",
			{ noremap = true, silent = true, desc = "Diffview Close" }
		)
	end,
}
