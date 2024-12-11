-- Documentation annotation provider
return {
	"danymat/neogen",
	config = function()
		require("neogen").setup({})
		vim.keymap.set(
			"n",
			"<leader>nda",
			"<Cmd>Neogen<CR>",
			{ noremap = true, silent = true, desc = "[N]eogen [D]ocument [A]ny" }
		)
		vim.keymap.set(
			"n",
			"<leader>ndf",
			"<Cmd>Neogen func<CR>",
			{ noremap = true, silent = true, desc = "[N]eogen [D]ocument [F]unction" }
		)
		vim.keymap.set(
			"n",
			"<leader>ndc",
			"<Cmd>Neogen class<CR>",
			{ noremap = true, silent = true, desc = "[N]eogen [D]ocument [C]lass" }
		)
		vim.keymap.set(
			"n",
			"<leader>ndt",
			"<Cmd>Neogen type<CR>",
			{ noremap = true, silent = true, desc = "[N]eogen [D]ocument [T]ype" }
		)
		vim.keymap.set(
			"n",
			"<leader>ndi",
			"<Cmd>Neogen file<CR>",
			{ noremap = true, silent = true, desc = "[N]eogen [D]ocument F[i]le" }
		)
	end,
}
