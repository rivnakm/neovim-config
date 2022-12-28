-- Use system clipboard
vim.api.nvim_set_option("clipboard","unnamedplus")

vim.o.number = true
vim.o.relativenumber = true
vim.wo.wrap = false

-- Automatically toggle between absolute and hybrid line numbers
local number_toggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd(
	{ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
	{
		callback = function()
			local window = vim.api.nvim_get_current_win()
			if vim.api.nvim_win_get_option(window, 'number') and vim.api.nvim_get_mode() ~= 'i' then
				vim.api.nvim_win_set_option(window, 'relativenumber', true)
			end
		end,
		group = number_toggle,
	}
)
vim.api.nvim_create_autocmd(
	{ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
	{
		callback = function()
			local window = vim.api.nvim_get_current_win()
			if vim.api.nvim_win_get_option(window, 'number') then
				vim.api.nvim_win_set_option(window, 'relativenumber', false)
			end
		end,
		group = number_toggle,
	}
)


if vim.g.neovide then
	-- Neovide-specific options
	vim.o.guifont = 'CascadiaMono Nerd Font Mono:11'
	vim.g.neovide_scale_factor = 0.8
end
