vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({ import = 'custom/plugins' }, {
  change_detection = {
    notify = false,
  },
})

-- ONLY when working on published plugin locally
package.path = package.path .. ';/Users/felixboulin/dev/prompt.nvim/lua/?.lua'
-- Require the plugin
require('prompt.init').setup {
  mistral = {
    default = 'open-mistral-7b',
    small = 'open-mistral-7b',
    medium = 'mistral-small-latest',
    large = 'mistral-large-latest',
  },
  claude = {
    default = 'claude-3-5-sonnet-latest',
    small = 'claude-3-haiku-20240307',
    medium = 'claude-3-5-sonnet-latest',
    large = 'claude-3-opus-20240229',
  },
  chatgpt = {
    default = 'gpt-4.1-mini',
    small = 'gpt-3.5-turbo',
    medium = 'gpt-4o',
    large = 'gpt-4-turbo',
  },
}

-- terminal stuff
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

-- set tab to 2 spaces on html files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- toggle harper_active so i can get rid of it when editing markdown in french
local harper_active = true

function ToggleHarperLS()
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    if client.name == 'harper_ls' then
      if harper_active then
        client.stop()
        print '🔇 Disabled harper_ls for this session.'
      else
        vim.cmd 'LspStart harper_ls'
        print '🔊 Re-enabled harper_ls.'
      end
      harper_active = not harper_active
      return
    end
  end

  if not harper_active then
    vim.cmd 'LspStart harper_ls'
    harper_active = true
    print '🔊 Started harper_ls.'
  else
    print 'harper_ls not currently running.'
  end
end

-- auto detect django html templates to use djlint formatter - cf lsp file
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.html',
  callback = function()
    -- Scan the first 50 lines for Django-style tags
    local lines = vim.api.nvim_buf_get_lines(0, 0, 50, false)
    for _, line in ipairs(lines) do
      if line:find '{%%' or line:find '{{' then
        vim.bo.filetype = 'htmldjango'
        return
      end
    end
  end,
})

-- locally defined auto dark mode on load
require('autodarkmode').set_background_from_system()
-- Activate polling to switch with theme when open
require('autodarkmode').start_auto_watch(1000)
