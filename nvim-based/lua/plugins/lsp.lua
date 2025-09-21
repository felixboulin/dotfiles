---@diagnostic disable: undefined-global

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      end,
    })
    require('mason').setup()
    local servers = {
      lua_ls = {},
      basedpyright = {},
      eslint = {},
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
      automatic_installation = true,
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local lspconfig = require 'lspconfig'
    for name, opts in pairs(servers) do
      opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
      lspconfig[name].setup(opts)
    end
  end,
}
