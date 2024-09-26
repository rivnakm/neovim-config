-- Disable netrw since we're using nvim-tree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Neovide settings
local padding = 3
vim.g.neovide_padding_top = padding
vim.g.neovide_padding_bottom = padding
vim.g.neovide_padding_right = padding
vim.g.neovide_padding_left = padding

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable mouse
-- vim.opt.mouse = ""

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Tab settings
vim.o.tabstop = 4 -- \t renders as 4 spaces
vim.o.expandtab = true -- Pressing Tab will insert spaces instead of \t
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

local set_file_tab_width = function(pattern, width)
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = pattern,
		callback = function()
			vim.opt_local.shiftwidth = width
			vim.opt_local.tabstop = width
		end,
	})
end

set_file_tab_width("*.html", 2)
set_file_tab_width("*.vue", 2)
set_file_tab_width("*.lua", 2)
set_file_tab_width("*.hpp", 4) -- vim-sleuth gets confused with my clang-format settings
set_file_tab_width("*.cpp", 4)
set_file_tab_width("*.java", 4) -- jdt.ls is weird
set_file_tab_width("CMakeLists.txt", 2)

-- Automatically toggle between absolute and hybrid line numbers
local number_toggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	callback = function()
		local window_id = vim.fn.win_getid()
		if vim.api.nvim_get_option_value("number", { win = window_id }) and vim.api.nvim_get_mode() ~= "i" then
			vim.api.nvim_set_option_value("relativenumber", true, { win = window_id })
		end
	end,
	group = number_toggle,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	callback = function()
		local window_id = vim.fn.win_getid()
		if vim.api.nvim_get_option_value("number", { win = window_id }) then
			vim.api.nvim_set_option_value("relativenumber", false, { win = window_id })
		end
	end,
	group = number_toggle,
})

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
-- Quick exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Format Command ]]
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })
vim.keymap.set("n", "<leader>cf", "<Cmd>Format<CR>", { desc = "[C]ode [F]ormat" })

-- [[ Windows shell setup ]]
if vim.fn.has("win32") == 1 then
	-- Use powershell 7
	vim.opt.shell = "pwsh"
	vim.opt.shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
	vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
	vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
	vim.opt.shellquote = ""
	vim.opt.shellxquote = ""
end

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
	-- Language Servers, Highlighting, Formatting
	require("plugins.lsp-config"),
	require("plugins.treesitter"),
	require("plugins.conform"),

	-- Debugging
	require("plugins.dap"),
	require("plugins.dap-ui"),

	-- Completion and Snippets
	require("plugins.completion"),
	require("plugins.copilot"),

	-- UI
	require("plugins.git-signs"),
	require("plugins.startup"),
	require("plugins.nvim-tree"),
	require("plugins.lualine"),
	require("plugins.barbar"),
	require("plugins.neogit"),
	require("plugins.toggleterm"),
	require("plugins.scrollbar"),
	require("plugins.scrollEOF"),
	require("plugins.glow"),
	require("plugins.highlight-color"),

	-- Usability
	require("plugins.cutlass"),
	require("plugins.substitute"),
	require("plugins.yanky"),
	require("plugins.stay-in-place"),
	require("plugins.possession"),
	require("plugins.vim-sleuth"),
	require("plugins.which-key"),
	require("plugins.telescope"),
	require("plugins.todo-comments"),
	require("plugins.mini"),

	-- Icons
	require("plugins.devicons"),

	-- Colorschemes
	require("themes.catppuccin"),
}, {})
