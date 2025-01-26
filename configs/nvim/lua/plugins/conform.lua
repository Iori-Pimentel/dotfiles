return {
	event = "BufWritePre",
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 500,
		},
		formatters_by_ft = {
			lua = { "stylua" },
		},
	},
}
