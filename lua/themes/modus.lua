return {
	"miikanissi/modus-themes.nvim",
	priority = 1000,
	config = function()
		require("modus-themes").setup({
			style = "auto",
			variant = "default",

			---@param colors ColorScheme
			---@diagnostic disable-next-line: unused-local
			on_colors = function(colors) end,

			---@param highlights Highlights
			---@param colors ColorScheme
			on_highlights = function(highlights, colors)
				highlights.BufferVisible = { bg = colors.bg_inactive }
				highlights.BufferVisibleMod = { bg = colors.bg_inactive, fg = colors.warning }
				highlights.BufferVisibleModBtn = { bg = colors.bg_inactive, fg = colors.warning }
				highlights.BufferVisiblePin = { bg = colors.bg_inactive }
				highlights.BufferVisiblePinBtn = { bg = colors.bg_inactive }
				highlights.BufferVisibleSign = { bg = colors.bg_inactive }
				highlights.BufferVisibleTarget = { bg = colors.bg_inactive, fg = colors.red }
				highlights.BufferVisibleERROR = { bg = colors.bg_inactive, fg = colors.error }
				highlights.BufferVisibleWARN = { bg = colors.bg_inactive, fg = colors.warning }
			end,
		})
	end,
}
