local M = {}

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
			C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
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
