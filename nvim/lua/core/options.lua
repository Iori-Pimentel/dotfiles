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
opt.laststatus = 3 -- enables global statusline
opt.signcolumn = "yes:1" -- left side padding
opt.wildignorecase = true -- for completion of file names in command mode
opt.cmdwinheight = 5
opt.virtualedit = "block"
opt.list = true
opt.listchars = {
	trail = "~",
	extends = "~",
	precedes = "~",
	lead = "~",
	tab = "| ",
	-- |hl-NonText| highlighting will be used for "eol", "extends" and "precedes".
	-- |hl-Whitespace| for "nbsp", "space", "tab", "multispace", "lead" and "trail".
}
vim.cmd([[colorscheme habamax]])
-- Whitespace highlight links to NonText on habamax colorscheme
vim.cmd([[highlight NonText cterm=bold ctermfg=003]])

if vim.fn.executable("rg") == 1 then
	opt.grepprg = "rg --vimgrep"
	opt.grepformat:prepend("%f:%l:%c:%m") -- fix cursor to be in correct column
else
	-- works only inside git repo
	opt.grepprg = "git grep -n"
end

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = false

-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990
-- tabstop is effectively how many columns of whitespace a \t is worth.
-- shiftwidth is how many columns of whitespace a “level of indentation” is worth.
-- softtabstop is how many columns of whitespace a tab keypress or a backspace keypress is worth.
-- Setting expandtab means that you never wanna see a \t again in your file.

-- opt.clipboard:append("unnamedplus")       -- use system clipboard on all actions
vim.keymap.set({ "n", "v" }, "y", '"+y', {}) -- use system clipboard on yank only
vim.keymap.set({ "n" }, "H", ":BufferLineCyclePrev<CR>", {})
vim.keymap.set({ "n" }, "L", ":BufferLineCycleNext<CR>", {})
