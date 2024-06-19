local M = {}

function M.get_visual_selection()
  local mode = vim.fn.mode()
  local line_start, column_start, line_end, column_end

  if mode == 'v' then
    line_start, column_start = unpack(vim.fn.getpos('v'), 2, 3)
    line_end, column_end = unpack(vim.fn.getpos('.'), 2, 3)
  else
    line_start, column_start = unpack(vim.fn.getpos("'<"), 2, 3)
    line_end, column_end = unpack(vim.fn.getpos("'>"), 2, 3)
  end

  if (vim.fn.line2byte(line_start) + column_start) > (vim.fn.line2byte(line_end) + column_end) then
    line_start, column_start, line_end, column_end = line_end, column_end, line_start, column_start
  end

  local lines = vim.fn.getline(line_start, line_end)
  if #lines == 0 then return '' end

  lines[#lines] = lines[#lines]:sub(1, column_end)
  lines[1] = lines[1]:sub(column_start)

  return table.concat(lines, "\n")
end

return M
