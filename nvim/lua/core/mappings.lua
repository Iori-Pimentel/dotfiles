local map = vim.keymap.set
-- opt.clipboard:append("unnamedplus") -- use system clipboard on all actions
-- use system clipboard on yank only
map({ "n", "v" }, "y", '"+y')
map("n", "Y", '"+y$')

map("n", "<leader>n", "<CMD>setlocal number!<CR>")
map({ "n", "v" }, "<leader>*", "*Ncgn", { remap = true }) -- replace keyword under cursor
map("n", ".", ".`.") -- moves to beginning of change

-- bufferline.nvim
map("n", "H", "<CMD>BufferLineCyclePrev<CR>")
map("n", "L", "<CMD>BufferLineCycleNext<CR>")

-- Comment.nvim
map("v", "<leader>/", "gc", { remap = true })
map("n", "<leader>/", "gcc", { remap = true })
map("n", "<leader>a", "gcA", { remap = true })
map("n", "<leader>o", "gco", { remap = true })
map("n", "<leader>O", "gcO", { remap = true })
