-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Load VSCode-like snippets
require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- Define common select behavior
local select_opts = { behavior = cmp.SelectBehavior.Select }

-- Prettier symbols for the kind labels
local kind_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰜢",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "󰈇",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "󰙅",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "",
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:CmpTransparent,FloatBorder:CmpBorder",
			col_offset = -3,
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:CmpTransparent,FloatBorder:CmpBorder",
			max_width = 50,
			max_height = 30,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)

			-- Source
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]

			-- Tailwind CSS color preview
			if vim_item.kind == "Color" and entry.completion_item.documentation then
				local _, _, r, g, b = string.find(entry.completion_item.documentation,
					"^rgb%((%d+), (%d+), (%d+)")
				if r then
					local color = string.format("%02x", r) ..
					string.format("%02x", g) .. string.format("%02x", b)
					local group = "Tw_" .. color
					if vim.fn.hlID(group) < 1 then
						vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
					end
					vim_item.kind = "■ Color"
					vim_item.kind_hl_group = group
				end
			end

			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp", priority = 1000 },
		{ name = "luasnip",  priority = 750 },
		{ name = "buffer",   priority = 500 },
		{ name = "path",     priority = 250 },
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
})

-- Set up custom highlights for transparency and borders
vim.api.nvim_set_hl(0, "CmpTransparent", { bg = "none" })
vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#5eacd3" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82aaff", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82aaff", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#c792ea", italic = true })

-- Add borders to floating windows
local win = require("cmp.utils.window")

win.info_ = win.info
win.info = function(self)
	local info = self:info_()
	info.scrollbar = false
	return info
end
