return {
	"rachartier/tiny-cmdline.nvim",
	config = function()
		vim.o.cmdheight = 0
		require("tiny-cmdline").setup({
			position = {
				x = "50%",
				y = "25%",
			},
		})
	end,
}
