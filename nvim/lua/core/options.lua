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
opt.tabstop = 2 -- number of spaces a tab is visually worth
opt.shiftwidth = 2 -- amount of spaces created using '>>' or pressing tab
opt.autoindent = true -- indent next line based on current line (default = true)
opt.expandtab = true -- expand tab to spaces (working with tabs in vim can be unconventional)
-- backspace on beginning of line deletes spaces by shiftwidth amount

-- opt.clipboard:append("unnamedplus") -- use system clipboard on all registers
vim.keymap.set({ "n", "v" }, "y", '"+y', {}) -- yank into clipboard
