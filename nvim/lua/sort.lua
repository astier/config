local M = {}

local mode

function M.sort(type)
  if not type then
    vim.o.operatorfunc = "v:lua.require'sort'.sort"
    mode = vim.fn.mode()
    if mode == 'V' then
      vim.cmd('normal! g@')
    elseif vim.fn.indent('.') == 0 then
      vim.cmd('normal! g@ip')
    else
      vim.cmd('normal g@ii')
    end
  else
    if mode == 'V' then
      vim.cmd("'<,'>sort i")
    else
      vim.cmd("'[,']sort i")
    end
  end
end

return M
