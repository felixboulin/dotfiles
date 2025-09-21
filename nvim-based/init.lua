---@diagnostic disable: undefined-global

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'config.lazy'
require('autodarkmode').set_background_from_system()
require('autodarkmode').start_auto_watch(1000)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.filetype.add {
  extension = {
    dg = 'js',
    zml = 'html',
    m = 'matlab',
  },
}
