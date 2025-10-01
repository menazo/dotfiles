-- Activate this by adding lua require'jupyter_setup'.setup() to your init.vim
-- or require'jupyter_setup'.setup() to init.lua
local M = {}

vim.g.ipy_celldef = '^##'

local function bash_cmd(input)
  local handle = io.popen(input)
  local out = handle:read("*a")
  handle:close()
  return out
end

M.connect_to_ipy_kernel = function()
  local kernel = bash_cmd('echo "ipykernel_$(basename $(pwd))" | tr -d "\n"')
  vim.call({'IPyConnect'},{'--kernel', kernel, '--no-window'})
end

M.run_console = function()
    bash_cmd("jupyter qtconsole --JupyterWidget.include_other_output=True")
end

vim.cmd([[
	command! RunQtConsole lua require('jupyter_setup').run_console()
	command! ConnectToIPyKernel lua require('jupyter_setup').connect_kernel()
]])

-- -- Example Mappings
-- local opts = { noremap=true, silent=true }
-- vim.g.nvim_ipy_perform_mappings = 0 -- deactivate nvim-ipy debug mappings
-- vim.api.nvim_set_keymap( 'n', '<leader>jqt', '<cmd>RunQtConsole<CR>', opts)
-- vim.api.nvim_set_keymap( 'n', '<leader>jk', '<cmd>ConnectToIPyKernel<CR>', opts)
-- vim.api.nvim_set_keymap( 'n', '<leader>jc', '<Plug>(IPy-RunCell)', opts)

return M
