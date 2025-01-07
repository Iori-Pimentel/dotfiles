return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",

	opts = {
		keymap = {
			["<S-Tab>"] = { "accept" },
			["<C-l>"] = { "snippet_forward" },
			["<C-h>"] = { "snippet_backward" },
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				treesitter_highlighting = false,
			},
			menu = {
				max_height = 6,
			},
		},
	},
}
