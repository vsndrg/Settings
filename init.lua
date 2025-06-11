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

-- Save file command
vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })

-- Add line under cursor in normal mode
vim.keymap.set("n", "<leader>o", "o<Esc>k", { noremap = true, silent = true })
-- Add line before cursor in normal mode
vim.keymap.set("n", "<leader>O", "O<Esc>j", { noremap = true, silent = true })

-- Add space after cursor in normal mode
vim.keymap.set("n", "<leader>-", "a <Esc>", { noremap = true, silent = true })
-- Add space before cursor in normal mode
vim.keymap.set("n", "<leader>_", "i <Esc><Right>", { noremap = true, silent = true })

-- Edit init.lua file command
vim.keymap.set("n", "<leader>e", ":e $MYVIMRC<CR>", { noremap = true, silent = true })

-- Save init.lua file command
vim.keymap.set("n", "<leader>s", ":so $MYVIMRC<CR>", { noremap = true, silent = true })

-- Move rest of the line on the next line command
vim.keymap.set("n", "<leader><CR>", "i<CR><Esc>k$", { noremap = true, silent = true })
-- Tab in normal mode command
vim.keymap.set("n", "<leader><Tab>", "i<Tab><Esc>", { noremap = true, silent = true })

-- Agda Unicode symbols keys
vim.keymap.set("i", "\\=", "≡", { noremap = true, silent = true })
vim.keymap.set("i", "\\=<>", "≡⟨⟩", { noremap = true, silent = true })
vim.keymap.set("i", "\\=<?>", "≡⟨ ? ⟩", { noremap = true, silent = true })
vim.keymap.set("i", "\\=<", "≡⟨ ⟩<Left><Left>", { noremap = true, silent = true })
vim.keymap.set("i", "\\r", "→", { noremap = true, silent = true })
vim.keymap.set("i", "\\s", "∑", { noremap = true, silent = true })
vim.keymap.set("i", "\\la", "λ", { noremap = true, silent = true })
vim.keymap.set("i", "\\cp", "⊔", { noremap = true, silent = true })

-- Move current line command
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', { noremap = true, silent = true })

vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })


-- Setup smooth cursor
require('smear_cursor').setup()

