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

		for _, setup in ipairs({
			{ modes = { "/", "?" }, sources = { { name = "buffer" } } },
			{ modes = { ":" }, sources = { { name = "path" }, { name = "cmdline" } } },
		}) do
			local config = {
				mapping = cmp.mapping.preset.cmdline(),
				sources = setup.sources,
			}

			cmp.setup.cmdline(setup.modes, config)
		end
	end,
}
