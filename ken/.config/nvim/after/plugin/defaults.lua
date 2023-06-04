local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true  -- Enable colors in terminal
opt.hlsearch = true       --Set highlight on search
opt.number = true         --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a"           --Enable mouse mode
opt.breakindent = true    --Enable break indent
opt.undofile = true       --Save undo history
opt.ignorecase = true     --Case insensitive searching unless /C or capital in search
opt.smartcase = true      -- Smart case
opt.updatetime = 250      --Decrease update time
opt.signcolumn = "yes"    -- Always show sign column
opt.autoindent = true     -- indent a newline the same amount as the line just typed
--opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 300      --	Time in milliseconds to wait for a mapped sequence to complete.
opt.list = true
opt.termguicolors = true
opt.mousemoveevent = true

--search configurations
opt.wildignorecase = true
opt.path:remove "/usr/include"
opt.path:append "**"
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"
opt.wildignore:append "**/build/*"
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
