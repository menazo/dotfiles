---@brief
---
--- https://github.com/EmmyLuaLs/emmylua-analyzer-rust
---
--- Emmylua Analyzer Rust. Language Server for Lua.
---
--- `emmylua_ls` can be installed using `cargo` by following the instructions[here]
--- (https://github.com/EmmyLuaLs/emmylua-analyzer-rust?tab=readme-ov-file#install).
---
--- The default `cmd` assumes that the `emmylua_ls` binary can be found in `$PATH`.
--- It might require you to provide cargo binaries installation path in it.

---@type vim.lsp.Config
---

return {
  cmd = { 'emmylua_ls' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.emmyrc.json',
    '.luacheckrc',
    '.git',
  },
  runtime = function ()

    local settings =  {}
    local runtime = settings.Lua and settings.Lua.runtime or {}
    local meta = runtime.meta or "${version} ${language} ${encoding}"
    meta = meta:gsub("%${version}", runtime.version or "LuaJIT")
    meta = meta:gsub("%${language}", "en-us")
    meta = meta:gsub("%${encoding}", runtime.fileEncoding or "utf8")

    return {
      -- paths for builtin libraries
      ("meta/%s/?.lua"):format(meta),
      ("meta/%s/?/init.lua"):format(meta),
      -- paths for meta/3rd libraries
      "library/?.lua",
      "library/?/init.lua",
      -- Neovim lua files, config and plugins
      "lua/?.lua",
      "lua/?/init.lua",
    }
  end,
  workspace = {
    library = function ()
        local ret = {}
        local opts = {
               library = {
          -- these settings will be used for your neovim config directory
          runtime = true, -- runtime path
          types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
          ---@type boolean|string[]
          plugins = true, -- installed opt or start plugins in packpath
          -- you can also specify the list of plugins to make available as a workspace library
          -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        },
      }

      table.insert(ret, "types/nightly")

      local function add(lib, filter)
        ---@diagnostic disable-next-line: param-type-mismatch
        for _, p in ipairs(vim.fn.expand(lib .. "/lua", false, true)) do
          local plugin_name = vim.fn.fnamemodify(p, ":h:t")
          p = vim.loop.fs_realpath(p)
          if p and (not filter or filter[plugin_name]) then
            table.insert(ret, vim.fn.fnamemodify(p, ":h"))
          end
        end
      end

      add(type(opts.library.runtime) == "string" and opts.library.runtime or "$VIMRUNTIME")

      ---@type table<string, boolean>
      local filter
      if type(opts.library.plugins) == "table" then
        filter = {}
        for _, p in pairs(opts.library.plugins) do
          filter[p] = true
        end
      end
      for _, site in pairs(vim.split(vim.o.packpath, ",")) do
        add(site .. "/pack/*/opt/*", filter)
        add(site .. "/pack/*/start/*", filter)
      end

      return ret
    end,

    ignoreDir = { "types/nightly", "lua" },
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
