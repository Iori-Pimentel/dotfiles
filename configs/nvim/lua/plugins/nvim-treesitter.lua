return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		---@diagnostic disable-next-line missing-fields
		treesitter.setup({
			highlight = { enable = true },
			auto_install = true,

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
