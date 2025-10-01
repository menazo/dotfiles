---@type vim.lsp.Config
local ls_path = "/Users/menazo/.config/nvim/lan_servers/"
return {
  cmd = { '/Users/menazo/.cargo/bin/pylyzer', '--server' },
  filetypes = { 'python' },
  root_markers = {
    'setup.py',
    'tox.ini',
    'requirements.txt',
    'Pipfile',
    'pyproject.toml',
    '.git',
  },
  settings = {
    python = {
      diagnostics = true,
      inlayHints = true,
      smartCompletion = true,
      checkOnType = true,
    },
  },
  cmd_env = {
    ERG_PATH = vim.env.ERG_PATH or vim.fs.joinpath(vim.uv.os_homedir(), '.erg'),
  },
  on_attach = function(client, bufnr)
    local chars = {
      "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","r","s","t","u","v","w", ".", ":",
      'A', 'B', 'C','D','E','F','G','H','I','J','K','L','M','N','O','P','R','S','T','U','V','W',"/"
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
    vim.cmd[[set completeopt=menuone,menu,noselect,preview]]
    end,
}
