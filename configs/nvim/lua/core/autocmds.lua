local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local default = augroup("Default", {})

autocmd("TextYankPost", {
	group = default,
	callback = function()
		-- highlights yank
		vim.highlight.on_yank({ timeout = 250, on_macro = true })
	end,
})

-- display tab and trailing space when on first column
autocmd({ "BufWinEnter", "CursorMoved", "CursorMovedI" }, {
	group = default,
	callback = function()
		-- FIXME :e! triggers BufWinEnter with col of 1
		local col = vim.fn.charcol(".")
		vim.wo.list = col == 1 and vim.bo.modifiable
	end,
})

-- ftplugin unwanted behaviour fix
autocmd("FileType", {
	group = default,
	callback = function()
		-- disables automatic comment after hitting o in normal mode
		vim.opt.formatoptions:remove("o")
	end,
})
