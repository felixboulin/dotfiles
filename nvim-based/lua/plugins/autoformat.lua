return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = false,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      javascript = { 'prettier' },
      -- typescript = { 'prettier' },
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
