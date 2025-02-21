local null_ls = require("null-ls")

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"prettierd",
		"stylua",
		"eslint_d",
	},
})
--
--
local banned_messages = { "No information available" }
vim.notify = function(msg, ...)
	for _, banned in ipairs(banned_messages) do
		if msg == banned then
			return
		end
	end
	return require("notify")(msg, ...)
end
--
vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end

	notify(msg, ...)
end

local prettier = require("prettier")
prettier.setup({
	cli_options = {
		arrow_parens = "always",
		bracket_spacing = true,
		bracket_same_line = true,
		embedded_language_formatting = "auto",
		end_of_line = "lf",
		html_whitespace_sensitivity = "css",
		-- jsx_bracket_same_line = false,
		jsx_single_quote = false,
		-- print_width = 80,
		prose_wrap = "always",
		quote_props = "as-needed",
		semi = true,
		single_attribute_per_line = false,
		single_quote = false,
		tab_width = 2,
		trailing_comma = "es5",
		use_tabs = false,
		vue_indent_script_and_style = false,
	},
})
