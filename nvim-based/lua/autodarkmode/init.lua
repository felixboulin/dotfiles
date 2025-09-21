---@diagnostic disable: undefined-global

local M = {}

local last_mode = nil
local manual_override = false

function M.apply_theme()
  local bg = vim.o.background
  local scheme = (bg == 'light') and 'catppuccin-latte' or 'rose-pine'
  -- pcall avoids throwing if one theme isn't available yet
  -- pcall(vim.cmd.colorscheme, scheme)
end

function M.get_system_appearance()
  local handle = io.popen 'defaults read -g AppleInterfaceStyle 2>/dev/null'
  if not handle then
    return nil
  end

  local result = handle:read '*a' or ''
  handle:close()

  if result:match 'Dark' then
    return 'dark'
  else
    return 'light'
  end
end

function M.set_background(mode)
  if mode and mode ~= last_mode then
    vim.o.background = mode
    last_mode = mode
    vim.cmd("echo 'Background set to " .. mode .. "'")
  end
end

function M.set_background_from_system()
  if not manual_override then
    local mode = M.get_system_appearance()
    M.set_background(mode)
  end
end

function M.start_auto_watch(interval)
  local function poll()
    if manual_override then
      return
    end
    local mode = M.get_system_appearance()
    M.set_background(mode)
    vim.defer_fn(poll, interval or 5000)
  end
  poll()
end

local function toggle_bg_color()
  manual_override = true
  local new_mode = (vim.o.background == 'dark') and 'light' or 'dark'
  vim.o.background = new_mode
  last_mode = new_mode
  M.apply_theme()
  vim.cmd("echo 'Manual override: background set to " .. new_mode .. "'")
end

vim.keymap.set('n', '<leader>bg', toggle_bg_color, { desc = 'Toggle background light/dark' })

-- If the user runs :set background=light/dark manually, also switch theme.
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = function()
    -- Keep last_mode in sync and apply scheme
    last_mode = vim.o.background
    M.apply_theme()
  end,
})
return M
