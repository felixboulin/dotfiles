---@diagnostic disable: undefined-global

return {
  'stevearc/oil.nvim',
  lazy = false,
  opts = {
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
  },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<space>-', function()
      require('oil').toggle_float()
    end, { desc = 'Open Oil (float)' })
  end,
}
