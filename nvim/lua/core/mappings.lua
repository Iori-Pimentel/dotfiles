local map = vim.keymap.set
-- opt.clipboard:append("unnamedplus") -- use system clipboard on all actions
map({ "n", "v" }, "y", '"+y') -- use system clipboard on yank only
map("n", "<leader>n", "<CMD>set number!<CR>")

-- bufferline.nvim
map("n", "H", "<CMD>BufferLineCyclePrev<CR>")
map("n", "L", "<CMD>BufferLineCycleNext<CR>")

-- Comment.nvim
map("v", "<leader>/", "gc", { remap = true })
map("n", "<leader>/", "gcc", { remap = true })
map("n", "<leader>a", "gcA", { remap = true })
map("n", "<leader>o", "gco", { remap = true })
map("n", "<leader>O", "gcO", { remap = true })
