---@diagnostic disable: undefined-global

local grp = vim.api.nvim_create_augroup('frontend_indents', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = grp,
  pattern = {
    'html',
    'htmldjango',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'css',
    'scss',
    'json',
    'yaml',
    'markdown',
  },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})
