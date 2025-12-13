return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- 1. Your Custom Header
    dashboard.section.header.val = {
      [[    ▗▖  ▗▖▗▄▄▄▖▗▖  ▗▖▗▄▄▄▖ ▗▄▖ ▗▖  ▗▖▗▖   ▗▄▄▄▖ ▗▄▄▖▗▄▄▄▖]],
      [[    ▐▛▚▞▜▌  █  ▐▛▚▖▐▌  █  ▐▌ ▐▌▐▛▚▞▜▌▐▌     █  ▐▌     █  ]],
      [[    ▐▌  ▐▌  █  ▐▌ ▝▜▌  █  ▐▛▀▜▌▐▌  ▐▌▐▌     █   ▝▀▚▖  █  ]],
      [[    ▐▌  ▐▌▗▄█▄▖▐▌  ▐▌▗▄█▄▖▐▌ ▐▌▐▌  ▐▌▐▙▄▄▖▗▄█▄▖▗▄▄▞▘  █  ]],
    }

    -- 2. The Buttons
    dashboard.section.buttons.val = {
      dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("g", "  Live Grep", ":Telescope live_grep<CR>"),
      dashboard.button("c", "  Config", ":cd ~/.config/nvim/ | e init.lua<CR>"),
      dashboard.button("u", "  Update Plugins", ":Lazy sync<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    -- 3. The Footer
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ " .. stats.loaded .. " plugins loaded in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    -- Styling
    dashboard.section.header.opts.hl = "Keyword" -- This makes it colorful (matches your theme's keywords)
    dashboard.section.buttons.opts.hl = "Type"
    dashboard.section.footer.opts.hl = "Constant"

    dashboard.opts.layout[1].val = 6 -- Padding at top
    
    alpha.setup(dashboard.opts)
  end,
}
