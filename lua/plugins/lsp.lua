return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- 1. Setup Mason
    mason.setup()

    -- 2. Setup Mason-LSPConfig
    mason_lspconfig.setup({
      -- CORRECTED LIST BELOW:
      -- 1. Removed "git" (Not an LSP)
      -- 2. Removed "gradle" (Usually 'gradle_ls', but often handled by Java LS)
      -- 3. Confirmed "bashls" and "gopls"
      ensure_installed = { 
        "lua_ls", 
        "pyright", 
        "ts_ls", 
        "html", 
        "cssls", 
        "gopls",  -- Go
        "bashls"  -- Bash
      },
      
      handlers = {
        -- The Default Handler
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Lua Custom Handler
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          })
        end,

        -- Go Custom Handler (Recommended settings)
        ["gopls"] = function()
          lspconfig.gopls.setup({
            capabilities = capabilities,
            settings = {
              gopls = {
                completeUnimported = true, -- Auto-import packages
                usePlaceholders = true,
                analyses = {
                  unusedparams = true,
                },
              },
            },
          })
        end,
      },
    })

    -- 3. Keymaps (Global LspAttach Event)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local keymap = vim.keymap

        opts.desc = "Show documentation"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Go to definition"
        keymap.set("n", "gd", vim.lsp.buf.definition, opts)

        opts.desc = "Code Actions"
        keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        
        opts.desc = "Show Diagnostics"
        keymap.set("n", "<leader>D", vim.diagnostic.open_float, opts)
      end,
    })
  end,
}
