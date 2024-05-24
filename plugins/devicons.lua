return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		override_by_filename = {
			["go.mod"] = {
				icon = "󰟓",
				color = "#CE3262",
				name = "Go_Module",
			},
			["go.work"] = {
				icon = "󰟓",
				color = "#FDDD00",
				name = "Go_Workspace",
			},
		},
		override_by_extension = {
			["ebuild"] = {
				icon = "󰣨",
				color = "#4E4187",
				name = "Ebuild",
			},
			["go"] = {
				icon = "󰟓",
				color = "#00ADD8",
				name = "Go",
			},
		},
	},
}
