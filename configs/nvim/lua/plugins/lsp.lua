return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			{ "folke/lazydev.nvim", opts = {} },
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig").lua_ls.setup({ capabilites = capabilities })
			require("lspconfig").pylsp.setup({ capabilites = capabilities })
		end,
	},
}
