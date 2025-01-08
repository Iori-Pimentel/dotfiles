return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		---@diagnostic disable-next-line missing-fields
		treesitter.setup({
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,

			textobjects = {
				select = {
					enable = true,
					keymaps = {
						["ia"] = "@parameter.inner",
						["aa"] = "@parameter.outer",
					},
				},

				swap = {
					enable = true,
					swap_next = {
						["<S-right>"] = "@parameter.inner",
					},
					swap_previous = {
						["<S-left>"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
