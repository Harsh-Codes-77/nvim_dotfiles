return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Requires a Nerd Font installed
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neo-tree if it's the only window left
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      
      -- Filesystem settings
      filesystem = {
        filtered_items = {
          visible = false, -- Set to true if you want to see hidden files by default
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true, -- Focus the file you are editing in the tree
          leave_dirs_open = false, 
        },
      },
    })

    -- Keymap to Toggle the explorer
    vim.keymap.set("n", "<leader>e", ":Neotree toggle filesystem reveal left<CR>", { desc = "Toggle File Explorer" })
  end,
}
