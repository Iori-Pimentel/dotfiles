return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local comment = require("Comment")
		comment.setup({
			pre_hook = function()
				-- Prevents adding comment when pressing o/O in normal mode
				-- FIXME: only triggers when plugin triggers
				vim.opt.formatoptions:remove("o")
			end,
		})
		local ft = require("Comment.ft")
		ft.set("text", "# %s")
	end,
}
