return {
	"mfussenegger/nvim-dap",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dapui").setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		--Redefine Icons
		vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogpoint", { text = "󱓥 ", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "󱦰 ", texthl = "", linehl = "", numhl = "" })

		--Assign Mappings
		local keymap = vim.keymap
		keymap.set("n", "<leader>bc", function()
			dap.continue()
		end, { desc = "Begin a new or conitnue paused debugging session" })
		keymap.set("n", "<leader>br", function()
			dap.restart()
		end, { desc = "Restart debugging session" })
		keymap.set("n", "<leader>bt", function()
			dap.terminate()
		end, { desc = "Terminate debugging session" })
		keymap.set("n", "<leader>bb", function()
			dap.toggle_breakpoint()
		end, { desc = "Add a breakpoint at current line" })

		--C/C++ Implementation
		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "/home/andres/.vscode/extensions/ms-vscode.cpptools-1.24.5-linux-x64/debugAdapters/bin/OpenDebugAD7",
		}
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}
		dap.configurations.c = dap.configurations.cpp
	end,
}
