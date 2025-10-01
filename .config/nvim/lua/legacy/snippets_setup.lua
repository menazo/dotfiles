local opts = { noremap=true, silent=true }
vim.g.ultisnips_python_style = 'google'
vim.api.nvim_set_keymap('n', '<space>es', '<cmd>UltiSnipsEdit<CR>', opts)
vim.cmd([[
let g:UltisnipsEditSplit = 'vertical'
let g:UltiSnipsJumpForwardTrigger = '<C-l>'
let g:UltiSnipsJumpBackwardTrigger = '<C-h>'
]])
