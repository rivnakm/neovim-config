-- Discourage bad habits in vim
return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		max_count = 5,
	},
}
