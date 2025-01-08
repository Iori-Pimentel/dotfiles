return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- !Important! Make sure you're using the latest release of LuaSnip
		-- `main` does not work at the moment
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
	},

	opts = {
		keymap = {
			["<Right>"] = { "accept", "snippet_forward" },
			["<Left>"] = { "snippet_backward" },
			["<Up>"] = {
				function(cmp)
					cmp.scroll_documentation_up(1)
				end,
				"fallback",
			},
			["<Down>"] = {
				function(cmp)
					cmp.scroll_documentation_down(1)
				end,
				"fallback",
			},
		},

		completion = {
			menu = {
				max_height = 6,
			},

			list = {
				selection = {
					auto_insert = false,
				},
			},

			documentation = {
				auto_show = true,
				treesitter_highlighting = false, -- Disables wrong highlighting
				window = {
					min_width = 80,
				},
			},
		},

		signature = {
			enabled = true,
		},

		snippets = {
			preset = "luasnip",
		},
	},
}
