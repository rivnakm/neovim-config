return {
	"gbprod/yanky.nvim",
	config = function()
		require("yanky").setup({
			highlight = {
				on_yank = true,
				on_put = true,
				timer = 250,
			},
		})
		vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")
		vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
		vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
		vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")

		vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
		vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
		vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
		vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

		vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
		vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
		vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
		vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")
		vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
	end,
}
