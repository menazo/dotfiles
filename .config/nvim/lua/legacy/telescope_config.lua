local trouble = require("trouble.providers.telescope")

require'telescope'.setup {
  defaults = {
    mappings = {
      -- i = { ["<c-x>"] = trouble.open_with_trouble },
      n = { ["<A-x>"] = trouble.open_with_trouble },
    },
  },
  extensions = {
    media_files = {
      -- filetypes whitelist
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg" -- find command (defaults to `fd`)
    },
  },
}
require'telescope'.load_extension('media_files')
require'telescope'.load_extension('dap')

