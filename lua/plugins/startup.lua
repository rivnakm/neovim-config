return {
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
		})
	end,
}
