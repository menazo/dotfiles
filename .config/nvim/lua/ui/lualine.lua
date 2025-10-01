return {
  options = {
    theme = 'bishoujo'
  },
  sections = {
    lualine_a = {'filename'},
    -- lualine_b = {'FugitiveHead', 'diff'},
    lualine_b = {'mode'},
    lualine_c = {'diagnostics'},
    lualine_x = { 'lan_server', 'data', "vim.lsp.status()" },
    lualine_y = {'buffers'},
    lualine_z = {'location', 'progress'}
  }
}
