return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdLineEnter" },
	dependencies = {
		-- completion sources
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		-- completion engine
		"L3MON4D3/LuaSnip",
		-- snippet sources
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			sources = cmp.config.sources({
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			mapping = {
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- Snippets
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		vim.snippet.active = function(filter)
			filter = filter or {}
			filter.direction = filter.direction or 1

			if filter.direction == 1 then
				return ls.expand_or_jumpable()
			else
				return ls.jumpable(filter.direction)
			end
		end

		vim.snippet.jump = function(direction)
			if direction == 1 then
				if ls.expandable() then
					return ls.expand_or_jump()
				else
					return ls.jumpable(1) and ls.jump(1)
				end
			else
				return ls.jumpable(-1) and ls.jump(-1)
			end
		end

		vim.snippet.stop = ls.unlink_current

		ls.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
			override_builtin = true,
		})

		vim.keymap.set({ "i", "s" }, "<c-k>", function()
			return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(1)
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<c-j>", function()
			return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
		end, { silent = true })
	end,
}
