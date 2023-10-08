local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") ..
        "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim", install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        requires = { "p00f/nvim-ts-rainbow", opt = false },
        run = function()
            local ts_update = require("nvim-treesitter.install").update({
                with_sync = true
            })
            ts_update()
        end,
        config = function()
            require "nvim-treesitter.configs".setup {
                -- A list of parser names, or "all"
                ensure_installed = {
                    "bash", "fish", "gitcommit", "gitignore", "javascript",
                    "json", "lua", "make", "markdown", "python", "rust",
                    "svelte", "toml", "typescript"
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                    -- the name of the parser)
                    -- list of language that will be disabled
                    disable = { "c", "rust" },
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats =
                        pcall(vim.loop.fs_stat,
                            vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false
                },

                rainbow = {
                    enable = true,
                    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                    max_file_lines = nil, -- Do not enable for files with more than n lines, int
                    colors = {
                        "#ff5454", "#54ff54", "#ffff54", "#5454ff", "#ff54ff"
                    } -- table of hex strings
                    -- termcolors = {} -- table of colour name strings
                }
            }
        end
    })

    -- Treesitter text objects
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require "nvim-treesitter.configs".setup {
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        },
                        -- You can choose the select mode (default is charwise "v")
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg "@function.inner"
                        -- * method: eg "v" or "o"
                        -- and should return the mode ("v", "V", or "<c-v>") or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ["@parameter.outer"] = "v", -- charwise
                            ["@function.outer"] = "V", -- linewise
                            ["@class.outer"] = "<c-v>", -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg "@function.inner"
                        -- * selection_mode: eg "v"
                        -- and should return true of false
                        include_surrounding_whitespace = true,
                    },
                },
            }
        end,
    })

    -- LSP Config
    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.setup()
        end
    })

    -- Rust tools
    use({
        "simrat39/rust-tools.nvim",
        requires = { "neovim/nvim-lspconfig" },
        config = function()
            require("rust-tools").setup({
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            inlayHints = { locationLinks = false }, -- workaround for https://github.com/simrat39/rust-tools.nvim/issues/300
                        },
                    },
                },
            })
        end
    })

    -- Devicons
    use("nvim-tree/nvim-web-devicons")

    -- Galaxyline
    use({
        "NTBBloodbath/galaxyline.nvim",
        -- your statusline
        config = function()
            require("galaxyline.theme")
        end,
        -- some optional icons
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    })

    -- Barbar
    use({
        "romgrk/barbar.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    })

    -- nvim-tree
    use({
        "nvim-tree/nvim-tree.lua",
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
        tag = "nightly",
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true

            require("nvim-tree").setup({
                sort_by = "case_sensitive",
                view = {
                    adaptive_size = true,
                    mappings = { list = { { key = "u", action = "dir_up" } } }
                },
                renderer = { group_empty = true },
                filters = { dotfiles = true }
            })
        end
    })

    -- Fuzzy Finder (files, lsp, etc)
    use({
        "nvim-telescope/telescope.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup {
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false,
                            ["<C-d>"] = false,
                        },
                    },
                },
            }
        end
    })

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        cond = vim.fn.executable "make" == 1,
        config = function() pcall(require("telescope").load_extension, "fzf") end
    })

    -- Dashboard
    use({
        "glepnir/dashboard-nvim",
        config = function()
            local db = require("dashboard")
            -- Neovim logo
            if vim.g.neovide then
                db.custom_header = {
                    "",
                    "███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ██████╗  ███████╗",
                    "████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ██╔══██╗ ██╔════╝",
                    "██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██║  ██║ █████╗  ",
                    "██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║  ██║ ██╔══╝  ",
                    "██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██████╔╝ ███████╗",
                    "╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═════╝  ╚══════╝",
                    ""
                }
            else
                db.custom_header = {
                    "",
                    "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
                    "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
                    "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
                    "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
                    "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
                    "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
                    ""
                }
            end
            db.custom_center = {
                { icon = '  ',
                    desc = 'Recently opened files                   ',
                    action = 'Telescope oldfiles',
                    shortcut = ',sr' },
                { icon = '  ',
                    desc = 'Find File                               ',
                    action = 'Telescope find_files find_command=rg,--hidden,--files',
                    shortcut = ',sf' },
                { icon = '  ',
                    desc = 'Terminal                                ',
                    action = 'ToggleTerm',
                    shortcut = ',tt' },
            }
        end
    })

    -- Toggleterm
    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("toggleterm").setup({
                size = vim.o.columns * 0.3,
                direction = "vertical"
            })
        end
    })

    -- autopairs
    use({
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup() end
    })

    -- tabset
    use({
        "FotiadisM/tabset.nvim",
        config = function()
            require("tabset").setup({
                defaults = { tabwidth = 4, expandtab = true },
                languages = {
                    {
                        filetypes = {
                            "javascript", "typescript", "svelte", "vue", "json",
                            "yaml", "toml"
                        },
                        config = { tabwidth = 2 }
                    }
                }
            })
        end
    })

    -- nvim-colorizer
    use({
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                filetypes = {
                    "lua", "css", "html", "javascript", "typescript", "react",
                    "svelte", "vue"
                },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = false, -- "Name" codes like Blue or blue
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    AARRGGBB = false, -- 0xAARRGGBB hex codes
                    rgb_fn = true, -- CSS rgb() and rgba() functions
                    hsl_fn = true, -- CSS hsl() and hsla() functions
                    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = "background", -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = true, -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    virtualtext = "■"
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {}
            })
        end
    })

    -- nvim-cursorline
    use({
        "yamatsum/nvim-cursorline",
        config = function()
            require("nvim-cursorline").setup {
                cursorline = { enable = true, timeout = 10, number = false },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true }
                }
            }
        end
    })

    -- range-highlight
    use({
        "winston0410/range-highlight.nvim",
        requires = { "winston0410/cmd-parser.nvim" },
        config = function() require("range-highlight").setup {} end
    })

    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                mappings = { extra = false }
            })
        end
    })

    -- scrollbar
    use({
        "petertriho/nvim-scrollbar",
        config = function() require("scrollbar").setup {} end
    })

    -- Bootstrap packer
    if packer_bootstrap then require("packer").sync() end
end)
