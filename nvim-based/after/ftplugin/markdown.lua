---@diagnostic disable: undefined-global

-- auto wrap on insert mode on markdown
vim.cmd [[
    setlocal wrapmargin=10
    setlocal formatoptions+=t
    setlocal linebreak
    setlocal spell
]]
