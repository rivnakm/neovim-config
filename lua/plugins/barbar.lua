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
		vim.keymap.set("n", "<leader>bn", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next tab" })
		vim.keymap.set(
			"n",
			"<leader>bp",
			"<Cmd>BufferPrevious<CR>",
			{ noremap = true, silent = true, desc = "Previous tab" }
		)
		vim.keymap.set("n", "<leader>bx", "<Cmd>BufferPin<CR>", { noremap = true, silent = true, desc = "Pin tab" })
		vim.keymap.set("n", "<leader>bc", "<Cmd>BufferClose<CR>", { noremap = true, silent = true, desc = "Close tab" })
		vim.keymap.set(
			"n",
			"<leader>bd",
			"<Cmd>BufferDelete<CR>",
			{ noremap = true, silent = true, desc = "Delete tab" }
		)

		require("barbar").setup({
			sidebar_filetypes = {
				NvimTree = true,
			},
		})
	end,
}
