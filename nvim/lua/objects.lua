local getpos = vim.fn.getpos

local M = {}

function M.visual()
  local col_start = getpos('v')[3]
  local col_end = getpos('.')[3]
  if col_start > col_end then
    col_start, col_end = col_end, col_start
  end
  return vim.api.nvim_get_current_line():sub(col_start, col_end)
end

return M
