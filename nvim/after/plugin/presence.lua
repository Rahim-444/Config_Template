-- The setup config table shows all available config options with their default values:
-- require("presence").setup({
-- 	enable_line_number = true, -- Displays the current line number instead of the current project
-- 	show_time = true,       -- Show the timer
--
-- 	-- Rich Presence text options
-- 	editing_text = "Editing %s",           -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
-- 	file_explorer_text = "Browsing %s",    -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
-- 	git_commit_text = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
-- 	plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
-- 	reading_text = "Reading %s",           -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
-- 	workspace_text = "Working on %s",      -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
-- 	line_number_text = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
-- })
require("cord").setup({
	usercmds = true,   -- Enable user commands
	timer = {
		enable = true, -- Enable automatically updating presence
		interval = 1500, -- Interval between presence updates in milliseconds (min 500)
		reset_on_idle = false, -- Reset start timestamp on idle
		reset_on_change = false, -- Reset start timestamp on presence change
	},
	editor = {
		image = nil,            -- Image ID or URL in case a custom client id is provided
		client = "neovim",      -- vim, neovim, lunarvim, nvchad, astronvim or your application's client id
		tooltip = "The Superior Text Editor", -- Text to display when hovering over the editor's image
	},
	display = {
		show_time = true, -- Display start timestamp
		show_repository = true, -- Display 'View repository' button linked to repository url, if any
		show_cursor_position = false, -- Display line and column number of cursor's position
		swap_fields = false, -- If enabled, workspace is displayed first
		workspace_blacklist = {}, -- List of workspace names to hide
	},
	lsp = {
		show_problem_count = false, -- Display number of diagnostics problems
		severity = 1, -- 1 = Error, 2 = Warning, 3 = Info, 4 = Hint
		scope = "workspace", -- buffer or workspace
	},
	idle = {
		enable = true, -- Enable idle status
		show_status = true, -- Display idle status, disable to hide the rich presence on idle
		timeout = 1800000, -- Timeout in milliseconds after which the idle status is set, 0 to display immediately
		disable_on_focus = true, -- Do not display idle status when neovim is focused
		text = "Idle", -- Text to display when idle
		tooltip = "💤", -- Text to display when hovering over the idle image
	},
	text = {
		viewing = "Viewing {}",      -- Text to display when viewing a readonly file
		editing = "Editing {}",      -- Text to display when editing a file
		file_browser = "Browsing files in {}", -- Text to display when browsing files (Empty string to disable)
		plugin_manager = "Managing plugins in {}", -- Text to display when managing plugins (Empty string to disable)
		lsp_manager = "Configuring LSP in {}", -- Text to display when managing LSP servers (Empty string to disable)
		workspace = "In {}",         -- Text to display when in a workspace (Empty string to disable)
	},
	buttons = {
		{
			label = "View Repository", -- Text displayed on the button
			url = "git", -- URL where the button leads to ('git' = automatically fetch Git repository URL)
		},
		-- {
		--   label = 'View Plugin',
		--   url = 'https://github.com/vyfor/cord.nvim',
		-- }
	},
	assets = { -- Custom file icons
		-- lazy = {                                 -- Vim filetype or file name or file extension = table or string (see wiki)*
		--   name = 'Lazy',                         -- Optional override for the icon name, redundant for language types
		--   icon = 'https://example.com/lazy.png', -- Rich Presence asset name or URL
		--   tooltip = 'lazy.nvim',                 -- Text to display when hovering over the icon
		--   type = 2,                              -- 0 = language, 1 = file browser, 2 = plugin manager, 3 = lsp manager; defaults to language
		-- },
		-- ['Cargo.toml'] = 'crates',
	},
})
