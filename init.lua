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
vim.opt.mouse = ""

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

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

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

-- [[ Basic code commands ]]
local build_code = function()
	local filetype = vim.bo.filetype
	if filetype == "rust" then
		vim.cmd("w")
		vim.cmd("1TermExec cmd='cargo build'")
	elseif filetype == "zig" then
		vim.cmd("w")
		vim.cmd("1TermExec cmd='zig build'")
	end
end

local run_code = function()
	local filetype = vim.bo.filetype
	if filetype == "rust" then
		vim.cmd("w")
		vim.cmd("1TermExec cmd='cargo run'")
	elseif filetype == "zig" then
		vim.cmd("w")
		vim.cmd("1TermExec cmd='zig build run'")
	end
end

local test_code = function()
	local filetype = vim.bo.filetype
	if filetype == "rust" then
		vim.cmd("w")
		vim.cmd("1TermExec cmd='cargo test'")
	elseif filetype == "zig" then
		vim.cmd("w")
		vim.cmd("1TermExec cmd='zig build test'")
	end
end

vim.keymap.set("n", "<leader>xb", build_code, { desc = "[B]uild code" })
vim.keymap.set("n", "<leader>xr", run_code, { desc = "[R]un code" })
vim.keymap.set("n", "<leader>xt", test_code, { desc = "[T]est code" })

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()

			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
				["<leader>t"] = { name = "nvim-[T]ree/[T]erminal", _ = "which_key_ignore" },
				["<leader>b"] = { name = "[B]arbar", _ = "which_key_ignore" },
				["<leader>p"] = { name = "[P]ossession", _ = "which_key_ignore" },
				["<leader>x"] = { name = "Code E[X]ecution", _ = "which_key_ignore" },
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				-- TODO: this doesn't work on windows
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of help_tags options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable telescope extensions, if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "[S]earch Select [T]elescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- Also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself
					-- many times.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					map("<leader>rr", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					--  See `:help K` for why this keymap
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local on_attach = function(client, buffer_no)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(buffer_no, true)
				end
			end

			-- Language servers managed by the system
			local servers = {
				pyright = {},
				clangd = {
					cmd = {
						"clangd",
						"--background-index",
						"--suggest-missing-includes",
						"--clang-tidy",
						"--cross-file-rename",
						"--header-insertion=iwyu",
						"--completion-style=bundled",
						"--fallback-style=Microsoft",
					},
					init_options = {
						clangdFileStatus = true,
						usePlaceholders = true,
						completeUnimported = true,
						semanticHighlighting = true,
					},
				},
				gopls = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
				zls = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
			}

			for server_name, server in pairs(servers) do
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				server.on_attach = on_attach
				require("lspconfig")[server_name].setup(server)
			end

			-- Language servers managed by mason
			local mason_servers = {
				cmake = {}, -- lsp
				cmakelang = {}, -- formatter
				fsautocomplete = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
								-- If lua_ls is really slow on your computer, you can try this instead:
								-- library = { vim.env.VIMRUNTIME },
							},
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(mason_servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = mason_servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						server.on_attach = on_attach
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { { "prettierd", "prettier" } },
			},
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets
					-- This step is not supported in many windows environments
					-- Remove the below condition to re-enable on windows
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",

			-- If you want to add a bunch of pre-configured snippets,
			--    you can use this plugin to help you. It even has snippets
			--    for various frameworks/libraries/etc. but you will have to
			--    set up the ones that are useful for you.
			-- 'rafamadriz/friendly-snippets',
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},

	-- Colorschemes
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		flavour = "mocha",
		config = function()
			require("catppuccin").setup({
				term_colors = true,
				color_overrides = {
					mocha = {
						base = "#141417",
						mantle = "#101010",
						crust = "#0C0C0C",
					},
				},
				highlight_overrides = {
					mocha = function(_)
						return {
							NeogitDiffContextHighlight = { bg = "#272734" },
							NeogitCursorLine = { bg = "#272734" },
						}
					end,
				},
				integrations = {
					barbar = true,
					dashboard = true,
					neogit = true,
					cmp = true,
					dap = true,
					dap_ui = true,
					telescope = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			signs = false,
			keywords = {
				TODO = { alt = { "todo!()" } },
			},
		},
	},

	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()

			require("mini.comment").setup()

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"c_sharp",
					"cmake",
					"cpp",
					"css",
					"csv",
					"dockerfile",
					"gdscript",
					"gitattributes",
					"gitignore",
					"go",
					"gomod",
					"html",
					"javascript",
					"json",
					"json5",
					"latex",
					"lua",
					"make",
					"markdown",
					"python",
					"ron",
					"rust",
					"sql",
					"toml",
					"typescript",
					"vim",
					"vimdoc",
					"vue",
					"wgsl",
					"wgsl_bevy",
					"xml",
					"yaml",
					"zig",
				},
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons",
				opts = {
					override_by_filename = {
						["go.mod"] = {
							icon = "󰟓",
							color = "#CE3262",
							name = "Go_Module",
						},
						["go.work"] = {
							icon = "󰟓",
							color = "#FDDD00",
							name = "Go_Workspace",
						},
					},
					override_by_extension = {
						["go"] = {
							icon = "󰟓",
							color = "#00ADD8",
							name = "Go",
						},
					},
				},
			},
		},
		config = function()
			require("nvim-tree").setup({
				actions = {
					change_dir = {
						global = true,
					},
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = false,
				},
				git = {
					enable = false,
				},
				renderer = {
					icons = {
						show = {
							git = false,
						},
					},
				},
				sync_root_with_cwd = true,
				view = {
					width = 40,
				},
			})
			local api = require("nvim-tree.api")
			vim.keymap.set("n", "<leader>to", api.tree.open, { desc = "Open nvim-tree" })
			vim.keymap.set("n", "<leader>tc", api.tree.close, { desc = "Close nvim-tree" })
			vim.keymap.set("n", "<leader>tt", api.tree.toggle, { desc = "Toggle nvim-tree" })
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<C-c>a",
						dismiss = "<C-c>d",
					},
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		event = "WinEnter",
		config = function()
			require("lualine").setup({
				extensions = { "lazy", "mason", "nvim-tree", "toggleterm" },
				options = {
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					theme = "catppuccin",
					globalstatus = false,
					disabled_filetypes = { "NVimTree", "NeogitStatus" },
					ignore_focus = { "NVimTree", "NeogitStatus" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { { "branch", icon = "" } },
					lualine_c = {
						"diff",
						{
							"diagnostics",
							sources = { "nvim_lsp" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
					},
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		event = "BufEnter",
		config = function()
			vim.keymap.set(
				"n",
				"<leader>bn",
				"<Cmd>BufferNext<CR>",
				{ noremap = true, silent = true, desc = "Next tab" }
			)
			vim.keymap.set(
				"n",
				"<leader>bp",
				"<Cmd>BufferPrevious<CR>",
				{ noremap = true, silent = true, desc = "Previous tab" }
			)
			vim.keymap.set("n", "<leader>bx", "<Cmd>BufferPin<CR>", { noremap = true, silent = true, desc = "Pin tab" })
			vim.keymap.set(
				"n",
				"<leader>bc",
				"<Cmd>BufferClose<CR>",
				{ noremap = true, silent = true, desc = "Close tab" }
			)
			vim.keymap.set(
				"n",
				"<leader>bd",
				"<Cmd>BufferDelete<CR>",
				{ noremap = true, silent = true, desc = "Delete tab" }
			)

			require("barbar").setup({
				sidebar_filetypes = {
					NvimTree = true,
				},
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			"nvim-telescope/telescope.nvim", -- optional
		},
		config = true,
	},
	{
		"akinsho/toggleterm.nvim",
		event = "WinEnter",
		config = function()
			local size = vim.api.nvim_get_option_value("columns", {}) * 0.35
			-- if vim.g.neovide then
			-- 	size = 100
			-- end

			require("toggleterm").setup({
				size = size,
				-- open_mapping = [[<leader>tj]],
				insert_mappings = false,
				autochdir = true,
				direction = "vertical",
				shade_terminals = false,
				persist_size = true,
			})

			-- setting this in the toggleterm config doesn't work properly with using space as a leader key
			vim.keymap.set(
				"n",
				"<leader>tj",
				"<Cmd>ToggleTerm<CR>",
				{ noremap = true, silent = true, desc = "Toggle terminal" }
			)
		end,
	},
	{
		"startup-nvim/startup.nvim",
		dependencies = {
			"telescope-nvim/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		-- event = "VimEnter",
		config = function()
			local header = {}
			if vim.g.neovide then
				header = {
					"",
					"███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ██████╗  ███████╗",
					"████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ██╔══██╗ ██╔════╝",
					"██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██║  ██║ █████╗  ",
					"██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║  ██║ ██╔══╝  ",
					"██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██████╔╝ ███████╗",
					"╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═════╝  ╚══════╝",
					"",
				}
			else
				header = {
					"",
					"███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
					"████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
					"██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
					"██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
					"██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
					"╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					"",
				}
			end
			require("startup").setup({
				header = {
					type = "text",
					oldfiles_directory = false,
					align = "center",
					fold_section = false,
					title = "Header",
					margin = 5,
					content = header,
					highlight = "Statement",
					default_color = "",
					oldfiles_amount = 0,
				},
				-- name which will be displayed and command
				body = {
					type = "mapping",
					oldfiles_directory = false,
					align = "center",
					fold_section = false,
					title = "Basic Commands",
					margin = 5,
					content = {
						{ "󱋡 Recent Files", "Telescope oldfiles", "<leader>s." },
						{ "󰪺 Recent Sessions", "Telescope possession list", "<leader>ss" },
						{ "󰱼 Search Files", "Telescope find_files", "<leader>sf" },
						{ "󱎸 Search with Grep", "Telescope live_grep", "<leader>sg" },
						{ "󰦅 Search Keymaps", "Telescope keymaps", "<leader>sk" },
					},
					highlight = "String",
					default_color = "",
					oldfiles_amount = 0,
				},
				footer = {
					type = "text",
					oldfiles_directory = false,
					align = "center",
					fold_section = false,
					title = "Footer",
					margin = 5,
					content = { "startup.nvim" },
					highlight = "Number",
					default_color = "",
					oldfiles_amount = 0,
				},

				options = {
					mapping_keys = true,
					cursor_column = 0.5,
					empty_lines_between_mappings = true,
					disable_statuslines = true,
					paddings = { 1, 3, 3, 0 },
				},
				mappings = {
					execute_command = "<CR>",
					open_file = "o",
					open_file_split = "<c-o>",
					open_section = "<TAB>",
					open_help = "?",
				},
				colors = {
					background = "#1f2227",
					folded_section = "#56b6c2",
				},
				parts = { "header", "body", "footer" },
			})
			vim.api.nvim_create_autocmd({ "BufLeave" }, {
				callback = function()
					vim.api.nvim_set_option_value("showtabline", 2, {})
				end,
				group = number_toggle,
			})
		end,
	},
	{
		"jedrzejboczar/possession.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("possession").setup({
				hooks = {
					-- before_save = function()
					-- 	local windows = vim.api.nvim_list_wins()
					-- 	for _, win in ipairs(windows) do
					-- 		local buf = vim.api.nvim_win_get_buf(win)
					-- 		if string.find(vim.api.nvim_buf_get_name(buf), "toggleterm") ~= nil then
					-- 			vim.api.nvim_win_close(win, true)
					-- 		end
					-- 	end
					--
					-- 	return {}
					-- end,
					before_load = function()
						local bufs = vim.api.nvim_list_bufs()
						for _, buf in ipairs(bufs) do
							if string.find(vim.api.nvim_buf_get_name(buf), "toggleterm") ~= nil then
								vim.api.nvim_buf_delete(buf, { force = true })
							end
						end

						return {}
					end,
				},
			})
			require("telescope").load_extension("possession")
			local save_session = function()
				local session_name = require("possession.session").session_name or vim.fn.input("Session name: ")
				if session_name ~= "" then
					require("possession.session").save(session_name)
				end
			end
			local delete_session = function()
				local session_name = require("possession.session").session_name or ""
				if session_name ~= "" then
					require("possession.session").delete(session_name)
				end
			end

			vim.keymap.set(
				"n",
				"<leader>ss",
				require("telescope").extensions.possession.list,
				{ desc = "[S]earch [S]essions" }
			)
			vim.keymap.set("n", "<leader>pd", delete_session, { desc = "[P]ossession [D]elete" })
			vim.keymap.set("n", "<leader>ps", save_session, { desc = "[P]ossession [S]ave" })
		end,
	},
	{
		"https://git.sr.ht/~nedia/auto-save.nvim",
		opts = {
			events = { "InsertLeave", "BufLeave" },
			exclude_ft = { "NVimTree", "ToggleTerm" },
		},
	},
	{
		"Aasim-A/scrollEOF.nvim",
		event = { "CursorMoved", "WinScrolled" },
		opts = {},
	},
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	{ "brenoprata10/nvim-highlight-colors", opts = {
		enable_tailwind = true,
	} },
}, {})
