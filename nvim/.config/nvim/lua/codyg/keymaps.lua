vim.g.mapleader = ' ' -- set leader to spacebar
vim.g.maplocalleader = ' ' -- look into what this does

-- Open the current file in the default program
vim.keymap.set('n', '<leader>x', ':!open %<cr><cr>')

vim.keymap.set('i', 'jk', '<ESC>') -- remap esc key

vim.keymap.set('n', '<leader>w', '<:w<CR>') -- fast saving
