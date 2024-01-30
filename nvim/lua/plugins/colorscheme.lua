return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		show_end_of_buffer = true,
		color_overrides = {
			all = {
				base = "#222327",
				mantle = "#2E343F",
			},
		},
	},
	init = function()
		vim.cmd("colorscheme catppuccin")
	end,
}
