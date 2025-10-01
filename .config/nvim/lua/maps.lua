local opts = { noremap=true, silent=true }
vim.cmd([[
augroup convert_vim_maps
  au!
  au BufEnter $HOME/Projects/dotfiles/nvim/lua/mappings.lua :vnoremap <buffer> <localC-t>l :s/\s*\([nivc]\).*silent>\s*\(\S*\)\s\+\(:\?\)\(.*\)$/vim.api.nvim_set_keymap("\1", "\2", "\<cmd\>\4", opts)<CR>
]])
--# Personal Mappings
-- Keys
vim.g.mapleader = " "
vim.g.maplocalleader = ';;'
vim.api.nvim_set_keymap( 'i', 'jf', '<Esc>', opts)
vim.api.nvim_set_keymap( 't', 'jf', '<C-\\><C-n>', opts)
vim.api.nvim_set_keymap( 'n', 'j', 'gj', opts)
vim.api.nvim_set_keymap( 'n', 'k', 'gk', opts)
vim.api.nvim_set_keymap( 'v', '<', '<gv', opts)
vim.api.nvim_set_keymap( 'v', '>', '>gv', opts)
-- window navigation
vim.api.nvim_set_keymap( 'n', 'vv', '<C-w>v', opts)
vim.api.nvim_set_keymap( 'n', 'ss', '<C-w>s', opts)
vim.api.nvim_set_keymap( 'n', '<C-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap( 't', '<C-h>', '<C-\\><C-n><C-w>h', opts)
vim.api.nvim_set_keymap( 'n', '<C-j>', '<C-w>j', opts)
vim.api.nvim_set_keymap( 't', '<C-j>', '<C-\\><C-n><C-w>j', opts)
vim.api.nvim_set_keymap( 'n', '<C-k>', '<C-w>k', opts)
vim.api.nvim_set_keymap( 't', '<C-k>', '<C-\\><C-n><C-w>k', opts)
vim.api.nvim_set_keymap( 'n', '<C-l>', '<C-w>l', opts)
vim.api.nvim_set_keymap( 't', '<C-l>', '<C-\\><C-n><C-w>l', opts)
-- Commands
vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>botright 70vsp term://zsh<CR>ia', opts)
-- vim.api.nvim_set_keymap('t', '<C-t>', '<cmd>ToggleTerm<cr>', opts)
-- vim.api.nvim_set_keymap('i', '<C-t>', '<cmd>ToggleTerm<cr>A', opts)
-- vim.api.nvim_set_keymap('n', '<C-t>', '<cmd>ToggleTerm<cr>A', opts)
vim.api.nvim_set_keymap( 'n', '<leader>q', '<cmd>q<CR>', opts)
vim.api.nvim_set_keymap( 'n', '<C-s>', '<cmd>w<CR>', opts)
vim.api.nvim_set_keymap( 'i', '<C-s>', '<Esc><cmd>w<CR>', opts)
vim.api.nvim_set_keymap( 'i', 'wwq', '<Esq>:wq<CR>', opts)
vim.api.nvim_set_keymap( 'n', '<leader>wq', '<Esc>:wq<CR>', opts)
-- Autocomplete
vim.keymap.set(
  'i', '<C-y>',function()
     return vim.fn.complete_info().selected < 0 and '<C-n><C-y>' or '<C-y>'
    end, {
   noremap=true,
   silent=true,
   expr=true
 }
)
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Snippets
local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
