-- [[ Setting options ]]
-- See `:help vim.o`

-- add "-" so that dasherized variables are selected as one word
vim.opt.iskeyword:append "-"
local o = vim.o
local wo = vim.wo

-- Make line numbers default
wo.number = true
wo.signcolumn = 'yes'
wo.relativenumber = true

-- Explorer
vim.g.loaded_netrw = 1 -- disable
vim.g.loaded_netrwPlugin = 1 -- disable
-- True Colors
o.termguicolors = true
-- whitespace
o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
-- vim.o.clipboard:append "unnammedplus"

-- Set highlight on search
o.hlsearch = false

-- Enable mouse mode
o.mouse = 'a'
-- Enable break indent
o.breakindent = true
-- Save undo history
o.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Decrease update time
o.updatetime = 250

-- Set completeopt to have a better completion experience
o.completeopt = 'menuone,noselect'

-- VIM Commands
vim.cmd [[
let g:markdown_fenced_languages = ['javascript','json', 'html', 'typescript', 'rust', 'bash', 'lua', 'vue']
]]
