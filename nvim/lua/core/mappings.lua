local map = vim.keymap.set
vim.g.mapleader = " "

map("n", "<leader>n", "<CMD>setlocal number!<CR>")

map("n", "[q", "<CMD>cprev<CR>")
map("n", "]q", "<CMD>cnext<CR>")
map("n", "[Q", "<CMD>cpfile<CR>")
map("n", "]Q", "<CMD>cnfile<CR>")

-- disables scrolling
map("i", "<Up>", "<Nop>")
map("i", "<Down>", "<Nop>")

-- Navigation that remembers column position
map("i", "<c-j>", "<c-g>j")
map("i", "<c-k>", "<c-g>k")

-- excludes whitespace on motion
map("o", [[a"]], [[2i"]])
map("o", [[a']], [[2i']])
map("o", [[a`]], [[2i`]])

-- dot-repeatable replace keyword under cursor
map({ "n", "v" }, "<leader>*", "*Ncgn", { remap = true })

-- moves to beginning of change
map("n", ".", [[.`.]])

-- relies on opt.virtualedit = "block"
-- keeps column position on visual block
map("v", "{", [[<CMD>silent! keeppatterns ?\v(^$|%^)<CR>]])
map("v", "}", [[<CMD>silent! keeppatterns /\v(^$|%$)<CR>]])

-- bufferline.nvim
map("n", "H", "<CMD>BufferLineCyclePrev<CR>")
map("n", "L", "<CMD>BufferLineCycleNext<CR>")

-- Comment.nvim
map("v", "<leader>/", "gc", { remap = true })
map("n", "<leader>/", "gcc", { remap = true })
map("n", "<leader>a", "gcA", { remap = true })
map("n", "<leader>o", "gco", { remap = true })
map("n", "<leader>O", "gcO", { remap = true })
