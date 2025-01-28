return {
	{ -- colorscheme
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
		opts = {
			-- Assume only Termux-monet have italic fonts
			no_italic = not (os.getenv("TERMUX_VERSION") or "termux"):find("monet"),
			show_end_of_buffer = true,
			color_overrides = {
				all = {
					base = "#222327",
					mantle = "#2E343F",
				},
			},
		},
	},
	{ -- notification
		event = "VeryLazy",
		"j-hui/fidget.nvim",
		opts = {
			progress = {
				display = {
					done_ttl = 1,
				},
			},
			notification = {
				override_vim_notify = true,
			},
		},
	},
	{ -- statusline
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
	},
}
