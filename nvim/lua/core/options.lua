local opt = vim.opt

opt.number = false
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 2
opt.undofile = true
opt.wrap = false
opt.cursorline = true
opt.ignorecase = true
opt.smartcase = true
opt.background = "dark"
opt.laststatus = 3 -- enables global statusline for split windows
opt.signcolumn = "yes:1" -- left side padding
opt.wildignorecase = true -- for completion of file names in command mode
opt.cmdwinheight = 5
opt.virtualedit = "block"
opt.shortmess:append("I") -- disable intro
opt.numberwidth = 1 -- minimize width of line numbers
opt.colorcolumn = { 79, 80 }
opt.list = true
opt.listchars = {
	tab = "| ",
	precedes = "~", -- overflow symbol when wrap = false
	extends = "~", -- overflow symbol when wrap = false
	trail = ".", -- symbol for trailing spaces
}

-- overflow symbol when wrap = true
opt.fillchars = { lastline = "~" }
-- Disable mouse in insert mode to prevent misclicks when typing
opt.mouse = "nv"

vim.cmd([[colorscheme habamax]])
-- Whitespace highlight links to NonText on habamax colorscheme
vim.cmd([[
	highlight NonText cterm=bold ctermfg=003
	highlight StatusLine ctermbg=003
	highlight GitSignsAdd ctermfg=006
	highlight GitSignsDelete ctermfg=001
	highlight GitSignsChange ctermfg=15
]])

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
