require('maps')
require('settings')

if not vim.g.vscode then
	require('plugins')
end

vim.cmd('colorscheme github_dark_default')

