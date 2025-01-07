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
			},
			["<Down>"] = {
				function(cmp)
					cmp.scroll_documentation_down(1)
				end,
			},
		},

		completion = {
			documentation = {
				auto_show = true,
				window = {
					min_width = 80,
				},
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
