return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup()

		require("which-key").register({
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>t"] = { name = "nvim-[T]ree/[T]erminal", _ = "which_key_ignore" },
			["<leader>b"] = { name = "[B]arbar", _ = "which_key_ignore" },
			["<leader>o"] = { name = "P[o]ssession", _ = "which_key_ignore" },
			["<leader>p"] = { name = "[P]eek", _ = "which_key_ignore" },
		})
	end,
}
