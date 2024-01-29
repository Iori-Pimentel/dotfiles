local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	callback = function()
		-- highlights yank
		vim.highlight.on_yank({ timeout = 250, on_macro = true })

		-- yank into clipboard
		local event = vim.v.event
		if event.regname == "" and event.operator == "y" then
			vim.fn.setreg("+", event.regcontents)
		end
	end,
})

-- display tab and trailing space when on first column
autocmd({ "CursorMoved", "CursorMovedI" }, {
	callback = function()
		local col = vim.fn.getpos(".")[3]
		vim.wo.list = col == 1 and vim.bo.modifiable
	end,
})

-- ftplugin unwanted behaviour fix
autocmd("FileType", {
	callback = function()
		-- disables automatic comment after hitting o in normal mode
		vim.opt.formatoptions:remove("o")
	end,
})

-- bufferline.nvim add :help buffers
autocmd("BufWinEnter", {
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd.only()
			vim.bo.buflisted = true
		end
	end,
})
