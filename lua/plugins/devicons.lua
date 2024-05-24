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
			["Cargo.toml"] = {
				icon = "",
				color = "#CCCCCC",
				name = "Cargo_Manifest",
			},
		},
		override_by_extension = {
			["cs"] = {
				icon = "󰌛",
				color = "#4300C0",
				name = "Csharp",
			},
			["csproj"] = {
				icon = "󰌛",
				color = "#CCCCCC",
				name = "Csharp_Project",
			},
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
			["rs"] = {
				icon = "",
				color = "#FF4300",
				name = "Rust",
			},
			["sln"] = {
				icon = "󰘐",
				color = "#4300C0",
				name = "Visualstudio_Solution",
			},
			["ts"] = {
				icon = "",
				color = "#3178C6",
				name = "Typescript",
			},
		},
	},
}
