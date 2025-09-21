---@diagnostic disable: undefined-global

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'

vim.g.have_nerd_font = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
-- vim.opt.cursorline = true

-- The below ensures that tab will insert spaces and not tab char.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- add @ to filenames (required to detect modules/libaries like @babel/core)
vim.opt.isfname:append '@-@'

vim.opt.colorcolumn = '80'
vim.opt.lbr = true -- ensures line wrap don't break words in the middle

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

vim.opt.scrollback = 100000

vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

vim.opt.splitbelow = true
vim.opt.splitright = true

-- allow per-project .nvim.lua files
vim.o.exrc = true
