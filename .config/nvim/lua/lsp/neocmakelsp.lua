
---@type vim.lsp.Config
local ls_path = "/Users/menazo/.config/nvim/lan_servers/bin/"
return {
  cmd = { ls_path .. "neocmakelsp", "--stdio" },
  filetypes = { "cmake", "CMakeLists.txt" },
 root_markers = { '.git', 'build', 'cmake', 'CMakeLists.txt' },
  single_file_support = true,-- suggested
  init_options = {
      format = {
          enable = true
      },
      lint = {
          enable = true
      },
      scan_cmake_in_package = true -- default is true
  },
  on_attach = function(client, bufnr)

    local chars = {
      "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","r","s","t", ".", ":"
    }
    client.server_capabilities.completionProvider.triggerCharacters = chars

    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger=true,
      convert = function(item)
        return { abbr = item.label:gsub('%b()', '') }
      end,
    })
    -- -- -- vim.api.nvim_create_autocmd({"InsertCharPre"}, {
    -- -- --   callback=function() vim.lsp.completion.get() end
    -- -- -- })
    vim.cmd[[set completeopt=menuone,popup,menu,noselect]]
  end,
}
