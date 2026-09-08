-- Status line
return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		extensions = { "lazy", "mason", "nvim-tree" },
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = false,
			disabled_filetypes = { "NVimTree", "NeogitStatus" },
			ignore_focus = { "NVimTree", "NeogitStatus" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "branch", icon = "" } },
			lualine_c = {
				"diff",
				{
					"diagnostics",
					sources = { "nvim_lsp" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
				},
			},
			lualine_x = { "encoding", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
