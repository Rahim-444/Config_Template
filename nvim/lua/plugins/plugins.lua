return {
	{ "rose-pine/neovim",              name = "rose-pine" },
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		build = "yarn install --frozen-lockfile && yarn compile",
	},
	{
		"barrett-ruth/live-server.nvim",
		build = "yarn global add live-server",
		config = true,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup()
		end,
	},
	"nanozuki/tabby.nvim",
	"lvimuser/lsp-inlayhints.nvim",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"stevearc/dressing.nvim",
	"onsails/lspkind.nvim",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/nvim-cmp",
	"mg979/vim-visual-multi",

	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
		dependencies = {
			-- Additional text objects via treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	-- "nvim-treesitter/nvim-treesitter-context",

	-- Git related plugins

	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"lewis6991/gitsigns.nvim",
	"mattn/emmet-vim",
	"mlaursen/vim-react-snippets",

	--themes
	"navarasu/onedark.nvim", -- Theme inspired by Ato,
	"folke/tokyonight.nvim",

	"nvim-lualine/lualine.nvim",        -- Fancier statuslin,
	"lukas-reineke/indent-blankline.nvim", -- Add indentation guides even on blank line
	"numToStr/Comment.nvim",            -- "gc" to comment visual regions/lines
	"tpope/vim-sleuth",                 -- Detect tabstop and shiftwidth automatically
	"theprimeagen/harpoon",             --quickly move between files
	"mbbill/undotree",                  --helps to undo things easily
	--debugger
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	"nvim-telescope/telescope-dap.nvim",
	-- Formatting
	"neovim/nvim-lspconfig",
	"MunifTanjim/prettier.nvim",
	{
		"williamboman/mason.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "java", "javascript", "javascriptreact", "html", "css", "typescript", "typescriptreact" },
		dependencies = "nvim-treesitter",
		branch = "main",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	"ckipp01/stylua-nvim",

	"tpope/vim-surround",
	"tpope/vim-repeat",
	"clean-css/clean-css",
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly",          -- optional, updated every week. (see issue #1193)
	},
	--better comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- Fuzzy Finder (files, lsp, etc)
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x",  dependencies = { "nvim-lua/plenary.nvim" } },
	"NvChad/nvim-colorizer.lua",
	-- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		cond = vim.fn.executable("make") == 1,
	},
	-- makes coping easier
	"equalsraf/win32yank",
	-- play media files through telescope
	"nvim-lua/popup.nvim",
	--terminal in screen
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- use ful status updates for LSP
			-- "j-hui/fidget.nvim",

			-- Additional lua configuration, makes nvim stuff amazing
			"folke/neodev.nvim",
		},
	},
	--cursor line highlighter and puts line under text
	"yamatsum/nvim-cursorline",
	"HiPhish/nvim-ts-rainbow2",
	"xiyaowong/transparent.nvim",
	--debugger for c/c++
	"github/copilot.vim",
	{
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
					blend = 30,
					winblend = 30,
					highlight = "WhichKeyFloat",
				},
				-- Other configuration options go here
			})
		end,
	},
	"dbgx/lldb.nvim",
	-- Debuggise ({
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"rafamadriz/friendly-snippets",
		},
	},
	--tabs in neovim
	-- { "romgrk/barbar.nvim", dependencies = "nvim-web-devicons" },
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				-- your configuration comes here
				-- or leave it empty to use  the default settings
				-- refer to the configuration section below
			})
		end,
	},
}
