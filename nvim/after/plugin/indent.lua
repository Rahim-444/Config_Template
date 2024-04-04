local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#EB6F92" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#F6C177" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#EBBCBA" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#31748F" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#9CCFD8" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#EBBCBA" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C4A7E7" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({
	indent = { highlight = highlight, char = "" },
	whitespace = { remove_blankline_trail = true },
})

-- indentline-config.lua

-- local status_ok, indent_blankline = pcall(require, "indent_blankline")
-- if not status_ok then
-- 	return
-- end
--
-- vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
-- vim.g.indent_blankline_filetype_exclude = {
-- 	"help",
-- 	"startify",
-- 	"dashboard",
-- 	"packer",
-- 	"neogitstatus",
-- 	"NvimTree",
-- 	"Trouble",
-- }
-- vim.g.indentLine_enabled = 1
-- -- vim.g.indent_blankline_char = "│"
-- vim.g.indent_blankline_char = "▏"
-- -- vim.g.indent_blankline_char = "▎"
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_first_indent_level = true
-- vim.g.indent_blankline_use_treesitter = true
-- vim.g.indent_blankline_show_current_context = true
-- vim.g.indent_blankline_context_patterns = {
-- 	"class",
-- 	"return",
-- 	"function",
-- 	"method",
-- 	"^if",
-- 	"^while",
-- 	"jsx_element",
-- 	"^for",
-- 	"^object",
-- 	"^table",
-- 	"block",
-- 	"arguments",
-- 	"if_statement",
-- 	"else_clause",
-- 	"jsx_element",
-- 	"jsx_self_closing_element",
-- 	"try_statement",
-- 	"catch_clause",
-- 	"import_statement",
-- 	"operation_type",
-- }
-- -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
-- vim.wo.colorcolumn = "99999"
--
-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
--
-- indent_blankline.setup({
-- 	-- show_end_of_line = true,
-- 	-- space_char_blankline = " ",
-- 	-- show_current_context = true,
-- 	-- show_current_context_start = true,
-- 	char_highlight_list = {
-- 		"IndentBlanklineIndent1",
-- 		"IndentBlanklineIndent2",
-- 		"IndentBlanklineIndent3",
-- 		"IndentBlanklineIndent4",
-- 		"IndentBlanklineIndent5",
-- 		"IndentBlanklineIndent6",
-- 	},
-- })
