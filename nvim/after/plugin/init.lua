local M = {}
--------------------------------------------------------------------------------
local function configure()
	require("mason").setup()
	require("mason-nvim-dap").setup({
		ensure_installed = { "cpptools", "codelldb" },
	})

	local dap_breakpoint = {
		error = {
			text = "⬤",
			texthl = "LspDiagnosticsSignError",
			linehl = "",
			numhl = "",
		},
		rejected = {
			text = "",
			texthl = "LspDiagnosticsSignHint",
			linehl = "",
			numhl = "",
		},
		stopped = {
			text = "⇨",
			texthl = "LspDiagnosticsSignInformation",
			linehl = "DiagnosticUnderlineInfo",
			numhl = "LspDiagnosticsSignInformation",
		},
	}

	vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
	vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
	vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end
--------------------------------------------------------------------------------
local function configure_exts()
	require("nvim-dap-virtual-text").setup({
		commented = true,
	})

	local dap, dapui = require("dap"), require("dapui")
	dapui.setup({}) -- use default
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end
--------------------------------------------------------------------------------
local function configure_adapters()
	require("adapters").setup()
	local M = {}
	--------------------------------------------------------------------------------
	function M.init()
		M.tmpFile = os.tmpname()
		os.execute("whoami > " .. M.tmpFile)
		local whoamiFile = io.open(M.tmpFile, "r")
		M.user = whoamiFile:read()
		whoamiFile:close()
		M.psCommand = "ps -u " .. M.user .. " -U " .. M.user .. " u > " .. M.tmpFile
		vim.inspect(M)
	end

	--------------------------------------------------------------------------------
	function M.selectAndWait(items, prompt, format)
		local co = coroutine.running()
		if co then
			cb = function(item)
				coroutine.resume(co, item)
			end
		end
		cb = vim.schedule_wrap(cb)
		vim.ui.select(items, {
			prompt = prompt,
			format_item = format,
		}, cb)
		if co then
			return coroutine.yield()
		end
	end

	--------------------------------------------------------------------------------------------
	function M.processesWithName(name)
		os.execute("ps | grep " .. name .. " > M.tmpFile")
		-- read the tmp file line by line
		local processes = {}
		for line in io.lines(M.tmpFile) do
			table.insert(processes, line)
		end
		return processes
	end

	--------------------------------------------------------------------
	function M.processesOfUser()
		os.execute(M.psCommand)
		-- read the tmp file line by line
		local processes = {}
		local first = true -- for omitting table header line
		for processString in io.lines(M.tmpFile) do
			if first then
				first = false
			else
				local process = {}
				for token in string.gmatch(processString, "[^%s]+") do
					table.insert(process, token)
				end
				table.insert(processes, process)
			end
		end
		return processes
	end

	--------------------------------------------------------------------------------
	function M.setup()
		local dap = require("dap")

		dap.adapters.cppdbg = {
			name = "cpptools",
			type = "server",
			port = "4711",
			--args = "--server=4711",
			command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
		}

		dap.adapters.codelldb = {
			name = "codelldb server",
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.cpp = {
			{
				name = "Attach to process",
				type = "cppdbg",
				request = "attach",
				processId = function()
					local process = M.selectAndWait(M.processesOfUser(), "Select process", function(process)
						return process[11] .. " (" .. process[2] .. ")"
					end)
					local pid = process[2]
					local path = process[11]
					dap.configurations.cpp[1].program = path
					print(path)
					return pid
				end,
			},
			--{
			--  name = 'Attach to StarCCM+',
			--  type = 'cppdbg',
			--  request = 'attach',
			--  processId = function()
			--    -- execute linux ps and get PIDs and process names. write the output to a tmp file
			--    local ps = M.processesWithName('starccm+')
			--
			--    if (length(ps) == 0) then
			--      return ''
			--    elseif (length(ps) == 1) then
			--      local pid = ps[1]
			--      local line = {}
			--      for token in string.gmatch(item, "[^%s]+") do
			--        table.insert(line, token)
			--      end
			--      pid = line[1]
			--    else
			--      local pid = M.selectAndWait(processes, "Select process")
			--      local line = {}
			--      for token in string.gmatch(item, "[^%s]+") do
			--        table.insert(line, token)
			--      end
			--      pid = line[1]
			--    end
			--    return pid
			--  end,
			--},
		}
		dap.configurations.c = dap.configurations.cpp
	end

	M.init()
	return M
end
--------------------------------------------------------------------------------
function M.setup()
	configure() -- Configuration
	configure_exts() -- Extensions
	configure_adapters() -- Debugger
	local M = {}

	print("hello from keymaps.lua")
	local whichkey = require("which-key")

	-- local function keymap(lhs, rhs, desc)
	--   vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc })
	-- end

	-- Functional wrapper for mapping custom keybindings
	function map(mode, lhs, rhs, opts)
		local options = { noremap = true }
		if opts then
			options = vim.tbl_extend("force", options, opts)
		end
		vim.api.nvim_set_keymap(mode, lhs, rhs, options)
	end

	function M.setup()
		local keymap = {
			d = {
				name = "Debug",
				R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
				E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
				C = {
					"<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
					"Conditional Breakpoint",
				},
				U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
				b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
				c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
				d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
				e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
				g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
				h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
				S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
				i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
				o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
				p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
				q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
				r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
				s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
				t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
				x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
				u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
			},
		}

		whichkey.register(keymap, {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		})

		map("n", "<F5>", ":lua require('dap').continue()<CR>", { silent = true })
		map("n", "<F8>", ":lua require('dap').toggle_breakpoint()<CR>", { silent = true })
		map("n", "<F10>", ":lua require('dap').step_over()<CR>", { silent = true })
		map("n", "<F11>", ":lua require('dap').step_into()<CR>", { silent = true })
		map("n", "<F12>", ":lua require('dap').step_out()<CR>", { silent = true })

		local keymap_v = {
			name = "Debug",
			e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
		}
		whichkey.register(keymap_v, {
			mode = "v",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = false,
		})
	end

	return M
end

--------------------------------------------------------------------------------
return M
