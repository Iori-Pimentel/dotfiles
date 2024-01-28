return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local comment = require("Comment").setup()
		local filetype = require("Comment.ft")
		filetype({ "", "text" }, "#%s")
	end,
}
