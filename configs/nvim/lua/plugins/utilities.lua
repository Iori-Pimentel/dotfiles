return {
	{
		event = "VeryLazy",
		"echasnovski/mini.files",
		opts = {
			windows = {
				preview = true,
				width_focus = 25,
				width_nofocus = 25,
				width_preview = 25,
			},
		},
	},
	{
		event = "VeryLazy",
		"echasnovski/mini-git",
		main = "mini.git",
		opts = {},
	},
	{ -- formatter
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
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			on_attach = function(bufnr)
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
	},
	{
		---@diagnostic disable: undefined-global
		"folke/snacks.nvim",
		opts = {
			picker = {
				on_show = function(picker)
					Snacks.picker.actions.toggle_maximize(picker)
				end,
			},
		},
		-- stylua: ignore
		keys = {
			-- find
			{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
			{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
			{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
			{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
			-- git
			{ "<leader>glp", function() Snacks.picker.git_log() end, desc = "Git Log Project" },
			{ "<leader>glf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
			{ "<leader>gll", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
			{ "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
			-- Grep
			{ "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
			{ "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
			{ "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
			-- search
			{ '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
			{ "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
			{ "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
			{ "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
			{ "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
			{ "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
			{ "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
			{ "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
			{ "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
			{ "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
			{ "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
			{ "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
			{ "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
			{ "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
			{ "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
			{ "<leader>qp", function() Snacks.picker.projects() end, desc = "Projects" },
			-- LSP
			{ "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
			{ "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
			{ "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			{ "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
			{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Symbols Workspace" },
		} ,
	},
}
