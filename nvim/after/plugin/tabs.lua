-- -- Bufferline configuration
require("bufferline").setup({})

-- Keymaps matching your previous tabby configuration
vim.api.nvim_set_keymap("n", "<A-o>", ":tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-c>", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-a>", ":tabonly<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-n>", ":tabn<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<A-p>", ":tabp<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })
--
