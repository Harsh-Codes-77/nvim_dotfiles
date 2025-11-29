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

    -- 2. Setup Mason-LSPConfig with "Handlers"
    -- This automatically handles the setup for every server you install
    mason_lspconfig.setup({
      ensure_installed = { "lua_ls", "pyright", "ts_ls", "html", "cssls" },
      handlers = {
        -- The Default Handler (Applies to any server without a custom one)
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Custom Handler for Lua (needs special settings)
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
      },
    })

    -- 3. Keymaps (Global LspAttach Event)
    -- This sets the keybinds ONLY when an LSP server attaches to a buffer
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
