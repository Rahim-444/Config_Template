local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.user_emmet_mode = "n"
vim.g.user_emmet_leader_key = ","

require("lazy").setup("plugins")
require("keyopts.keymaps")
require("keyopts.opts")
require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
vim.g.dap_virtual_text = true
--require("me.dap").setup()
-- Configure DAP UI console
--[[
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
dapui.setup({
	icons = {
		expanded = "▾",
		collapsed = "▸",
	},
	mappings = {
		-- Use <leader>e to toggle the DAP UI console
		expand = "<leader>e",
		open = "<CR>",
		remove = "d",
		edit = "e",
	},
	sidebar = {
		open_on_start = true, -- Automatically open the DAP UI console when starting a debugging session
		elements = {
			-- Customize the layout of the DAP UI console
			{
				id = "scopes",
				size = 0.25, -- Size of the element relative to the sidebar width
			},
			{
				id = "breakpoints",
				size = 0.25,
			},
			{
				id = "stacks",
				size = 0.25,
			},
			{
				id = "watches",
				size = 0.25,
			},
		},
		width = 40,      -- Width of the sidebar
		position = "left", -- Position of the sidebar (left or right)
	},
	tray = {
		open_on_start = true, -- Automatically open the DAP UI console tray when starting a debugging session
		elements = {
			{
				id = "repl",
				size = 1,
			},
		},
		height = 10,       -- Height of the tray
		position = "bottom", -- Position of the tray (bottom or top)
	},
})

require("nvim-dap-virtual-text").setup()
]]
--

require("lualine").setup({
	options = {
		icons_enabled = true,
		-- theme = require("me.lualine").theme(),
		theme = "auto",
		-- component_separators = "|",
		-- section_separators = "",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 2,
			},
		},
		lualine_x = {
			"encoding",
			{
				"fileformat",
				symbols = {
					unix = "", -- e711
				},
			},
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
-- Enable Comment.nvim
require("Comment").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`

-- Gitsigns,
-- See `:help gitsigns.txt`
require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
-- require("luasnip/loaders/from_vscode").lazy_load()
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<C-p>"] = require("telescope.actions.layout").toggle_preview,
			},
		},
		preview = {
			hide_on_startup = false, -- hide previewer when picker starts
		},
	},
	prompt_prefix = " ",
	selection_caret = " ",
	color_devicons = true,
	sorting_strategy = "ascending",
})
-- vim.o.signcolumn = require("dap").session() == nil and "auto" or "yes:1"

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- debugger remaps
function compile_and_continue()
	vim.cmd("w")
	vim.cmd("!gcc -march=x86-64 -o %< % -g")
	require("dap").continue()
end

-- set keymap for compiling and continue_RequestListenerArgs
vim.api.nvim_set_keymap("n", "<F7>", "<cmd>lua compile_and_continue()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<F3>", '<cmd>lua require("dapui").close()<CR>')
--emmet remaps
-- harpoon setup
-- function ColorMyPencils()
-- 	local color = "rose-pine"
-- 	vim.cmd.colorscheme(color)
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end

-- ColorMyPencils()
-- require("rose-pine").setup({
-- 	disable_background = true,
-- })

-- vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
-- The line beneath this is called `modeline`. See `:help modeline`
