-- Improved syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"asm",
				"bash",
				"c",
				"c_sharp",
				"cmake",
				"cpp",
				"css",
				"csv",
				"dockerfile",
				"doxygen",
				"editorconfig",
				"elixir",
				"fsharp",
				"gdscript",
				"gitattributes",
				"gitignore",
				"go",
				"gomod",
				"haskell",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"json5",
				"latex",
				"llvm",
				"lua",
				"make",
				"markdown",
				"ocaml",
				"powershell",
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
	end,
}
