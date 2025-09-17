return {
  --   {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   config = function()
  --     require('catppuccin').setup {
  --       flavour = 'macchiato', -- latte, frappe, macchiato, mocha
  --       background = { -- :h background
  --         light = 'latte',
  --         dark = 'macchiato',
  --       },
  --       transparent_background = true,
  --     }
  --     vim.cmd.colorscheme 'catppuccin'
  --   end,
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        require("rose-pine").setup({
        --- @usage 'auto'|'main'|'moon'|'dawn'
        variant = "auto",       -- auto uses vim.o.background to pick light/dark
        -- dark_variant = "moon",  -- when background=dark → use moon
        dim_inactive_windows = true,
        extend_background_behind_borders = true,
      })

      -- pick initial background
      vim.o.background = "dark"
      vim.cmd.colorscheme("rose-pine")
    end
}
}
