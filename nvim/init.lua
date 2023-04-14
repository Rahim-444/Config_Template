-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
    -- Package manager
    use("wbthomason/packer.nvim")

    use({
        -- LSP Configuration & Plugins
        "neovim/nvim-lspconfig",
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            -- "j-hui/fidget.nvim",

            -- Additional lua configuration, makes nvim stuff amazing
            "folke/neodev.nvim",
        },
    })
    --cursor line highlighter and puts line under text
    use("yamatsum/nvim-cursorline")
    use("HiPhish/nvim-ts-rainbow2")
    use("xiyaowong/transparent.nvim")
    require("nvim-cursorline").setup({
        cursorline = {
            enable = false,
            timeout = 300,
            number = false,
        },
        cursorword = {
            enable = true,
            min_length = 3,
            hl = { underline = true },
        },
    })
    --debugger for c/c++
    use("mfussenegger/nvim-dap")
    use("leoluz/nvim-dap-go")
    require("dap-go").setup()
    require("dap.ext.vscode").load_launchjs(nil, {})
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
    use({
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({
                -- Set the transparency level for the pop-up window
                window = {
                    border = "single",
                    position = "bottom",
                    margin = { 1, 0, 1, 0 },
                    padding = { 1, 1, 1, 1 },
                    height = 10,
                    width = 40,
                    blend = 5,
                    winblend = 5,
                    highlight = "WhichKeyFloat",
                },
                -- Other configuration options go here
            })
        end,
    })
    use("dbgx/lldb.nvim")
    use("jay-babu/mason-nvim-dap.nvim")
    -- Debugging
    use({
        "mfussenegger/nvim-dap",
        requires = {
            "williamboman/mason.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "ldelossa/nvim-dap-projects",
            "mfussenegger/nvim-dap-python",
            "nvim-telescope/telescope-dap.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
    })
    use({
        -- Autocompletion
        "hrsh7th/nvim-cmp",
        requires = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    })
    use({ "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "saadparwaiz1/cmp_luasnip" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use("onsails/lspkind.nvim")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/nvim-cmp")

    use({
        -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        run = function()
            pcall(require("nvim-treesitter.install").update({ with_sync = true }))
        end,
    })
    use("nvim-treesitter/nvim-treesitter-context")

    use({
        -- Additional text objects via treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    })

    -- Git related plugins
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("lewis6991/gitsigns.nvim")
    use("mattn/emmet-vim")
    --themes
    use("navarasu/onedark.nvim") -- Theme inspired by Atom
    use("folke/tokyonight.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })

    use("nvim-lualine/lualine.nvim")           -- Fancier statusline
    use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
    use("numToStr/Comment.nvim")               -- "gc" to comment visual regions/lines
    use("tpope/vim-sleuth")                    -- Detect tabstop and shiftwidth automatically
    use("theprimeagen/harpoon")                --quickly move between files
    use("mbbill/undotree")                     --helps to undo things easily
    use("manzeloth/live-server")               --html live server
    -- Formatting
    use("neovim/nvim-lspconfig")
    use("MunifTanjim/prettier.nvim")
    use({
        "williamboman/mason.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
    })
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    use({
        "windwp/nvim-autopairs",
        after = "nvim-cmp",
    })
    use({
        "windwp/nvim-ts-autotag",
        ft = { "javascript", "javascriptreact", "html", "css", "typescript", "typescriptreact" },
        after = "nvim-treesitter",
        branch = "main",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    })
    use({ "ckipp01/stylua-nvim" })

    use({ "tpope/vim-surround" })
    use({ "tpope/vim-repeat" })
    use("clean-css/clean-css")
    use({ "norcalli/nvim-colorizer.lua" })
    use({
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional, for file icons
        },
        tag = "nightly",                   -- optional, updated every week. (see issue #1193)
    })
    --better comments
    use("nvim-lua/plenary.nvim")
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })
    -- Fuzzy Finder (files, lsp, etc)
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })
    -- makes coping easier
    use("equalsraf/win32yank")
    -- play media files through telescope
    use("nvim-lua/popup.nvim")
    --terminal in screen
    use({
        "akinsho/toggleterm.nvim",
        tag = "*",
        config = function()
            require("toggleterm").setup()
        end,
    })
    --tabs in neovim
    use({ "romgrk/barbar.nvim", requires = "nvim-web-devicons" })
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    use({
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })

    -- Move to previous/next
    map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
    map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
    map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, "custom.plugins")
    if has_plugins then
        plugins(use)
    end

    if is_bootstrap then
        require("packer").sync()
    end
end)

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
    group = packer_group,
    pattern = vim.fn.expand("$MYVIMRC"),
})
--debug

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

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
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true
-- vim.cmd([[colorscheme tokyonight-moon]])
vim.cmd([[highlight NonText guibg=none]])
vim.cmd([[highlight Normal guibg=none]])
vim.cmd([[hi Normal ctermbg=none guibg=none]])
vim.cmd([[
  highlight! WhichKeyFloat guibg=none guifg=none
]])
vim.cmd([[set pumblend=5]])

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--makes neovim transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = require("me.lualine").theme(),
        component_separators = "|",
        section_separators = "",
    },
})
require("nvim-treesitter.configs").setup({
    rainbow = {
        enable = true,
        -- list of languages you want to disable the plugin for
        disable = { "jsx", "cpp" },
        -- Which query to use for finding delimiters
        query = "rainbow-parens",
        -- Highlight the entire buffer all at once
        strategy = require("ts-rainbow").strategy.global,
    },
})

-- Enable Comment.nvim
require("Comment").setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require("indent_blankline").setup({
    char = "┊",
    show_trailing_blankline_indent = false,
})

-- Gitsigns
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
require("telescope").setup({
    defaults = {
        winblend = 10, -- set the transparency level to 10%
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
vim.o.signcolumn = require("dap").session() == nil and "auto" or "yes:1"

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
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

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
        "c",
        "cpp",
        "go",
        "lua",
        "python",
        "rust",
        "typescript",
        "help",
        "vim",
        "html",
        "css",
        "javascript",
    },
    highlight = { enable = true },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
    },
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
vim.keymap.set("n", "<leader>n", "<cmd>:NvimTreeToggle<Cr>")

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
require("lspconfig").tsserver.setup({})
local servers = {
    clangd = {},
    --gopls = {},
    pyright = {},
    rust_analyzer = {},
    tsserver = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require("neodev").setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end,
})

-- Turn on lsp status information
-- require("fidget").setup()

-- nvim-cmp setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    menu = {
        winblend = 10,
        pumblend = 10,
    },
    snippet = {
        pumblend = 10,
        winblend = 10,
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})
-- debugger remaps
function compile_and_continue()
    vim.cmd("w")
    vim.cmd("!gcc -o %< % -g")
    require("dap").continue()
end

--emmet remaps
vim.g.user_emmet_mode = "n"
vim.g.user_emmet_leader_key = ","
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>S", ":%s//g<left><left>")
--c compile
vim.keymap.set("n", "<F8>", ":w <CR> :!gcc % -o %< -s <CR>")
--zenmode
vim.keymap.set("n", "<leader>z", "<CR>:ZenMode<CR>")
--other remaps
vim.keymap.set("v", "<leader>S", ":s//g<left><left>")
vim.keymap.set("n", "<leader>pv", "<cmd>NvimTreeFocus<Cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>lua vim.lsp.buf.code_action()<Cr>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
--undo tree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<Cr>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Esc key remap to capslock
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")
-- harpoon setup
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
-- the setup
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
