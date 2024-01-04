local theme = {
	-- fill = "TabLineFill",
	fill = { fg = "#f2e9de", bg = "#907aa9", style = "italic" },
	head = "TabLine",
	current_tab = "TabLineSel",
	tab = "TabLine",
	win = "TabLine",
	tail = "TabLine",
}
require("tabby.tabline").set(function(line)
	return {
		{
			{ "  ", hl = theme.head },
			line.sep("", theme.head, theme.fill),
		},
		line.tabs().foreach(function(tab)
			local hl = tab.is_current() and theme.current_tab or theme.tab
			return {
				line.sep("", hl, theme.fill),
				tab.is_current() and "" or "󰆣",
				tab.number(),
				tab.name(),
				tab.close_btn(""),
				line.sep("", hl, theme.fill),
				hl = hl,
				margin = " ",
			}
		end),
		line.spacer(),
		line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			return {
				line.sep("", theme.win, theme.fill),
				win.is_current() and "" or "",
				win.buf_name(),
				line.sep("", theme.win, theme.fill),
				hl = theme.win,
				margin = " ",
			}
		end),
		{
			line.sep("", theme.tail, theme.fill),
			{ "  ", hl = theme.tail },
		},
		hl = theme.fill,
	}
end)
vim.api.nvim_set_keymap("n", "<A-o>", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-c>", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-a>", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-n>", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-p>", ":tabp<CR>", { noremap = true })
-- move current tab to previous position
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
-- move current tab to next position
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })
