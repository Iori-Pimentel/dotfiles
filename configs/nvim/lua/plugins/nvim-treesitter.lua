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

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-j>",
					node_incremental = "<C-j>",
					node_decremental = "<C-k>",
				},
			},
		})
	end,
}
