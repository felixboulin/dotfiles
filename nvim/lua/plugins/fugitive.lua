---@diagnostic disable: undefined-global

return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
  end,
}
