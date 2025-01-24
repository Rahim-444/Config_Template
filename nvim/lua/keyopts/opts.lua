-- -- the setup
-- text width and line break
vim.g.gruvbox_transparent_bg = 1

vim.opt.nu = true
vim.opt.relativenumber = true
vim.g.syntastic_auto_jump = 0

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.linebreak = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.lsp.inlay_hint.enable()

--set color column to 80
-- vim.opt.colorcolumn = "80"

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
-- -- blinking cursor
-- vim.opt.guicursor = "a:blinkon1"

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = "yes"

vim.o.linebreak = true

vim.opt.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
-- vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.textwidth = 79

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
