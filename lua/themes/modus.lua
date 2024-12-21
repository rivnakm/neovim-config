return {
	"miikanissi/modus-themes.nvim",
	priority = 1000,
	config = function()
		require("modus-themes").setup({
			style = "modus_vivendi",
			variant = "default",

			---@param colors ColorScheme
			---@diagnostic disable-next-line: unused-local
			on_colors = function(colors) end,

			---@param highlights Highlights
			---@param colors ColorScheme
			on_highlights = function(highlights, colors)
				highlights.BufferVisible = { bg = colors.bg_inactive }
				highlights.BufferVisibleSign = { bg = colors.bg_inactive }
			end,
		})
		vim.cmd.colorscheme("modus_vivendi")
	end,
}
