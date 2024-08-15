local map = vim.keymap.set
map({ "n", "v" }, " ", "<Nop>")
vim.g.mapleader = " "

map("n", "<leader>n", "<CMD>setlocal number!<CR>")

map("n", "[q", "<CMD>cprev<CR>")
map("n", "]q", "<CMD>cnext<CR>")
map("n", "[Q", "<CMD>cpfile<CR>")
map("n", "]Q", "<CMD>cnfile<CR>")

map("n", "[b", "<CMD>earlier 1f<CR>")
map("n", "]b", "<CMD>later 1f<CR>")

-- Moves screen and not cursor when scrolling
map("i", "<Up>", "<c-x><c-y>")
map("i", "<Down>", "<c-x><c-e>")

-- excludes whitespace on motion
map("o", [[a"]], [[2i"]])
map("o", [[a']], [[2i']])
map("o", [[a`]], [[2i`]])

-- dot-repeatable replace keyword under cursor
map({ "n", "v" }, "S", "*Ncgn", { remap = true })

-- moves to beginning of change
map("n", ".", [[.`.]])

-- excludes newline on visual selection
-- keeps column position on visual block
map("v", "{", [[<CMD>silent! keeppatterns ?\v(\n^$|%^)<CR>]])
map("v", "}", [[<CMD>silent! keeppatterns /\v(\n^$|%$)<CR>]])

map("v", "<leader>/", "gc", { remap = true })
map("n", "<leader>/", "gcc", { remap = true })

-- bufferline.nvim
map("n", "H", "<CMD>BufferLineCyclePrev<CR>")
map("n", "L", "<CMD>BufferLineCycleNext<CR>")
