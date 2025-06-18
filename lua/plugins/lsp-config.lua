-- Language server config
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

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
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rr", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("<leader>pd", vim.lsp.buf.hover, "[P]eek [D]efinition")
				map("<leader>ps", vim.lsp.buf.signature_help, "[P]eek [S]ignature")

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

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- for nvim-ufo
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		-- make sure registration is available when on_attach runs
		capabilities.textDocument.inlayHint.dynamicRegistration = false

		local on_attach = function(client, buffer_no)
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true, { bufnr = buffer_no })
			end
		end

		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:crashdummyy/mason-registry",
			},
		})

		require("mason-lspconfig").setup({
			automatic_installation = false,
			automatic_enable = true,
			ensure_installed = {
				"ansiblels",
				"astro",
				"basedpyright",
				"bashls",
				"cssls",
				"cucumber_language_server",
				"html",
				"powershell_es",
				"terraformls",
				"vue_ls",
			},
		})

		-- Vue language server setup
		-- https://github.com/vuejs/language-tools/wiki/Neovim
		-- https://kosu.me/blog/breaking-changes-in-mason-2-0-how-i-updated-my-neovim-lsp-config
		local vue_ls_path = vim.fn.expand("$MASON/packages") .. "/vue-language-server/node_modules/@vue/language-server"

		-- Language server configurations
		local servers = {
			ansiblels = {},
			astro = {},
			basedpyright = {
				settings = {
					basedpyright = {
						analysis = {
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			},
			bashls = {},
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
					"--offset-encoding=utf-16",
				},
				init_options = {
					clangdFileStatus = true,
					usePlaceholders = true,
					completeUnimported = true,
					semanticHighlighting = true,
				},
			},
			cmake = {}, -- lsp
			csharp_ls = {},
			cssls = {},
			cucumber_language_server = {
				settings = {
					cucumber = {
						features = {
							"**/Features/**/*.feature",
						},
						glue = {
							"**/Steps/**/*.cs",
						},
					},
				},
			},
			djlsp = {}, -- django-template-lsp in Mason
			fish_lsp = {},
			fsautocomplete = {},
			gopls = {
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
			html = {
				init_options = {
					provideFormatter = false,
				},
			},
			lua_ls = {
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
			markuplint = {},
			powershell_es = {
				bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
			},
			prettierd = {},
			ocamllsp = {},
			qmlls = {
				cmd = { "qmlls" },
			},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						checkOnSave = true,
						check = {
							command = "clippy",
						},
					},
				},
			},
			stylua = {},
			taplo = {},
			terraformls = {},
			vue_ls = {
				init_options = {
					typescript = {
						tsserverRequestCommand = {
							"typescript.tsserverRequest",
							"typescript.tsserverResponse",
						},
					},
				},
				on_init = function(client)
					client.handlers["typescript.tsserverRequest"] = function(_, result, context)
						local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
						if #clients == 0 then
							vim.notify(
								"Could not found `vtsls` lsp client, vue_lsp would not work with it.",
								vim.log.levels.ERROR
							)
							return
						end
						local ts_client = clients[1]

						local param = unpack(result)
						local command, payload, id = unpack(param)
						ts_client:exec_cmd({
							command = "typescript.tsserverRequest",
							arguments = {
								command,
								payload,
							},
						}, { bufnr = context.bufnr }, function(_, r)
							local response_data = { { id, r.body } }
							---@diagnostic disable-next-line: param-type-mismatch
							client:notify("typescript.tsserverResponse", response_data)
						end)
					end
				end,
			},
			vtsls = {
				filetypes = { "typescript", "javascript", "vue" },
				settings = {
					vtsls = { tsserver = { globalPlugins = {} } },
				},
				before_init = function(params, config)
					local result = vim.system(
						{ "npm", "query", "#vue" },
						{ cwd = params.workspaceFolders[1].name, text = true }
					)
						:wait()
					if result.stdout ~= "[]" then
						local vuePluginConfig = {
							name = "@vue/typescript-plugin",
							location = vue_ls_path,
							languages = { "vue" },
							configNamespace = "typescript",
							enableForWorkspaceTypeScriptVersions = true,
						}
						table.insert(config.settings.vtsls.tsserver.globalPlugins, vuePluginConfig)
					end
				end,
			},
			zls = {
				settings = {
					zls = {
						enable_build_on_save = true,
						build_on_save_step = "check",
					},
				},
			},
		}

		-- Configure servers
		for server_name, server_config in pairs(servers) do
			server_config.capabilities =
				vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
			server_config.on_attach = on_attach
			vim.lsp.config(server_name, server_config)
			vim.lsp.enable(server_name)
		end

		-- Stop ZLS from showing errors in a separate buffer
		-- https://github.com/zigtools/zls/issues/856#issuecomment-1511528925
		vim.g.zig_fmt_parse_errors = 0
	end,
}
