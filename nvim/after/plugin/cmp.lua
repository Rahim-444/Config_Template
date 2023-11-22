vim.opt.completeopt = { "menu", "menuone", "noselect" }
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "luasnip",  keyword_length = 2 },
		{ name = "buffer",   keyword_length = 3 },
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "path" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				luasnip = "⋗",
				buffer = "Ω",
				path = "🖫",
			}

			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),
		["<C-y>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		--
		-- 	["<C-f>"] = cmp.mapping(function(fallback)
		-- 		if luasnip.jumpable(1) then
		-- 			luasnip.jump(1)
		-- 		else
		-- 			fallback()
		-- 		end
		-- 	end, { "i", "s" }),
		--
		-- 	["<C-b>"] = cmp.mapping(function(fallback)
		-- 		if luasnip.jumpable(-1) then
		-- 			luasnip.jump(-1)
		-- 		else
		-- 			fallback()
		-- 		end
		-- 	end, { "i", "s" }),
		--
		-- 	["<Tab>"] = cmp.mapping(function(fallback)
		-- 		local col = vim.fn.col(".") - 1
		--
		-- 		if cmp.visible() then
		-- 			cmp.select_next_item(select_opts)
		-- 		elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
		-- 			fallback()
		-- 		else
		-- 			cmp.complete()
		-- 		end
		-- 	end, { "i", "s" }),
		--
		-- 	["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 		if cmp.visible() then
		-- 			cmp.select_prev_item(select_opts)
		-- 		else
		-- 			fallback()
		-- 		end
		-- 	end, { "i", "s" }),
	},
})
cmp.setup({
	window = {
		completion = {
			col_offset = -3, -- align the abbr and word on cursor (due to fields order below)
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			menu = {     -- showing type in menu
				nvim_lsp = "[LSP]",
				path = "[Path]",
				buffer = "[Buffer]",
				luasnip = "[LuaSnip]",
			},
			before = function(entry, vim_item) -- for tailwind css autocomplete
				if vim_item.kind == "Color" and entry.completion_item.documentation then
					local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
					if r then
						local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
						local group = "Tw_" .. color
						if vim.fn.hlID(group) < 1 then
							vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
						end
						vim_item.kind = "■" -- or "⬤" or anything
						vim_item.kind_hl_group = group
						return vim_item
					end
				end
				-- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
				-- or just show the icon
				vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
				return vim_item
			end,
		}),
	},
})
