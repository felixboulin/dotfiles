return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        columns = { 'icon' },
        keymaps = {
          ['<C-h>'] = false,
          ['<M-h>'] = 'actions.select_split',
          ['<C-y>'] = 'actions.preview',
          ['<CR>'] = 'actions.select',
          ['<C-c>'] = 'actions.close',
          ['gs'] = 'actions.change_sort',
        },
        use_default_keymaps = false,
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

      -- Open parent directory in floating window
      vim.keymap.set('n', '<space>-', require('oil').toggle_float)
    end,
  },
}
-- keymaps = {
--     ["g?"] = "actions.show_help",
--     ["<C-s>"] = "actions.select_vsplit",
--     ["<C-h>"] = "actions.select_split",
--     ["<C-t>"] = "actions.select_tab",
--     ["<C-p>"] = "actions.preview",
--     ["<C-l>"] = "actions.refresh",
--     ["-"] = "actions.parent",
--     ["_"] = "actions.open_cwd",
--     ["`"] = "actions.cd",
--     ["~"] = "actions.tcd",
--     ["gx"] = "actions.open_external",
--     ["g."] = "actions.toggle_hidden",
--     ["g\\"] = "actions.toggle_trash",
--   },
