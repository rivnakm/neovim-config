-- Set leader key
vim.g.mapleader = ","

-- Quick exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Sane exit terminal mode
vim.keymap.set("t", "jj", "<C-\\><C-N>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { noremap = true, silent = true })

-- barbar keymaps
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true })

-- Toggleterm
vim.keymap.set("n", "<leader>t", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })

