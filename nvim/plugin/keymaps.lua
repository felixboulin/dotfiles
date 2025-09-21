---@diagnostic disable: undefined-global

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'go to previous [d]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'go to next [d]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'show diagnostic [e]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'open diagnostic [q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- moves lines selected in visual mode up and down (will auto indent within blocks)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- ensures that the cursor stays in the middle when jumping up and down
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- ensures that the cursor stays in the middle when going to next and previous search
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- when pasting over the selection, it will keep the initial elements that are pasted in the clipboard so they can be pasted again
vim.keymap.set('x', '<leader>p', [["_dP]])

-- deletes to void register | Delete text without storing it in a register
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

-- makes the <C-c> key in insert mode behave like <Esc>
vim.keymap.set('i', '<C-c>', '<Esc>')

-- maps Q to the <nop> command, which does nothing, disabling the default behavior of Q entering Ex mode.
vim.keymap.set('n', 'Q', '<nop>')

-- reformat the code with LSP integration
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

-- Quickfix list
vim.keymap.set('n', '<leader>k', '<cmd>cnext<CR>zz') -- next quickfix item, center
vim.keymap.set('n', '<leader>j', '<cmd>cprev<CR>zz') -- previous quickfix item, center

-- Location list
vim.keymap.set('n', '<leader>lk', '<cmd>lnext<CR>zz') -- next location list item, center
vim.keymap.set('n', '<leader>lj', '<cmd>lprev<CR>zz') -- previous location list item, center

-- allows to replace the word under the cursor (all instances)
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make the file in the current buffer executable
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- copy the current file relative path to the clipboard
-- vim.keymap.set('n', '<leader>cf', [[:let @+ = expand('%')<CR>]])
-- copy the current file relative path to git root in git repo
vim.keymap.set('n', '<leader>cf', function()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    git_root = vim.fn.getcwd()
  end
  local full_path = vim.fn.expand '%:p'
  local rel_path = vim.fn.fnamemodify(full_path, ':.' .. git_root)
  vim.fn.setreg('+', rel_path)
  vim.fn.setreg('"', rel_path)
  print('Copied git-relative path: ' .. rel_path)
end, { desc = 'Copy Git-relative file path to clipboard' })

vim.keymap.set('n', '<leader>cc', function()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    git_root = vim.fn.getcwd()
  end
  local full_path = vim.fn.expand '%:p'
  local rel_path = vim.fn.fnamemodify(full_path, ':.' .. git_root)
  local wrapped_path = '{{ ' .. rel_path .. ' }}'
  vim.fn.setreg('+', wrapped_path)
  vim.fn.setreg('"', wrapped_path)
  print('Copied git-relative path: ' .. wrapped_path)
end, { desc = 'Copy Git-relative file path to clipboard' })

-- copy the current file full path to the clipboard
vim.keymap.set('n', '<leader>cp', [[:let @+ = expand('%:p')<CR>]])

-- copy the current file name to the clipboard
vim.keymap.set('n', '<leader>cn', [[:let @+ = expand('%:t')<CR>]])

-- These mappings control the size of splits (height/width)
vim.keymap.set('n', '<C-Right>', '<c-w>5<')
vim.keymap.set('n', '<C-Left>', '<c-w>5>')
vim.keymap.set('n', '<C-Up>', '<C-W>+')
vim.keymap.set('n', '<C-Down>', '<C-W>-')

vim.keymap.set('t', '<C-o>', '<C-\\><C-n>', { noremap = true })

-- open a new terminal
-- vim.keymap.set('n', '<leader>t', '<cmd>split term://zsh<CR>')
--

-- crpy entire file to system clipboard
vim.keymap.set('n', '<leader>gg', ':%y+<CR>')

-- search for word below cursor
vim.keymap.set('n', '<leader>l', function()
  local word = vim.fn.expand '<cword>'
  vim.api.nvim_feedkeys('/' .. word, 'n', false)
end, { noremap = true, silent = true })

-- clear search registers
vim.keymap.set('n', '<leader>csr', function()
  for _, r in ipairs {
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  } do
    vim.fn.setreg(r, '')
  end
end, { noremap = true, silent = true })
