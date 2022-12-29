-- Set leader key
vim.g.mapleader = ","

-- Quick exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Sane exit terminal mode
vim.keymap.set("t", "jj", "<C-\\><C-N>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { noremap = true, silent = true })

-- nvim-tree
vim.keymap.set("n", "<leader>ft", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>ff", "<Cmd>NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus file tree" })

-- barbar
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true, desc = "Move buffer left" })
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true, desc = "Move buffer right" })

-- Telescope
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles,
    { noremap = true, silent = true, desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers,
    { noremap = true, silent = true, desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { noremap = true, silent = true, desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files,
    { noremap = true, silent = true, desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags,
    { noremap = true, silent = true, desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string,
    { noremap = true, silent = true, desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep,
    { noremap = true, silent = true, desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics,
    { noremap = true, silent = true, desc = "[S]earch [D]iagnostics" })

-- Toggleterm
vim.keymap.set("n", "<leader>t", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true, desc = "Toggle [T]erminal" })

-- lsp-zero
vim.keymap.set("n", "<leader>fr", "<Cmd>LspZeroFormat<CR>", { noremap = true, silent = true, desc = "[F]o[R]mat file" })
