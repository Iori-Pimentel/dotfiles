return {
	{
		keys = {
			{ "sa", mode = { "n", "x" } },
			{ "sd", mode = { "n", "x" } },
			{ "sr", mode = { "n", "x" } },
		},
		"echasnovski/mini.surround",
		opts = { silent = true },
	},
	{
		keys = {
			{ "i", mode = "o" },
			{ "a", mode = "o" },
		},
		"echasnovski/mini.ai",
		opts = { silent = true },
	},
	{
		event = "InsertEnter",
		"echasnovski/mini.pairs",
		opts = {},
	},
	{
		keys = {
			{ "<leader>/", mode = { "n", "x" } },
			"<leader>O",
			"<leader>o",
			"<leader>a",
		},
		"numToStr/Comment.nvim",
		opts = {
			toggler = {
				line = "<leader>/",
			},
			opleader = {
				line = "<leader>/",
			},
			extra = {
				above = "<leader>O",
				below = "<leader>o",
				eol = "<leader>a",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter.configs")

			---@diagnostic disable-next-line missing-fields
			treesitter.setup({
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
	},
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
}
