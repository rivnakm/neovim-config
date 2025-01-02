-- Shows keybindings
return {
	"folke/which-key.nvim",
	event = "VimEnter",
	config = function()
		require("which-key").setup({
			notify = false,
		})

		require("which-key").register({
			["<leader>b"] = { name = "[B]arbar", _ = "which_key_ignore" },
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument/[D]iffview", _ = "which_key_ignore" },
			["<leader>n"] = { name = "[N]eogit/[N]eogen", _ = "which_key_ignore" },
			["<leader>o"] = { name = "P[o]ssession", _ = "which_key_ignore" },
			["<leader>p"] = { name = "[P]eek", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename/[R]EST", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>t"] = { name = "nvim-[T]ree/[T]erminal", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
		})
	end,
}
