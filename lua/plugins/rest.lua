-- Curl wrapper for .http files
return {
	"rest-nvim/rest.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
	},
	config = function()
		vim.keymap.set("n", "<leader>re", "<Cmd>Rest run<CR>", { desc = "Execute HTTP request" })
	end,
}
