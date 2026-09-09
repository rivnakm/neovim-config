-- Shows keybindings
return {
	"folke/which-key.nvim",
	event = "VimEnter",
	opts = {
		notify = false,
	},
	init = function()
		require("which-key").add({
			{ "<leader>a", group = "[A]gentic/y[A]zi" },
			{ "<leader>a_", hidden = true },
			{ "<leader>b", group = "[B]arbar" },
			{ "<leader>b_", hidden = true },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument/[D]iffview" },
			{ "<leader>d_", hidden = true },
			{ "<leader>n", group = "[N]eogit/[N]eogen" },
			{ "<leader>n_", hidden = true },
			{ "<leader>j", group = "[J]ujutsu/[Just]" },
			{ "<leader>j_", hidden = true },
			{ "<leader>p", group = "[P]eek" },
			{ "<leader>p_", hidden = true },
			{ "<leader>r", group = "[R]ename/[R]EST" },
			{ "<leader>r_", hidden = true },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>s_", hidden = true },
			{ "<leader>t", group = "[T]erminal" },
			{ "<leader>t_", hidden = true },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>w_", hidden = true },
		})
	end,
}
