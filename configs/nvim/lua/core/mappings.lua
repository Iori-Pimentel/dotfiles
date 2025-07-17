local map = vim.keymap.set
map({ "n", "x" }, " ", "<Nop>")
vim.g.mapleader = " "

map("n", "<leader>n", "<CMD>setlocal number! hlsearch! wrap! <CR>")

map("n", "<leader>x", function()
	vim.ui.open("https://github.com/" .. vim.fn.expand("<cfile>"))
end)

map("n", "<leader><leader>", function()
	vim.fn.setreg("+", vim.fn.getreg("0"))
end)

map({ "n", "x" }, "j", "gj")
map({ "n", "x" }, "k", "gk")
map("x", "<", "<gv")
map("x", ">", ">gv")

map("n", "[q", "<CMD>cprev<CR>")
map("n", "]q", "<CMD>cnext<CR>")
map("n", "[Q", "<CMD>cpfile<CR>")
map("n", "]Q", "<CMD>cnfile<CR>")

map("n", "[b", "<CMD>earlier 1f<CR>")
map("n", "]b", "<CMD>later 1f<CR>")

-- Alternative to u and <Ctrl-r> which visits all text state
map("n", "-", "g-")
map("n", "+", "g+")

map("i", "<Left>", "<Nop>")
map("i", "<Right>", "<Nop>")
map("i", "<Up>", "<c-x><c-y>")
map("i", "<Down>", "<c-x><c-e>")
map("x", "<Up>", "<c-y>")
map("x", "<Down>", "<c-e>")

-- excludes newline on visual selection
-- keeps column position on visual block
map("x", "{", [[<CMD>silent! keeppatterns ?\v(\n^$|%^)<CR>]])
map("x", "}", [[<CMD>silent! keeppatterns /\v(\n^$|%$)<CR>]])

map("n", "\\", "<CMD>ls<Cr>:b ")
map("n", "H", "<CMD>bprev<CR>")
map("n", "L", "<CMD>bnext<CR>")
