return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		on_attach = function(bunfnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map("n", "]h", function()
				gitsigns.nav_hunk("next")
			end)
			map("n", "[h", function()
				gitsigns.nav_hunk("prev")
			end)

			map("n", "<leader>hR", gitsigns.reset_buffer)
			map("n", "<leader>hr", gitsigns.reset_hunk)
			map("v", "<leader>hr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)

			map({ "o", "x" }, "ih", "<CMD>Gitsigns select_hunk<CR>")
		end,
	},
}
