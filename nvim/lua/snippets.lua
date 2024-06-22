local snippets = {}

local M = {}

function M.setup(config)
  snippets = config or {}
end

function M.expand()
  -- Get line, cursor-position
  local line = vim.api.nvim_get_current_line()
  local row, cursor = unpack(vim.api.nvim_win_get_cursor(0))
  -- Get word
  local word_start, word_end = line:sub(1, cursor):find("%S+$")
  if not word_start then return false end
  local word = line:sub(word_start, word_end)
  -- Get filetype- and global-snippets
  local snippets_ft = snippets[vim.bo.filetype] or {}
  local snippets_global = snippets['global'] or {}
  -- Get word-snippet
  local snippet = snippets_ft[word] or snippets_global[word]
  if snippet then
    if snippet.b then
      local beginning_of_line = line:sub(1, word_start - 1):find("^%s*$")
      if not beginning_of_line then
        snippet = nil
      end
    end
  end
  if snippet then goto expand end
  -- Iterate over substrings of word and get snippet
  for i = word_start + 1, word_end do
    word = line:sub(i, word_end)
    snippet = snippets_ft[word] or snippets_global[word]
    if snippet then
      if snippet.i then
        word_start = i
        break
      else
        snippet = nil
      end
    end
  end
  if not snippet then return false end
  -- Expand snippet
  ::expand::
  vim.opt.undolevels = vim.opt.undolevels:get() -- undo-break
  vim.api.nvim_buf_set_text(0, row - 1, word_start - 1, row - 1, word_end, {''})
  vim.api.nvim_win_set_cursor(0, {row, word_start - 1})
  vim.snippet.expand(snippet.body)
  return true
end

return M
