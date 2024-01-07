vim.g.mapleader = " " -- set leader key to space
require("core.options")
require("core.mappings")

-- highlight yank text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			timeout = 250,
			on_macro = true,
		})
	end,
	group = vim.api.nvim_create_augroup("HighlightOnYank", { clear = true }),
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	-- { { import = "plugins" }, -- { import = "plugins.lsp" } }, {
	checker = { -- automatically check for plugin updates
		enabled = true,
		notify = false,
	},
	change_detection = { -- automatically check for config file changes and reload the ui
		enabled = true,
		notify = false,
	},
})
