return {
	{ "rose-pine/neovim",                    name = "rose-pine" },
	"mechatroner/rainbow_csv",
	"windwp/nvim-ts-autotag",
	"chrisgrieser/nvim-spider",
	"ntpeters/vim-better-whitespace",
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"vim-pandoc/vim-pandoc",
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true, -- or `opts = {}`
	},
	{
		"vim-pandoc/vim-pandoc-syntax",
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl",      opts = {} },

	-- Rainbow Highlighting
	-- {
	-- 	"HiPhish/nvim-ts-rainbow2",
	-- },

	{
		"folke/noice.nvim",
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 1500,
			background_colour = "#000000",
			render = "wrapped-compact",
			fps = 60,
			stages = "fade_in_slide_out",
		},
	},

	"mfussenegger/nvim-jdtls",
	{
		"dsznajder/vscode-es7-javascript-react-snippets",
		build = "yarn install --frozen-lockfile && yarn compile",
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
		event = "VimEnter",
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup()
		end,
	},
	"karb94/neoscroll.nvim",
	"nanozuki/tabby.nvim",
	"lvimuser/lsp-inlayhints.nvim",
	{
		"hrsh7th/nvim-cmp",
		dependencies = {

			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
		},
	},
	{
		"stevearc/dressing.nvim",
		"mg979/vim-visual-multi",
		event = "VeryLazy",
	},
	"onsails/lspkind.nvim",
	"andweeb/presence.nvim",
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },

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

	"tpope/vim-rhubarb",
	"lewis6991/gitsigns.nvim",
	"tpope/vim-fugitive",
	"mattn/emmet-vim",
	"mlaursen/vim-react-snippets",

	--themes
	"navarasu/onedark.nvim", -- Theme inspired by Ato,
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "storm",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
				normal = "transparent",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"numToStr/Comment.nvim", -- "gc" to comment visual regions/lines
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufReadPre", "BufNewFile" },
	},
	"tpope/vim-sleuth",    -- Detect tabstop and shiftwidth automatically
	"theprimeagen/harpoon", --quickly move between files
	"mbbill/undotree",     --helps to undo things easily
	--debugger
	--[[
	{
		"mfussenegger/nvim-dap",
		dependencies = {

			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
		},
		event = "VeryLazy",
	},
	]]
	--
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
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
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
					highlight = "WhichKeyFloat",
				},
				-- Other configuration options go here
			})
		end,
	},
	"dbgx/lldb.nvim",
	-- Debuggise ({
	-- Autocompletion
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip",
	"neovim/nvim-lspconfig",
	"rafamadriz/friendly-snippets",
	--tabs in neovim
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
