-- Nicer looking diagnostics
return {
	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	event = "BufEnter",
	config = function()
		require("lsp_lines").setup({})
		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = true,
		})
	end,
}
