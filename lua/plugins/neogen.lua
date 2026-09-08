-- Documentation annotation provider
return {
	"danymat/neogen",
	opts = {
		enabled = true,
		languages = {
			cs = {
				template = {
					annotation_convention = "xmldoc",
				},
			},
		},
	},
	keys = {
		{
			"<leader>nda",
			"<Cmd>Neogen<CR>",
			noremap = true,
			silent = true,
			desc = "[N]eogen [D]ocument [A]ny",
		},
		{
			"<leader>ndf",
			"<Cmd>Neogen func<CR>",
			noremap = true,
			silent = true,
			desc = "[N]eogen [D]ocument [F]unction",
		},
		{
			"<leader>ndc",
			"<Cmd>Neogen class<CR>",
			noremap = true,
			silent = true,
			desc = "[N]eogen [D]ocument [C]lass",
		},
		{
			"<leader>ndt",
			"<Cmd>Neogen type<CR>",
			noremap = true,
			silent = true,
			desc = "[N]eogen [D]ocument [T]ype",
		},
		{
			"<leader>ndi",
			"<Cmd>Neogen file<CR>",
			noremap = true,
			silent = true,
			desc = "[N]eogen [D]ocument F[i]le",
		},
	},
}
