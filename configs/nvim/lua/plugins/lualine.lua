return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			component_separators = {},
			section_separators = {},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { "filename" },
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
	},
}
