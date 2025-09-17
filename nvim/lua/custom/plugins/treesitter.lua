return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        {'nvim-treesitter/playground'}
    },

    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        endwise = { enable = true }, -- closing char - issue with ruby
        indent = { enable = true, disable = { 'yaml' } },
        ensure_installed = {
          'bash',
          'c',
          'html',
          'lua',
          'markdown',
          'markdown_inline',
          'latex',
          'vim',
          'vimdoc',
          'python',
          'javascript',
          'ruby',
          'typescript',
          'json',
          'yaml',
          'css',
          'regex',
          'embedded_template',
          'php',
        },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = {} },
      }
      vim.treesitter.language.register('html', 'gohtmltmpl')

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}
