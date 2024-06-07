function ColorMyPencils()
	local color = "gruvbox"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

--
ColorMyPencils()
-- require("tokyonight").setup({
-- 	disable_background = true,
-- })
