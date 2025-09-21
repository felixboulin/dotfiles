vim.filetype.add {
  -- Path-based hint (optional but very effective)
  pattern = {
    -- common Django templates folders
    ['.*/templates/.*%.html'] = 'htmldjango',
  },

  -- Content-based sniffing for *.html
  extension = {
    html = function(path, bufnr)
      -- Read up to the first 50 lines safely
      local line_count = math.min(50, vim.api.nvim_buf_line_count(bufnr))
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, line_count, false)

      for _, l in ipairs(lines) do
        -- Django tags/expressions
        if l:find '{%%' or l:find '{{' then
          return 'htmldjango'
        end
      end

      return 'html'
    end,
    dg = 'js',
    zml = 'html',
    m = 'matlab',
  },
}
