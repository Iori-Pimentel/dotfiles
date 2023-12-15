local opt = vim.opt -- for conciseness

opt.number = true
opt.scrolloff = 8
opt.undofile = true
opt.wrap = false
opt.cursorline = true
opt.ignorecase = true
opt.smartcase = true
opt.background = "dark"
opt.signcolumn = "yes:1" -- left side padding

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2

-- https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990
--
-- tabstop answers the question: how many columns of whitespace is a \t char
-- worth? Think of a set of vertical lines running down the length of your
-- paper. shiftwidth answers the question: how many columns of whitespace a
-- “level of indentation” is worth? softtabstop answers the question: how many
-- columns of whitespace is a tab keypress or a backspace keypress worth?
-- Setting expandtab means that you never wanna see a \t again in your file —
-- rather, tabs keypresses will be expanded into spaces 999 times outta 1000,
-- I’ll want all integer options set to be the same. In abbreviated notation,
-- that means we'll run a command like so: :set ts=2 sw=2 sts=2 et.
--
-- tabstop is effectively how many columns of whitespace a \t is worth.
-- shiftwidth is how many columns of whitespace a “level of indentation” is
-- worth. Setting expandtab means that you never wanna see a \t again in your
-- file softtabstop is how many columns of whitespace a tab keypress or a
-- backspace keypress is worth.

-- opt.clipboard:append("unnamedplus") -- use system clipboard on all registers
vim.keymap.set({ "n", "v" }, "y", '"+y', {}) -- yank into system clipboard
