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
				left_trunc_marker = "~~~",
				right_trunc_marker = "~~~",
				sort_by = "insert_after_current",
			},
		})
		-- create autocommand to show :help in bufferline
		vim.api.nvim_create_autocmd("BufWinEnter", {
			callback = function()
				if vim.bo.filetype == "help" then
					vim.cmd.only()
					vim.bo.buflisted = true
					vim.wo.list = false
				end
			end,
		})
	end,
}
