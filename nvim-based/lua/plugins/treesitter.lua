return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        {'nvim-treesitter/playground'}
    },
    build = ':TSUpdate',
    config = function()
         require('nvim-treesitter.configs').setup {
            auto_install = true,
            ensure_installed = {
              'bash',
              'c',
              'html',
              'lua',
              'markdown',
              'markdown_inline',
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
            highlight = {
                enable = true,       -- << enable Tree-sitter highlighting
                disable = {},        -- list of languages to *not* use TS for
                additional_vim_regex_highlighting = false,
              },
            playground = {
                enable = true,
            },
        }
    end,
}
