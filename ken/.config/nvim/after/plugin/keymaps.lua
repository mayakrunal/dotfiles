local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
--keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "<ESC", "<C-\\><C-n>", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Switch buffer
keymap("n", "<A-Left>", ":bprevious<CR>", default_opts)
keymap("n", "<A-Right>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with Control - L
keymap("n", "<C-l>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- split the window
keymap("n", "<A-s>", ":split<CR>", default_opts)
keymap("n", "<A-S-s>", ":vsplit<CR>", default_opts)

-- Resizing panes
keymap("n", "<A-S-Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<A-S-Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<A-S-Up>", ":resize -1<CR>", default_opts)
keymap("n", "<A-S-Down>", ":resize +1<CR>", default_opts)

-- move in windows
-- keymap("n", "<A-Left>", "<C-w><C-w>", default_opts)
-- keymap("n", "<A-Right>", "<C-w><S-w>", default_opts)
keymap("n", "<A-Up>", "<C-w><C-w>", default_opts)
keymap("n", "<A-Down>", "<C-w><S-w>", default_opts)
