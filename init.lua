-- ======================
-- Main Neovim settings
-- ======================

vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Line numbers
vim.o.runtimepath = vim.fn.stdpath('config') .. '/cornelis,' .. vim.o.runtimepath

vim.opt.clipboard:append("unnamedplus")

vim.o.number = true
vim.o.relativenumber = false

-- Indents and tabs
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.smartindent = true

-- Visual things
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.wrap = false

-- Symbols codes
vim.scriptencoding = "utf-8"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

vim.g.mapleader = " "

-- Register functions plug#begin and plug#end
vim.cmd [[
  call plug#begin(stdpath('data') . '/plugged')

    Plug 'neovimhaskell/nvim-hs.vim'
    Plug 'kana/vim-textobj-user'
    Plug 'isovector/cornelis'
    Plug 'sphamba/smear-cursor.nvim'
    Plug 'karb94/neoscroll.nvim'

  call plug#end()
]]

vim.g.cornelis_rewrite_mode = "Normalised"
vim.g.cornelis_use_global_binary = 1

-- 4. Автокоманды и маппинги для .agda-файлов
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.agda",
  callback = function()
    vim.bo.filetype = "agda"

    -- Закрываем окна Cornelis перед закрытием буфера
    vim.api.nvim_create_autocmd("QuitPre", {
      buffer = 0,
      callback = function() vim.cmd("CornelisCloseInfoWindows") end,
    })

    local opts = { noremap = true, silent = true, buffer = true }
    -- <leader>l = CornelisLoad, <leader>r = CornelisRefine и т.д.
    vim.keymap.set("n", "<leader>l", ":CornelisLoad<CR>", opts)
    vim.keymap.set("n", "<leader>r", ":CornelisRefine<CR>", opts)
    vim.keymap.set("n", "<leader>d", ":CornelisMakeCase<CR>", opts)
    vim.keymap.set("n", "<leader>,", ":CornelisTypeContext<CR>", opts)
    vim.keymap.set("n", "<leader>.", ":CornelisTypeContextInfer<CR>", opts)
    vim.keymap.set("n", "<leader>n", ":CornelisNormalize<CR>", opts)
    vim.keymap.set("n", "<leader>g", ":CornelisGoals<CR>", opts)
  end,
})

local opts = { noremap = true, silent = true } 

-- Save file command
vim.keymap.set("n", "<leader>w", ":w<CR>", opts)

-- Add line under cursor in normal mode
vim.keymap.set("n", "<leader>o", "o<Esc>k", opts)
-- Add line before cursor in normal mode
vim.keymap.set("n", "<leader>O", "O<Esc>j", opts)

-- Add space after cursor in normal mode
vim.keymap.set("n", "<leader>-", "a <Esc>", opts)
-- Add space before cursor in normal mode
vim.keymap.set("n", "<leader>_", "i <Esc><Right>", opts)

-- Edit init.lua file command
vim.keymap.set("n", "<leader>e", ":e $MYVIMRC<CR>", opts)

-- Save init.lua file command
vim.keymap.set("n", "<leader>s", ":so $MYVIMRC<CR>", opts)

-- Move rest of the line on the next line command
vim.keymap.set("n", "<leader><CR>", "i<CR><Esc>k$", opts)
-- Tab in normal mode command
vim.keymap.set("n", "<leader><Tab>", "i<Tab><Esc><Right>", opts)

-- Agda Unicode symbols keys
vim.keymap.set("i", "\\=", "≡", opts)
vim.keymap.set("i", "\\=<>", "≡⟨⟩", opts)
vim.keymap.set("i", "\\=<?>", "≡⟨ ? ⟩", opts)
vim.keymap.set("i", "\\=<", "≡⟨ ⟩<Left><Left>", opts)
vim.keymap.set("i", "\\r", "→", opts)
vim.keymap.set("i", "\\s", "∑", opts)
vim.keymap.set("i", "\\la", "λ", opts)
vim.keymap.set("i", "\\cp", "⊔", opts)
vim.keymap.set("i", "\\ep", "ε", opts)
vim.keymap.set("i", "\\N", "ℕ", opts)

-- Move current line command
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', opts)
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', opts)

-- Switch between opened windows commands
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Open new window command
vim.keymap.set('n', '<C-n>', ':vs ', opts)

vim.keymap.set('n', '<C-M-h>', ':vertical resize -1<CR>', opts)
vim.keymap.set('n', '<C-M-l>', ':vertical resize +1<CR>', opts)
vim.keymap.set('n', '<C-M-j>', ':resize -1<CR>', opts)
vim.keymap.set('n', '<C-M-k>', ':resize +1<CR>', opts)

vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", opts)
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'p', "\"_dP", opts)


-- Setup smooth cursor
require('smear_cursor').setup()

