return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	event = "BufEnter",
	config = function()
		vim.keymap.set("n", "<leader>bl", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next tab" })
		vim.keymap.set(
			"n",
			"<leader>bh",
			"<Cmd>BufferPrevious<CR>",
			{ noremap = true, silent = true, desc = "Previous tab" }
		)
		vim.keymap.set(
			"n",
			"<leader>bml",
			"<Cmd>BufferMoveNext<CR>",
			{ noremap = true, silent = true, desc = "Move tab right" }
		)
		vim.keymap.set(
			"n",
			"<leader>bmh",
			"<Cmd>BufferMovePrevious<CR>",
			{ noremap = true, silent = true, desc = "Move tab left" }
		)
		vim.keymap.set("n", "<leader>bx", "<Cmd>BufferPin<CR>", { noremap = true, silent = true, desc = "Pin tab" })
		vim.keymap.set("n", "<leader>bk", "<Cmd>BufferPick<CR>", { noremap = true, silent = true, desc = "Pick tab" })
		vim.keymap.set("n", "<leader>bc", "<Cmd>BufferClose<CR>", { noremap = true, silent = true, desc = "Close tab" })
		vim.keymap.set(
			"n",
			"<leader>bd",
			"<Cmd>BufferDelete<CR>",
			{ noremap = true, silent = true, desc = "Delete tab" }
		)

		require("barbar").setup({
			animation = false,
			sidebar_filetypes = {
				NvimTree = true,
			},
		})
	end,
}
