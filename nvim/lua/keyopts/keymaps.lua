local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
--NOTE:these work btw
-- Move to previous/next
-- nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
-- nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
--
-- nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
-- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
-- nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
-- nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
-- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
-- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--
-- -- See `:help K` for why this keymap
--nmap("K", vim.lsp.buf.hover, "Hover Documentation")
--nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
--
-- -- Lesser used LSP functionality
-- nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
-- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
-- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
-- nmap("<leader>wl", function()
-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, "[W]orkspace [L]ist Folders")
map("n", "<D-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<D-.>", "<Cmd>BufferNext<CR>", opts)
map("n", "<D-c>", "<Cmd>BufferClose<CR>", opts)
--command line
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>ff", function()
	vim.lsp.inlay_hint.enable()
end, { desc = "Toggle Inlay Hints" })
--map esc to clear search
vim.api.nvim_set_keymap("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Deselect the current search in normal mode
vim.api.nvim_set_keymap("n", "<CapsLock>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = true,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

--markdown preview
vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { desc = "[M]arkdown [P]review" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
-- vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
--nvimtree keymap
vim.keymap.set("n", "<leader>n", "<cmd>:NvimTreeToggle<Cr>")

-- vim.keymap.set("n", "<leader>S", ":%s//g<left><left>")
--c compile
-- vim.keymap.set(
-- 	"n",
-- 	"<F8>",
-- 	":w <CR> :!gcc % -o %< -lm -I/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/SDL2.framework/Headers -Wl,-rpath,/Library/Frameworks -F/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks -framework SDL2 <CR>"
-- )
-- c compile simple
vim.keymap.set("n", "<F8>", ":w <CR> :!gcc % -o %< -lm <CR>")
-- vim.keymap.set(
-- 	"n",
-- 	"<F9>",
-- 	":w <CR> :!cd .. && javac -d bin src/**/*.java && java -cp bin main.java.com.example.Poo.Application<CR>"
-- )
vim.keymap.set("n", "<F9>", ":w <CR> :!~/my_space/build/database.sh<CR>")
--zenmode
vim.keymap.set("n", "<leader>z", "<CR>:ZenMode<CR>")
--other remaps
vim.keymap.set("v", "<leader>S", ":s//g<left><left>")
vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeFocus<Cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>lua vim.lsp.buf.code_action()<Cr>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--undo tree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<Cr>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Esc key remap to capslock
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/init.lua<CR>")

-- Remap for dealing with word wrap
-- vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>h", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<C-t>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<C-n>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<C-s>", function()
	ui.nav_file(4)
end)
