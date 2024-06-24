local get_current_win = vim.api.nvim_get_current_win
local wincmd =  vim.cmd.wincmd

local function move(vim_arg, tmux_arg)
  if not vim.env.TMUX then wincmd(vim_arg) return end
  local old_win = get_current_win()
  wincmd(vim_arg)
  if old_win == get_current_win() then
    vim.fn.system('tmux selectp -' .. tmux_arg)
  end
end

local M = {}

function M.move_left() move('h', 'L') end

function M.move_right() move('l', 'R') end

function M.move_down() move('j', 'D') end

function M.move_up() move('k', 'U') end

return M
