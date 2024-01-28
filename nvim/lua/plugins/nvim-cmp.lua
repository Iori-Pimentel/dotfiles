return {
	"hrsh7th/nvim-cmp",
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
		local luasnip = require("luasnip")
		-- load snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
		})

		local function setup_cmp(mode, sources)
			local config = {
				mapping = cmp.mapping.preset.cmdline(),
				sources = sources,
			}
			cmp.setup.cmdline(mode, config)
		end

		setup_cmp({ "/", "?" }, { { name = "buffer" } })
		setup_cmp(":", { { name = "path" }, { name = "cmdline" } })
	end,
}
