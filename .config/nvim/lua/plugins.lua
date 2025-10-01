local datapath = vim.fn.stdpath("data") .. "/site/pack/"

local plugins = {
  {
    repo = "tpope/vim-vinegar",
    plugin_type = "essentials",
    plugin_name = "vinegar" 
  },
  {
    repo = "tpope/vim-repeat",
    plugin_type = "essentials",
    plugin_name = "repeat" 
  },
  {
    repo = "tpope/vim-commentary",
    plugin_type = "essentials",
    plugin_name = "commentary" 
  },
  {
    repo = "tpope/vim-surround",
    plugin_type = "essentials",
    plugin_name = "surround" 
  },
  {
    repo = "tpope/vim-fugitive",
    plugin_type = "git",
    plugin_name = "fugitive",
    -- setup = function()
    --   vim.cmd([[vim -u NONE -c "helptags fugitive/doc" -c q]])
    -- end
  },
  {
    repo = 'rktjmp/lush.nvim',
    plugin_type = "essentials",
    plugin_name = "lush" 
  },
  {
    repo = 'nvim-treesitter/nvim-treesitter',
    plugin_type = "lsp",
    plugin_name = "nvim-treesitter",
    branch = "main"
  },
  {
    repo = 'L3MON4D3/LuaSnip',
    plugin_type = "snippets",
    plugin_name = "LuaSnip",
    setup = function()
        require('luasnip').config.setup({ enable_autosnippets = true })
      require('snippets/python')
    end
  },
  {
    repo='nvim-lualine/lualine.nvim',
    plugin_type='ui',
    plugin_name = "lualine",
    -- dependencies = {
    --   'nvim-tree/nvim-web-devicons',
    --   'nvim-lua/lsp-status.nvim'
    -- },
    setup = function()
      require('lualine').setup(
        require('ui/lualine')
      )
    end
  },
  {
    repo = 'akinsho/toggleterm.nvim',
    plugin_type = 'ui',
    plugin_name = 'toggleterm',
    setup = function()
      require('toggleterm').setup({
        open_mapping = '<C-t>',
        direction='float'
      })
    end
  },
  {
    repo = "nvim-lua/plenary.nvim",
    plugin_type = "telescope",
    plugin_name = "plenary"
  },
  {
    repo = "nvim-telescope/telescope.nvim",
    plugin_type = "telescope",
    plugin_name = "telescope",
    -- branch="0.1.8"
    setup = function()
      vim.g.telescope_test_delay = 100
      require("telescope").setup(
        -- require('tlscope/telescope')
      )
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
  },
  {
    repo = '/Users/menazo/Projects/bishoujousenshi.nvim',
    plugin_type = "theme",
    plugin_name = "bishoujo",
    local_src = true,
    setup = function()
      vim.cmd([[colorscheme bishoujo_nvim]])
    end
  },
  {
    -- repo = 'nocksock/do.nvim',
    repo = '/Users/menazo/Projects/do.nvim',
    plugin_type = "ui",
    plugin_name = "do",
    branch = "main",
    local_src = true,
    setup = function()
      vim.opt.runtimepath:prepend("~/Projects/do.nvim")
      require("do").setup(
        require('ui/do')
      )
    end,
  },
}

for i, plugin in ipairs(plugins) do
  local pluginpath = datapath .. plugin.plugin_type .. "/start/" .. plugin.plugin_name
  if not vim.uv.fs_stat(pluginpath) then
    vim.api.nvim_echo({
      {plugin.plugin_name .. " not found.\n"},
      {"Installing " .. plugin.plugin_name .. " from " .. plugin.repo},
      },
      true, {status="running", kind="progress"})
    os.execute("mkdir -p " .. datapath .. plugin.plugin_type .. "/start")
    if plugin.local_src==true then
      os.execute("cp -r " .. plugin.repo .. " " .. pluginpath)
    else
      local repo = "https://github.com/" .. plugin.repo
      if plugin.branch~=nil then
        local branch = "--branch="..plugin.branch
        local out = vim.fn.system({ "git", "clone", branch, "--single-branch", repo, pluginpath })
      else
        local out = vim.fn.system({ "git", "clone", repo, pluginpath })
      end
    end
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone:\n" .. "ErrorMsg" },
      }, true, {
        err=true,
        status="failed",
        kind="progress"
      })
      vim.fn.getchar()
      os.exit(1)
    else
      vim.api.nvim_echo({
        {"Installed " .. plugin.plugin_name .. " to " .. pluginpath},
        },
        true, {status="success", kind="progress"})
    end
  end
  if plugin.setup~=nil then
	  vim.api.nvim_echo({
		  {"Calling setup for " .. plugin.plugin_name .. "\n"},
	  },
	  true, {status="running", kind="progress"})
	  plugin.setup()
  end
  vim.cmd("pa! ".. plugin.plugin_name)
  if vim.uv.fs_stat(pluginpath .. "/doc") then
    vim.cmd("helptags " ..pluginpath.. "/doc")
  end
end



local ls_path = "/Users/menazo/.config/nvim/lan_servers/"
local override = {}
local if_nil = function(val, default)
  if val == nil then return default end
  return val
end
-- local capabilities = {
--     textDocument = {
--       completion = {
--         dynamicRegistration = if_nil(override.dynamicRegistration, false),
--         completionItem = {
--           snippetSupport = if_nil(override.snippetSupport, true),
--           commitCharactersSupport = if_nil(override.commitCharactersSupport, true),
--           deprecatedSupport = if_nil(override.deprecatedSupport, true),
--           preselectSupport = if_nil(override.preselectSupport, true),
--           tagSupport = if_nil(override.tagSupport, {
--             valueSet = {
--               1, -- Deprecated
--             }
--           }),
--           insertReplaceSupport = if_nil(override.insertReplaceSupport, true),
--           resolveSupport = if_nil(override.resolveSupport, {
--               properties = {
--                   "documentation",
--                   "additionalTextEdits",
--                   "insertTextFormat",
--                   "insertTextMode",
--                   "command",
--               },
--           }),
--           insertTextModeSupport = if_nil(override.insertTextModeSupport, {
--             valueSet = {
--               1, -- asIs
--               2, -- adjustIndentation
--             }
--           }),
--           labelDetailsSupport = if_nil(override.labelDetailsSupport, true),
--         },
--         contextSupport = if_nil(override.snippetSupport, true),
--         insertTextMode = if_nil(override.insertTextMode, 1),
--         completionList = if_nil(override.completionList, {
--           itemDefaults = {
--             'commitCharacters',
--             'editRange',
--             'insertTextFormat',
--             'insertTextMode',
--             'data',
--           }
--         })
--       },
--     },
--   }


vim.lsp.config['ruff'] = {
  cmd = { ls_path .. '.lan_servers_venv/bin/ruff', "server"},
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
  settings = {},
}
vim.lsp.enable('ruff')

vim.lsp.config['ty'] = {
  cmd = { ls_path .. '.lan_servers_venv/bin/ty', "server"},
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ty.toml', '.ty.toml', '.git' },
  settings = {},
  capabilities = {
      textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true,
            }
          }
        }
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
vim.lsp.enable('ty')

vim.lsp.config['clangd'] = require('lsp/clangd')
vim.lsp.enable('clangd')

vim.lsp.config['emmylua_ls'] = require('lsp/emmylua')
vim.lsp.enable('emmylua_ls')

vim.lsp.config['marksman'] = require('lsp/marksman')
vim.lsp.enable('marksman')
