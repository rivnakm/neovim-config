-- Debug Adapter Protocol
return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		-- Jump to the stopped line without overwriting the dap-view window (see :h dap-view-faq)
		dap.defaults.fallback.switchbuf = "usevisible,usetab,newtab"

		-- Debug keymaps
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle [B]reakpoint" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Toggle conditional [B]reakpoint" })
		vim.keymap.set("n", "<leader>du", function()
			require("dap-view").toggle()
		end, { desc = "Debug: Toggle [U]I" })
		vim.keymap.set({ "n", "v" }, "<leader>dw", function()
			require("dap-view").add_expr()
		end, { desc = "Debug: Add [W]atch expression" })

		local function prompt_program()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end

		-- C/C++/Zig (GDB has native DAP support)
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}
		local gdb_launch = {
			name = "Launch (gdb)",
			type = "gdb",
			request = "launch",
			program = prompt_program,
			cwd = "${workspaceFolder}",
			stopAtBeginningOfMainSubprogram = false,
		}
		dap.configurations.c = { vim.deepcopy(gdb_launch) }
		dap.configurations.cpp = { vim.deepcopy(gdb_launch) }
		dap.configurations.zig = { vim.deepcopy(gdb_launch) }

		-- .NET (CoreCLR, via netcoredbg)
		dap.adapters.coreclr = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}
		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "Launch (netcoredbg)",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
				end,
			},
		}

		-- Rust (LLDB, requires the lldb package which provides lldb-dap)
		dap.adapters.lldb = {
			type = "executable",
			command = "lldb-dap",
			name = "lldb",
		}
		dap.configurations.rust = {
			{
				name = "Launch (lldb)",
				type = "lldb",
				request = "launch",
				program = prompt_program,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
	end,
}
