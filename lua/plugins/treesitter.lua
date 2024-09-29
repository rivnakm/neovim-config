return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"c_sharp",
				"cmake",
				"cpp",
				"css",
				"csv",
				"dockerfile",
				"gdscript",
				"gitattributes",
				"gitignore",
				"go",
				"gomod",
				"html",
				"javascript",
				"json",
				"json5",
				"latex",
				"lua",
				"make",
				"markdown",
				"ocaml",
				"python",
				"ron",
				"rust",
				"sql",
				"toml",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"wgsl",
				"wgsl_bevy",
				"xml",
				"yaml",
				"zig",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.fsharp = {
			install_info = {
				url = "https://github.com/ionide/tree-sitter-fsharp",
				branch = "main",
				files = { "src/scanner.c", "src/parser.c" },
				location = "fsharp",
			},
			requires_generate_from_grammar = false,
			filetype = "fsharp",
		}
	end,
}
