-- Debug Adapter Protocol
return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		-- .NET (Core)
		dap.adapters.coreclr = {
			type = "executable",
			command = "/path/to/dotnet/netcoredbg/netcoredbg",
			args = { "--interpreter=vscode" },
		}
		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "launch - netcoredbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
				end,
			},
		}

		-- Node.js
		-- NOTE: Install https://github.com/microsoft/vscode-js-debug
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				-- FIXME: Set path to `dapDebugServer.js`
				args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
			},
		}
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}

		-- C/C++/Rust (GDB)
		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}
		dap.configurations.c = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
			},
		}
	end,
}
