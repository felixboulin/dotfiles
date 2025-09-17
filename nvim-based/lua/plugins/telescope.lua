return {
    'nvim-telescope/telescope.nvim', branch = 'master',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', build='make'},
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup({
            extensions = {
                fzf = {
                  fuzzy = true,                    -- false will only do exact matching
                  override_generic_sorter = true,  -- override the generic sorter
                  override_file_sorter = true,     -- override the file sorter
                  case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                }
              }
        })
        telescope.load_extension('fzf')
        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>sg', function()
            builtin.live_grep {
              additional_args = function()
                return { '--glob', '!_logs/**' }
              end,
            }
        end, { desc = '[S]earch by [G]rep' })
    end,
}
