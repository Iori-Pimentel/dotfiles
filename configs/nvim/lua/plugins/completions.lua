return {
	"saghen/blink.cmp",
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

		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
	},
}
