local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Modes:
-- n 	Normal Mode
-- i	Insert Mode
-- v	Visual Mode
-- t 	Term Mode
-- c	Command Mode

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

--- diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
--- nav menu
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { silent = true })
keymap("v", "<Leader>e", ":NvimTreeToggle<CR>", { silent = true })
-- symbols menu
keymap("n", "<Leader>s", ":SymbolsOutline<CR>", { silent = true })
keymap("v", "<Leader>s", ":<CR>", { silent = true })

-- windows
keymap("n", "<A-Plus>", ":resize -2<CR>", { silent = true })


-- keymap("n", "<Cmd><Up>", ":<C-U>call matchit#Match_wrapper('',1,'n')<CR>", { silent = true })

-- move
keymap("v", "<Cmd+Alt><Up>", "<Esc>:m .+1<CR>==gi", opts)
keymap("v", "<Cmd+Alt><Down>", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "p", '"_dP', opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("n", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("n", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- find files
keymap("n", "ff", ":Telescope find_files<CR>", { silent = true })
keymap("v", "ff", ":Telescope find_files<CR>", { silent = true })
keymap("i", "<Ctrl>f<Ctrl>f", "<ESC>:Telescope find_files<CR>i", { silent = true })
--- find grep
keymap("n", "fG", ":Telescope live_grep<CR>", opts)
keymap("v", "fG", ":Telescope live_grep<CR>", opts)
-- find projects
keymap("n", "fp", ":Telescope projects<CR>", opts)
keymap("v", "fp", ":Telescope projects<CR>", opts)
-- find buffers
keymap("n", "fb", ":Telescope buffers<CR>", opts)
keymap("v", "fb", ":Telescope buffers<CR>", opts)

-- better paste
keymap("v", "p", '"_dP', opts)

-- symbols
keymap("n", "S", ":lua require'lspactions'.rename()<CR>", { noremap = true })
-- code action
keymap("n", "<Cmd+Alt>", ":lua require'lspactions'.code_action()<CR>", { noremap = true })
-- deal with caps lock
vim.keymap.set({ "i", "c", "n" }, "<C-g>c", "<Plug>CapsLockToggle")
vim.keymap.set("i", "<C-l>", "<Plug>CapsLockToggle")

-- split
keymap("n", "<Leader>v", ":vsplit<CR>", { silent = true })
keymap("n", "<Leader>h", ":split<CR>", { silent = true })

-- formatting
keymap("n", "<Leader>F", ":Format<CR>", { silent = true })
keymap("i", "<Cmd+Alt>f", "<ESC>:Format<CR>i", { silent = true })
