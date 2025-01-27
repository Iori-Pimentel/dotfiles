return {
	{ ft = "lua", "folke/lazydev.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig").lua_ls.setup({ capabilites = capabilities })
			require("lspconfig").pylsp.setup({ capabilites = capabilities })
		end,
	},
}
