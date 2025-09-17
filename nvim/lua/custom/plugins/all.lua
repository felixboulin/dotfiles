return {
  -- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  'NMAC427/guess-indent.nvim',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
  -- COLORSCHEME
  {
    'catppuccin/nvim',
    -- "folke/tokyonight.nvim",
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'macchiato',
        },
        transparent_background = true,
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      keywords = {
        FIX = {
          icon = ' ', -- icon used for the sign, and in search results
          color = 'error', -- can be a hex color, or a named color (see below)
          alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        -- FIX:
        -- QUESTION:
        -- HACK:
        -- WARNING:
        -- PERF:
        -- TEST:
        -- NOTE:
        TODO = { icon = ' ', color = 'info' },
        HACK = { icon = ' ', alt = { 'QUESTION' } },
        WARN = { icon = ' ', alt = { 'WARNING' } },
        PERF = { icon = ' ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
        NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        TEST = { icon = '⏲ ', color = 'test', alt = { 'TESTING', 'PASSED', 'FAILED' } },
      },
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
    end,
  },

  -- {
  --   'github/copilot.vim',
  -- },

  -- TODO: review mapping conflicts
  -- h,l taken (where?)
  --
  {
    'Exafunction/windsurf.vim',
    event = 'BufEnter',
    config = function()
      vim.keymap.set('i', '<C-g>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-j>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      -- vim.keymap.set('i', '<C-h>', function()
      --   return vim.fn['codeium#CycleCompletions'](-1)
      -- end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })
      -- vim.keymap.set('i', '<C-k>', function()
      --   return vim.fn['codeium#AcceptNextWord']()
      -- end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-k>', function()
        return vim.fn['codeium#AcceptNextLine']()
      end, { expr = true, silent = true })
      --   vim.keymap.set('i', '<C-k', function()
      --     return vim.fn['codeium#Complete']()
      --   end, { expr = true, silent = true })
    end,
  },
  -- {
  --   'github/copilot-cmp',
  --   config = function()
  --     require('copil

  -- {
  --   'felixboulin/prompt.nvim',
  --   config = function()
  --     require('prompt').setup {
  --       default_model = 'mistral-medium',
  --     }
  --   end,
  -- },
  {
    'kawre/leetcode.nvim',
    dependencies = {
      -- include a picker of your choice, see picker section for more details
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      lang = 'python3',
    },
  },
  -- {
  --   'MeanderingProgrammer/render-markdown.nvim',
  --   main = 'render-markdown', -- IMPORTANT so opts are applied
  --   ft = { 'markdown' }, -- load only for markdown buffers
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'echasnovski/mini.nvim', -- or mini.icons / devicons
  --   },
  --   opts = {
  --     enabled = true,
  --     restart_highlighter = true, -- clears weird TS state on lazy load
  --     file_types = { 'markdown' }, -- ensure md is included
  --     latex = {
  --       enabled = true,
  --       converter = 'latex2text', -- uses pylatexenc if present
  --       position = 'above',
  --       top_pad = 0,
  --       bottom_pad = 0,
  --     },
  --     -- leave render_modes at the default (don’t set it to false)
  --     -- window options are managed automatically; don’t force conceallevel=0 elsewhere
  --   },
  -- },
}
