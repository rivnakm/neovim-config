return {
	"akinsho/toggleterm.nvim",
	event = "WinEnter",
	config = function()
		local size = vim.api.nvim_get_option_value("columns", {}) * 0.35
		-- if vim.g.neovide then
		-- 	size = 100
		-- end

		require("toggleterm").setup({
			size = size,
			-- open_mapping = [[<leader>tj]],
			insert_mappings = false,
			autochdir = true,
			direction = "vertical",
			shade_terminals = false,
			persist_size = true,
		})

		-- setting this in the toggleterm config doesn't work properly with using space as a leader key
		vim.keymap.set(
			"n",
			"<leader>tj",
			"<Cmd>ToggleTerm<CR>",
			{ noremap = true, silent = true, desc = "Toggle terminal" }
		)
	end,
}
