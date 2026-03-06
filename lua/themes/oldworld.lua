return {
	"dgox16/oldworld.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("oldworld").setup({
			integrations = {
				neogit = true,
				notify = true,
				flash = true,
			},
			highlight_overrides = {
				-- barbar tab bar
				BufferCurrent = { fg = "#c9c7cd", bg = "#161617" },
				BufferCurrentMod = { fg = "#e6b99d", bg = "#161617" },
				BufferInactive = { fg = "#6c6874", bg = "#1b1b1c" },
				BufferAlternate = { bg = "#1b1b1c" },
				BufferVisible = { bg = "#1b1b1c" },
			},
		})
		vim.cmd.colorscheme("oldworld")
	end,
}
