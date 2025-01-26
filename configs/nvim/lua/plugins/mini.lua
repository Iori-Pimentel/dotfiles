return {
	{
		event = "VeryLazy",
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "s",
				delete = "<BS>",
				replace = "<C-H>", -- <Ctrl-BS>
				update_n_lines = "ss",
				suffix_last = "<Left>",
				suffix_next = "<Right>",
			},
			search_method = "cover",
			silent = true,
		},
	},
	{
		event = "VeryLazy",
		"echasnovski/mini.ai",
		opts = {
			mappings = {
				around_next = "<S-Right>",
				inside_next = "<Right>",
				around_last = "<S-Left>",
				inside_last = "<Left>",
			},
			search_method = "cover",
			silent = true,
		},
	},
	{
		event = "VeryLazy",
		"echasnovski/mini.pairs",
		opts = {},
	},
	{
		event = "VeryLazy",
		"echasnovski/mini.files",
		opts = {
			windows = {
				preview = true,
				width_focus = 25,
				width_nofocus = 25,
				width_preview = 25,
			},
		},
	},
	{
		event = "VeryLazy",
		"echasnovski/mini-git",
		main = "mini.git",
		opts = {},
	},
}
