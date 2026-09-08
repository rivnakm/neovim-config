-- jj-vcs integration
return {
	"yannvanhalewyn/jujutsu.nvim",
	config = function()
		require("jujutsu-nvim").setup({
			diff_preset = "diffview",
		})
	end,
	keys = {
		{
			"<leader>nj",
			"<Cmd>JJ<CR>",
			noremap = true,
			silent = true,
			desc = "Jujutsu",
		},
	},
}
