---@diagnostic disable: undefined-global

return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.b[bufnr].format_on_save ~= nil then
        return vim.b[bufnr].format_on_save
      end
      return { timeout_ms = 500, lsp_fallback = false }
      -- NOTE: return false to disable
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettier' },
      htmldjango = { 'djlint' },
      gohtmltmpl = { 'djlint' },
      html = { 'prettier' },
      css = { 'prettier' },
      sh = { 'shfmt' },
      -- ruby = { 'rubocop' },
    },
    formatters = {
      djlint = {
        command = vim.fn.expand '~/.pyenv/versions/mainpy/bin/djlint',
        args = { '--reformat', '-' },
        stdin = true,
      },
    },
  },
}
