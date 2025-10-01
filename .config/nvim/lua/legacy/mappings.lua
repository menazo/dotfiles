--# See lan server mappings in lan_server_setup.lua
local opts = { noremap=true, silent=true }
vim.cmd([[
augroup convert_vim_maps
  au!
  au BufEnter $HOME/Projects/dotfiles/nvim/lua/mappings.lua :vnoremap <buffer> <localleader>tl :s/\s*\([nivc]\).*silent>\s*\(\S*\)\s\+\(:\?\)\(.*\)$/vim.api.nvim_set_keymap("\1", "\2", "\<cmd\>\4", opts)<CR>
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
vim.api.nvim_set_keymap( 'v', '>', '>gV', opts)
vim.api.nvim_set_keymap( 'v', 'j', 'gj', opts)
vim.api.nvim_set_keymap( 'v', 'k', 'gk', opts)
-- window navigation
vim.api.nvim_set_keymap( 'n', 'vv', '<C-w>v', opts)
vim.api.nvim_set_keymap( 'n', 'ss', '<C-w>s', opts)
-- window navigation mapping for knubie/vim-kitty-navigator
-- set it up manually because the default is not working
-- vim.g.kitty_navigator_no_mappings = 1
-- vim.api.nvim_set_keymap( 'n', '<C-h>', '<cmd>KittyNavigateLeft<CR>', opts)
-- vim.api.nvim_set_keymap( 'n', '<C-j>', '<cmd>KittyNavigateDown<CR>', opts)
-- vim.api.nvim_set_keymap( 'n', '<C-k>', '<cmd>KittyNavigateUp<CR>', opts)
-- vim.api.nvim_set_keymap( 'n', '<C-l>', '<cmd>KittyNavigateRight<CR>', opts)
-- no kitty alternative
-- vim.g.kitty_navigator_no_mappings = 1
-- vim.api.nvim_set_keymap( 'n', '<C-h>', '<C-w>h', opts)
-- vim.api.nvim_set_keymap( 'n', '<C-j>', '<C-w>j', opts)
-- vim.api.nvim_set_keymap( 'n', '<C-k>', '<C-w>k', opts)
-- vim.api.nvim_set_keymap( 'n', '<C-l>', '<C-w>l', opts)
-- Commands
vim.api.nvim_set_keymap('n', '<leader>;', '<cmd>botright 70vsp term://zsh<CR>ia', opts)
vim.api.nvim_set_keymap( 'n', '<leader>q', '<cmd>q<CR>', opts)
vim.api.nvim_set_keymap( 'n', '<C-s>', '<cmd>w<CR>', opts)
vim.api.nvim_set_keymap( 'i', '<C-s>', '<Esc><cmd>w<CR>', opts)
vim.api.nvim_set_keymap( 'i', 'wwq', '<Esq>:wq<CR>', opts)
vim.api.nvim_set_keymap( 'n', '<leader>wq', '<Esc>:wq<CR>', opts)
-- Telescope
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fgr', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader><leader>', '<cmd>Telescope find_files<CR>', opts)
-- dap
vim.api.nvim_set_keymap("n", "<F2>", "<cmd>lua require'dap'.continue()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F9>", "<cmd>lua require'dap'.step_over()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F8>", "<cmd>lua require'dap'.step_into()<CR>", opts)
vim.api.nvim_set_keymap("n", "<F3>", "<cmd>lua require'dap'.step_out()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>pb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>pB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>plp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>pr", "<cmd>lua require'dap'.repl.open()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>pl", "<cmd>lua require'dap'.run_last()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>pc", "<cmd>lua require'dap'.close()<CR>", opts)
-- Trouble
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
-- Goto Preview
vim.api.nvim_set_keymap('n', 'gpd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gpt', '<cmd>lua require("goto-preview").goto_preview_type_definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gpi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gP', '<cmd>lua require("goto-preview").close_all_win()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gpr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>', opts)
-- LSP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>eq', vim.diagnostic.setloclist)
-- Telekasten
vim.api.nvim_set_keymap('n', '<leader>zf', '<cmd>lua require("telekasten").find_notes()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zF', '<cmd>lua require("telekasten").find_friends()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zb', '<cmd>lua require("telekasten").show_backlinks()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zg', '<cmd>lua require("telekasten").search_notes()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zlf', '<cmd>lua require("telekasten").follow_link()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zli', '<cmd>lua require("telekasten").insert_link()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zT', '<cmd>lua require("telekasten").goto_today()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zW', '<cmd>lua require("telekasten").goto_thisweek()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zw', '<cmd>lua require("telekasten").find_weekly_notes()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zn', '<cmd>lua require("telekasten").new_note()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zN', '<cmd>lua require("telekasten").new_templated_note()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zy', '<cmd>lua require("telekasten").yank_notelink()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zc', '<cmd>lua require("telekasten").show_calendar()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zC', '<cmd>CalendarT<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zt', '<cmd>lua require("telekasten").toggle_todo()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>z3', '<cmd>lua require("telekasten").show_tags()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>zr', '<cmd>lua require("telekasten").rename_note()<CR>', opts)

-- " on hesitation, bring up the panel
-- vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>Telekasten panel<CR>', opts)

-- " we could define [[ in **insert mode** to call insert link
-- " inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
-- " alternatively: leader [
-- inoremap <leader>[ <cmd>:lua require('telekasten').insert_link(opts)<CR>
-- inoremap <leader>zt <cmd>:lua require('telekasten').toggle_todo(opts)<CR>
-- inoremap # <cmd>lua require('telekasten').show_tags(opts)<cr>
-- dadbod
vim.api.nvim_set_keymap('n', '<leader>du', '<cmd>DBUIToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>DBUIFindBuffer<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dr', '<cmd>DBUIRenameBuffer<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>DBUILastQueryInfo<CR>', opts)
-- git
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>G<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gv', '<cmd>GV<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gp', '<cmd>G push<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>gpl', '<cmd>G pull<CR>', opts)
--
--#endregion
