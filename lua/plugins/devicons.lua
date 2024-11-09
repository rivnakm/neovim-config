return {
	"nvim-tree/nvim-web-devicons",
	opts = {
		override_by_filename = {
			["Cargo.toml"] = {
				icon = "󱘗",
				color = "#CCCCCC",
				name = "Cargo_Manifest",
			},
			["Directory.Packages.props"] = {
				icon = "󰘐",
				color = "#5128D4",
				name = "Dotnet_Packages",
			},
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
			["cs"] = {
				icon = "󰌛",
				color = "#5128D4",
				name = "Csharp",
			},
			["csproj"] = {
				icon = "󰌛",
				color = "#9780E5",
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
			["js"] = {
				icon = "󰌞",
				color = "#F7DF1E",
				name = "Javascript",
			},
			["rs"] = {
				icon = "󱘗",
				color = "#FF4300",
				name = "Rust",
			},
			["sln"] = {
				icon = "󰘐",
				color = "#5128D4",
				name = "Visualstudio_Solution",
			},
			["ts"] = {
				icon = "󰛦",
				color = "#3178C6",
				name = "Typescript",
			},
		},
	},
}
