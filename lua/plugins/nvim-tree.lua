return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			actions = {
				change_dir = {
					global = true,
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = false,
			},
			git = {
				enable = false,
			},
			renderer = {
				icons = {
					show = {
						git = false,
					},
				},
				special_files = {},
				symlink_destination = false,
			},
			sync_root_with_cwd = true,
			view = {
				width = 40,
			},
		})
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<leader>to", api.tree.open, { desc = "Open nvim-tree" })
		vim.keymap.set("n", "<leader>tc", api.tree.close, { desc = "Close nvim-tree" })
		vim.keymap.set("n", "<leader>tt", api.tree.toggle, { desc = "Toggle nvim-tree" })
	end,
}
