return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	event = "WinEnter",
	config = function()
		require("lualine").setup({
			extensions = { "lazy", "mason", "nvim-tree", "toggleterm" },
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				theme = "catppuccin",
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
		})
	end,
}
