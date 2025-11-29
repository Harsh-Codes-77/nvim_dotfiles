return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-t>]], -- Press Ctrl + \ to toggle terminal
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      float_opts = { border = "curved",
      },
    })
    
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set("terminal", '<esc>', [[<c-t><C-n>]], opts) -- Esc to exit insert mode in terminal
    end

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
  end
}
