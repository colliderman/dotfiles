require("bufferline").setup({
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true
            }
        }
    }
})
--nnoremap <silent> gb :BufferLinePick<CR>
vim.keymap.set('n', 'gb', ':BufferLinePick<CR>', { silent = true }) 
vim.keymap.set('n', 'gD', ':BufferLinePickClose<CR>', { silent = true })
