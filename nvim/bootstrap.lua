vim.cmd.packadd("packer.nvim")

local install = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
local success = false
local packer

if not vim.loop.fs_access(install, "R") then
	success = vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install })
	if success then
		vim.cmd.packadd("packer.nvim")
	end
	packer = require("packer")
	packer.sync()
end

if not packer then
	packer = require("packer")
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
		prompt_border = "single",
	},
	git = {
		clone_timeout = 600, -- Timeout, in seconds, for git clones
	},
	auto_clean = true,
	compile_on_sync = true,
})

vim.g.packer_installed = vim.fn.stdpath("config") .. "/lua/plugin/packer_compiled.lua"

return packer
