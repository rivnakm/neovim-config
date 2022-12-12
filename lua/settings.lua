-- Use system clipboard
vim.api.nvim_set_option("clipboard","unnamedplus")

if vim.g.neovide then
	-- Neovide-specific options
	vim.o.guifont = 'CascadiaMono Nerd Font Mono:11'
	vim.g.neovide_scale_factor = 0.8
end
