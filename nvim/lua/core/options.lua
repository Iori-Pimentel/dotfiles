local opt = vim.opt

opt.number = false
opt.numberwidth = 1
opt.colorcolumn = { 79, 80 }
opt.cursorline = true
-- left side padding
opt.signcolumn = "yes:1"
-- disable intro
opt.shortmess:append("I")

opt.splitbelow = true
opt.splitright = true
opt.cmdwinheight = 5
-- enables global statusline for split windows
opt.laststatus = 3

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = false
opt.hlsearch = false
opt.wrapscan = false

opt.undofile = true
opt.wrap = false
opt.mouse = "n"
opt.scrolloff = 2
opt.virtualedit = "block"
-- for completion of file names in command mode
opt.wildignorecase = true

opt.listchars = {
	tab = "╎ ",
	trail = ".",
}

if vim.fn.executable("rg") == 1 then
	opt.grepprg = "rg --vimgrep"
	opt.grepformat:prepend("%f:%l:%c:%m") -- fix cursor to be in correct column
else
	-- works only inside git repo
	opt.grepprg = "git grep -n"
end

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = false
-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990
-- tabstop is effectively how many columns of whitespace a \t is worth.
-- shiftwidth is how many columns of whitespace a “level of indentation” is worth.
-- softtabstop is how many columns of whitespace a tab keypress or a backspace keypress is worth.
-- Setting expandtab means that you never wanna see a \t again in your file.
