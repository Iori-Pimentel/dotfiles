local map = vim.keymap.set
-- opt.clipboard:append("unnamedplus") -- use system clipboard on all actions
map({ "n", "v" }, "y", '"+y') -- use system clipboard on yank only
map("n", "H", "<CMD>BufferLineCyclePrev<CR>")
map("n", "L", "<CMD>BufferLineCycleNext<CR>")
map("n", "<leader>n", "<CMD>set number!<CR>")
map("n", "<ESC>", "<CMD>noh<CR>")

-- Comment.nvim
map("n", "<leader>/", "gcc", { remap = true })
map("n", "<leader>a", "gcA", { remap = true })
map("n", "<leader>o", "gco", { remap = true })
map("n", "<leader>O", "gcO", { remap = true })
