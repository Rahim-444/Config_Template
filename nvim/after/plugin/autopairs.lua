local present1, autopairs = pcall(require, "nvim-autopairs")
local present2, autopairs_completion = pcall(require, "nvim-autopairs.completion.cmp")

if not (present1 or present2) then
	return
end

autopairs.setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})

local cmp = require("cmp")
cmp.event:on("confirm_done", autopairs_completion.on_confirm_done())
