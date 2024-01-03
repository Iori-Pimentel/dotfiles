return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				show_buffer_close_icons = false,
				separator_style = { "", "" },
				left_trunc_marker = '~~~',
				right_trunc_marker = '~~~',
			},
		})
	end,
}
