vim.opt.hidden = true

require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminall
  open_mapping = [[<C-t>]],
  direction = 'float',
	-- close_on_exit = false, -- close the terminal window when the process exits
	-- shell = "zsh"
}
