require("nvim-cursorline").setup({
	cursorline = {
		--enable = enable,
		disable = false,
		timeout = 300,
		number = false,
	},
	cursorword = {
		enable = true,
		min_length = 3,
		hl = { underline = true },
	},
})
