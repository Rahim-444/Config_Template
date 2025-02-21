-- Setup mason to manage external tooling
-- LSP settings
-- This function runs when an LSP connects to a particular buffer
local on_attach = function(_, bufnr)
	-- Helper function for key mappings
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	-- Key mappings
	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Toggle inlay hints
	nmap("<leader>ih", function()
		local buf = vim.api.nvim_get_current_buf()
		local client = vim.lsp.get_active_clients({ bufnr = buf })[1]
		if client and client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint(buf, nil) -- Toggle inlay hints
		end
	end, "Toggle Inlay Hints")

	-- Format command
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format({ async = true })
	end, { desc = "Format current buffer with LSP" })
end

local servers = {
	clangd = {
		cmd = { "clangd", "--offset-encoding=utf-16" },
		hint = { enable = true },
	},
	pyright = {},
	rust_analyzer = {},
	lua_ls = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Recognize `vim` as a global
			},
		},
	},
	ts_ls = {
		javascript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
		typescript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- Additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Setup mason
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

-- Debounce diagnostics for better performance
vim.diagnostic.config({
	virtual_text = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Setup handlers for LSP servers
mason_lspconfig.setup_handlers({
	function(server_name)
		local opts = {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		}

		if server_name == "clangd" then
			opts.cmd = servers.clangd.cmd
		end

		require("lspconfig")[server_name].setup(opts)
	end,
})
