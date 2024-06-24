local fn = vim.fn
local getpos = fn.getpos
local line2byte = fn.line2byte

local M = {}

function M.get_visual_selection()
  local line_start, column_start, line_end, column_end
  if fn.mode() == 'v' then
    line_start, column_start = unpack(getpos('v'), 2, 3)
    line_end, column_end = unpack(getpos('.'), 2, 3)
  else
    line_start, column_start = unpack(getpos("'<"), 2, 3)
    line_end, column_end = unpack(getpos("'>"), 2, 3)
  end
  if (line2byte(line_start) + column_start) > (line2byte(line_end) + column_end) then
    line_start, column_start, line_end, column_end = line_end, column_end, line_start, column_start
  end
  local lines = fn.getline(line_start, line_end)
  if #lines == 0 then return '' end
  lines[#lines] = lines[#lines]:sub(1, column_end)
  lines[1] = lines[1]:sub(column_start)
  return table.concat(lines, "\n")
end

return M
