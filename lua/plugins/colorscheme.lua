return {
  -- 1. The Standard Gruvbox (ellisonleao)
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      -- To use this theme, uncomment the line below:
      -- vim.cmd("colorscheme gruvbox")
    end,
  },

  -- 2. Gruvbox Material (sainnhe) - Has "Hard", "Medium", "Soft" variants
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Option 1: 'hard', 'medium' (default), 'soft'
      vim.g.gruvbox_material_background = "hard" 
      
      -- Option 2: 'material', 'mix', 'original'
      vim.g.gruvbox_material_foreground = "material" 
      
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      
      -- To use this theme, uncomment the line below:
      vim.cmd("colorscheme gruvbox-material")
    end,
  },
}
