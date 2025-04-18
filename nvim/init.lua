local api = vim.api
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local bo = vim.bo
local call = vim.call
local cmd = vim.cmd
local command = vim.api.nvim_create_user_command
local env = vim.env
local expand = vim.fn.expand
local feedkeys = vim.api.nvim_feedkeys
local fn = vim.fn
local fs = vim.fs
local g = vim.g
local get_cursor = vim.api.nvim_win_get_cursor
local getqflist = vim.fn.getqflist
local lsp = vim.lsp
local map = vim.keymap.set
local objects = require('objects')
local pumvisible = vim.fn.pumvisible
local replace_termcodes = vim.api.nvim_replace_termcodes
local set = vim.opt
local setl = vim.opt_local
local snippet = vim.snippet
local snippets = require('snippets')
local tbl_isempty = vim.tbl_isempty
local wincmd = vim.cmd.wincmd

-- PLUGINS
local plug_path = fn.stdpath('data') .. '/site/autoload/plug.vim'
if not vim.loop.fs_stat(plug_path) then
  fn.system({'curl', '-fLo', plug_path, '--create-dirs', 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'})
  autocmd('VimEnter', { command = 'PlugInstall --sync | source $MYVIMRC' })
end
map('n', '<space>pc', '<cmd>PlugClean<cr>')
map('n', '<space>pp', '<cmd>PlugUpgrade<bar>PlugUpdate<cr>')
local Plug = fn['plug#']
call('plug#begin')
  Plug('airblade/vim-gitgutter')
  Plug('chrisgrieser/nvim-various-textobjs')
  Plug('echasnovski/mini.ai')
  Plug('echasnovski/mini.splitjoin')
  Plug('gbprod/substitute.nvim')
  Plug('ibhagwan/fzf-lua', { branch = 'main' })
  Plug('idbrii/textobj-word-column.vim')
  Plug('Julian/vim-textobj-variable-segment')
  Plug('kana/vim-textobj-user')
  Plug('machakann/vim-sandwich')
  Plug('neovim/nvim-lspconfig')
  Plug('nvim-lua/plenary.nvim')
  Plug('rbong/vim-flog')
  Plug('ThePrimeagen/harpoon')
  Plug('tpope/vim-fugitive')
call('plug#end')

-- APPEARANCE
cmd.colorscheme('custom')
autocmd('FileType', { callback = function()
  setl.cursorline = false
  vim.treesitter.stop()
end })
map('n', '<space>H', function()
  local row, col = unpack(get_cursor(0))
  cmd.highlight(fn.synIDattr(fn.synID(row, col, 1), 'name'))
end, { desc = 'Show highlight-group under the cursor.' })

-- AUTO-CENTER
autocmd({ 'VimEnter', 'WinEnter', 'WinScrolled' }, { callback = function()
  vim.w.min_line = fn.line('w0')
  vim.w.max_line = fn.line('w$')
end })
autocmd('CursorMoved', { callback = function()
  if not vim.w.min_line then return end
  local line = fn.line('.')
  if line < vim.w.min_line or line > vim.w.max_line then
    cmd.normal({ 'zz', bang = true })
  end
end, desc = 'Center window around cursor if cursor moves outside of window.' })

-- AUTO-CHDIR
autocmd('VimEnter', { callback = function()
  local root = fs.root(0, '.git')
  if root then vim.uv.chdir(root) end
end })

-- AUTO-SAVE
autocmd( 'TextChanged', { nested = true, callback = function()
  cmd.update({ bang = true, mods = { emsg_silent = true } })
end })

-- BUFFERS
map('n', '<space>d', function() cmd.quitall({ bang = true }) end)
map('n', 'q', function() cmd.buffer({ '#', mods = { emsg_silent = true } }) end)
command('Delete', function()
  os.remove(expand('%'))
  cmd.bwipeout()
end, {})
command('Rename', function(opts)
  local old_name = expand('%')
  local new_name = fs.dirname(old_name) .. '/' .. opts.args
  if old_name == new_name then
    return
  elseif os.rename(old_name, new_name) then
    cmd.edit(new_name)
    cmd.bwipeout('#')
  else
    cmd.file(new_name)
  end
end, { nargs = 1 })
set.swapfile = false

-- CHANGE
map({ 'n', 'x' }, 'c', '"_c')
map('n', 'C', '"_C')
map('n', 'cp', 'cip', { remap = true })
map('n', 'cw', 'ciw', { remap = true })
map('n', 'cW', 'ciW', { remap = true })

-- CMDLINE/RULER
set.cmdheight = 0
set.ruler = false
set.showcmd = false
set.showmode = false

-- COMMENTING
autocmd('FileType', { command = 'set formatoptions-=cro' })
autocmd('FileType', { pattern = 'vim', command = 'setl cms=\\"\\ %s' })
map('n', 'gcp', 'gcip', { remap = true })
map('n', 'gcu', 'gcgc', { remap = true })
map('n', 'gcj', function()
  local comment = bo.commentstring:gsub('%%s', '')
  feedkeys('o' .. comment, 'n', false)
end)
map('n', 'gck', function()
  local comment = bo.commentstring:gsub('%%s', '')
  feedkeys('O' .. comment, 'n', false)
end)
map('n', 'gcl', function()
  local comment = bo.commentstring:gsub('%%s', '')
  if bo.filetype == 'python' then
    comment = ' ' .. comment
  end
  feedkeys('A ' .. comment, 'n', false)
end)

-- COMPLETION
require('kind')
set.completeopt = { 'menuone', 'noinsert' }
set.pumheight = 8
set.pumwidth = 0
set.shortmess:append('c')

-- DELETE
map('n', 'dw', 'daw')
map('n', 'dW', 'daW')
map('n', 'dp', function()
  return vim.o.diff and 'dp' or 'dap'
end, { expr = true })

-- FORMATTING
map('n', 'gqp', 'gqip')
map('n', 'gqq', 'Vgq')

-- FZF: CONFIG
require('fzf-lua').setup({
  'max-perf',
  fzf_args = env.FZF_DEFAULT_OPTS,
  hls = { border = 'FloatBorder' },
  winopts = {
    border = 'single',
    preview = { hidden = 'hidden' },
  },
  files = { cmd = env.FZF_DEFAULT_COMMAND },
  oldfiles = { cwd_only = true },
})

-- FZF: BUFFERS & FILES
local fzf = require('fzf-lua')
map('n', 'ff', function() fzf.files() end)
map('n', 'fj', function() fzf.buffers() end)
map('n', 'fl', function() fzf.blines() end)
map('n', 'fQ', function() fzf.loclist() end)
map('n', 'fq', function() fzf.quickfix() end)

-- FZF: SEARCH
map('n', 'fg', function() fzf.grep() end)
map('n', 'fG', function() fzf.live_grep() end)
map('n', 'fw', function() fzf.grep_cword() end)
map('n', 'fW', function() fzf.grep_cWORD() end)
map('x', 'fw', function() fzf.grep_visual() end)

-- FZF: LSP
map('n', 'fr', function() fzf.lsp_references() end)
map('n', 'fs', function() fzf.lsp_document_symbols() end)

-- FZF: MISC
map('n', 'fb', function() fzf.builtin() end)
map('n', 'fc', function() fzf.commands() end)
map('n', 'fh', function() fzf.help_tags() end)

-- GIT
map('n', '<space>kd', '<cmd>0G diff<cr>')
map('n', '<space>ks', '<cmd>G<cr>')

-- GIT-GRAPH
autocmd('FileType', { pattern = 'floggraph', callback = function()
  map('n', '<rightmouse>', '<leftmouse><cr>', { buffer = true, remap = true })
  map('x', '<rightmouse>', '<esc><leftmouse><cr>', { buffer = true, remap = true })
  map('n', 'q', '<Plug>(FlogQuit)', { buffer = true })
end })
g.flog_permanent_default_opts = { date = 'short' }
map('n', '<space>kg', ':Flog -search=')
map('n', '<space>kf', '<cmd>Flog -all -path=%<cr>')
map('n', '<space>kk', '<cmd>Flog -all<cr>')

-- GIT-GUTTER
map('n', '<space>i', '<cmd>silent GitGutterPreviewHunk<cr>')
map('n', '<space>S', '<cmd>silent GitGutterStageHunk<cr>')
map('n', '<space>u', '<cmd>silent GitGutterUndoHunk<cr>')
map('n', '[c', '<cmd>silent GitGutterPrevHunk<cr>')
map('n', ']c', '<cmd>silent GitGutterNextHunk<cr>')
g.gitgutter_map_keys = 0
set.signcolumn = 'yes'

-- GREP
map('n', '<space>g', ':silent grep! ')
set.grepformat = '%f:%l:%c:%m'
set.grepprg = 'ggrep --vimgrep'

-- HARPOON
map('n', '<space>a', function() require('harpoon.mark').add_file() end)
map('n', '<space>m', function() require('harpoon.ui').toggle_quick_menu() end)
map('n', '<space>1', function() require('harpoon.ui').nav_file(1) end)
map('n', '<space>2', function() require('harpoon.ui').nav_file(2) end)
map('n', '<space>3', function() require('harpoon.ui').nav_file(3) end)
map('n', '<space>4', function() require('harpoon.ui').nav_file(4) end)
cmd.highlight({ 'link HarpoonBorder WinSeparator', bang = true })

-- INDENTATION
map('n', '<p', '<ap')
map('n', '>p', '>ap')
set.expandtab = true
set.shiftwidth = 2
set.tabstop = 2

-- LOADED
g.loaded_matchparen = 0
g.loaded_netrw = 0
g.loaded_netrwPlugin = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0

-- LSP
-- Diagnostics
vim.diagnostic.enable(false)
lsp.handlers['textDocument/publishDiagnostics'] = function() end
-- Border
local border = 'single'
local orig_util_open_floating_preview = lsp.util.open_floating_preview
function lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
-- LspAttach
autocmd('LspAttach', { group = augroup('UserLspConfig', {}), callback = function(args)
  local opts = { buffer = args.buf }
  map({ 'i', 'n', 'x' }, '<c-k>', lsp.buf.signature_help, opts)
  map('n', '<space>r', lsp.buf.rename, opts)
  map('n', 'ga', lsp.buf.code_action, opts)
  map('n', 'gD', lsp.buf.declaration, opts)
  map('n', 'gd', lsp.buf.definition, opts)
  map('n', 'gi', lsp.buf.implementation, opts)
  map('n', 'gr', lsp.buf.references, opts)
end })
-- Servers
local capabilities = lsp.protocol.make_client_capabilities()
local lspconfig = require('lspconfig')
lspconfig.ccls.setup({
  capabilities = capabilities,
  init_options = { diagnostics = { onOpen = -1, onChange = -1, onSave = -1 } },
})
lspconfig.jedi_language_server.setup({
  capabilities = capabilities,
  init_options = {
    completion = { ignorePatterns = {"^_.*$"} },
    diagnostics = { enable = false },
  },
})
lspconfig.marksman.setup({ capabilities = capabilities })

-- MAKE
set.makeprg = 'lint'
set.errorformat = '%f:%l:%c:%m'
set.errorformat:append('%f:%l:%c %m')
set.errorformat:append('%f:%l:%m')
set.errorformat:append('%f:%l %m')
map('n', '<space>l', '<cmd>silent make! %<cr>')

-- MAPPINGS
map('n', '<cr>', 'o<esc>')
map('n', '<space>r', ':%s/<c-r><c-w>//gI<left><left><left>')
map('n', 'guw', 'guiw')
map('n', 'guW', 'guiW')
map('n', 'gUw', 'gUiw')
map('n', 'gUW', 'gUiW')
map('n', 'Q', 'q')

-- MOTIONS
map('i', '<c-l>', '<right>')
map('n', 'gH', 'g0')
map('n', 'gh', 'g^')
map('n', 'gl', 'g$')
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', 'H', '0H')
map('n', 'L', '0L')
map('n', 'M', '0M')
map('n', 'n', '<cmd>silent! normal! n<cr>')
map('n', 'N', '<cmd>silent! normal! N<cr>')

-- MOUSE
set.mousemodel = 'extend'
set.mousescroll = 'ver:4'

-- OBJECTS
require('mini.ai').setup({ silent = true })
require('various-textobjs').setup({ notify = { whenObjectNotFound = false } })
map('o', 'ii', '<cmd>lua require("various-textobjs").indentation("inner", "inner")<cr>')
map('o', 'ai', '<cmd>lua require("various-textobjs").indentation("outer", "inner")<cr>')
map('o', 'I',  '<cmd>lua require("various-textobjs").indentation("outer", "outer")<cr>')
map('o', 'B',  '<cmd>lua require("various-textobjs").entireBuffer()<cr>')
map('o', 'v',  '<cmd>lua require("various-textobjs").value("inner")<cr>')
map('o', 'k',  '<cmd>lua require("various-textobjs").key("inner")<cr>')
map('o', '_',  '<cmd>lua require("various-textobjs").lineCharacterwise("inner")<cr>')
map('o', 'a_', '<cmd>lua require("various-textobjs").lineCharacterwise("outer")<cr>')
map('o', 'u',  '<cmd>lua require("various-textobjs").url()<cr>')
map('o', 'au',  '<cmd>lua require("various-textobjs").mdlink("outer")<cr>')
map('o', 'iu', '<cmd>lua require("various-textobjs").mdlink("inner")<cr>')
map('o', 'C',  '<cmd>lua require("various-textobjs").mdFencedCodeBlock("inner")<cr>')
map('o', 'aC', '<cmd>lua require("various-textobjs").mdFencedCodeBlock("outer")<cr>')
map('n', 'gx', function()
  require('various-textobjs').url()
  local foundURL = fn.mode():find('v')
  if not foundURL then return end
  cmd.normal { '"zy', bang = true }
  local url = fn.getreg('z')
  vim.ui.open(url)
end, { desc = 'Smart gx seeks next URL' })
-- Brackets
map('n', 'cb', 'cib', { remap = true })
map('n', 'db', 'dib', { remap = true })
map('n', 'yb', 'yib', { remap = true })
-- Quotes
map('n', 'cq', 'ciq', { remap = true })
map('n', 'dq', 'diq', { remap = true })
map('n', 'yq', 'yiq', { remap = true })
-- Function
map('n', 'cf', 'cif', { remap = true })
map('n', 'df', 'dif', { remap = true })
map('n', 'yf', 'yif', { remap = true })
-- Subword
map('n', 'cs', 'civ', { remap = true })
map('n', 'ds', 'dav', { remap = true })
-- Word-Column
map('n', 'c|', '^cic', { remap = true })
map('n', 'd|', '^dic', { remap = true })

-- QUICKFIX
autocmd('FileType', { pattern = 'qf', callback = function()
  map('n', '<cr>', '<cr>', { buffer = true })
  map('n', 'o', '<cr><cmd>cclose<cr>', { buffer = true })
  map('n', 'p', '<cr><c-w>p', { buffer = true })
  setl.number = false
  setl.signcolumn = 'no'
  setl.wrap = false
end })
autocmd('QuickFixCmdPost', { pattern = '[^l]*', callback = function()
  local height = math.min(#getqflist(), 10)
  if height == 0 then return end
  cmd('copen ' .. height)
  wincmd('=')
end })
autocmd('QuickFixCmdPost', { pattern = 'l*', callback = function()
  local height = math.min(#fn.getloclist(), 10)
  if height == 0 then return end
  cmd('lopen ' .. height)
  wincmd('=')
end })
map('n', '<space>q', function()
  if tbl_isempty(fn.filter(fn.getwininfo(), 'v:val.quickfix')) then
    local height = math.min(#getqflist(), 10)
    if height == 0 then return end
    cmd('copen ' .. height)
    wincmd('=')
  else
    cmd.cclose()
  end
end, { desc = 'Toggle quickfix-window.' })
map('n', '[q', function()
  local qflist = getqflist()
  if tbl_isempty(qflist) then return end
  if getqflist({idx = 0}).idx > 1 then
    cmd.cprevious({ mods = { emsg_silent = true } })
  else
    cmd.clast({ mods = { emsg_silent = true } })
  end
end)
map('n', ']q', function()
  local qflist = getqflist()
  if tbl_isempty(qflist) then return end
  if getqflist({idx = 0}).idx < #qflist then
    cmd.cnext({ mods = { emsg_silent = true } })
  else
    cmd.cfirst({ mods = { emsg_silent = true } })
  end
end)

-- SANDWICH (https://github.com/machakann/vim-sandwich/issues/92)
g.sandwich_no_default_key_mappings = 1
map({ 'n', 'x' }, 's', '<Plug>(operator-sandwich-add)', { remap = true })
map('n', 'sd', '<Plug>(operator-sandwich-delete)a', { remap = true })
map('n', 'sr', '<Plug>(operator-sandwich-replace)a', { remap = true })
map('n', 'sw', 'siw', { remap = true })
map('n', 'sW', 'siW', { remap = true })

-- SCROLLING
autocmd({ 'VimEnter', 'WinEnter', 'WinResized' }, { callback = function()
  set.scrolloff = math.floor(api.nvim_win_get_height(0) * 0.2)
end, desc = 'Set scrolloff based on window-height.' } )
map('n', '<a-d>', '4<c-y>')
map('n', '<a-f>', '4<c-e>')

-- SEARCH
map('n', '<c', '<cmd>set ignorecase!<cr>')
map('n', '<h', '<cmd>set hlsearch!<cr>')
map('n', '<esc>', '<cmd>noh<cr><esc>')
set.ignorecase = true
set.shortmess:append('sS')
set.smartcase = true
-- Don't highlight matches and center after search
map('c', '<enter>', function()
  return vim.tbl_contains({ '/', '?' }, fn.getcmdtype()) and '<enter><cmd>noh<cr>' or '<enter>'
end, { expr = true })
-- Search cword
map('n', '<space>w', function()
  fn.setreg('/', '\\<' .. expand('<cword>') .. '\\>')
  set.hlsearch = true
end)
map('n', '<space>W', function()
  fn.setreg('/', '\\<' .. expand('<cWORD>') .. '\\>')
  set.hlsearch = true
end)
map('x', '<space>w', function()
  fn.setreg('/', objects.visual())
  set.hlsearch = true
  return '<esc>'
end, { expr = true })

-- SETTINGS
set.clipboard = 'unnamedplus'
set.foldenable = false
set.path:append('**')
set.spellcapcheck = ''
set.spellfile = '$XDG_STATE_HOME/nvim/spell/en.utf-8.add'
set.timeout = false
set.virtualedit = 'block'

-- SHELL
map('n', '<space>a', '<cmd>call system("iwltm --send execute")<cr>')

-- SNIPPETS
snippets.setup({
  global = {
    ["'"]  = { body = "'$0'", i = true },
    ["',"] = { body = "'$0',", i = true },
    ['"']  = { body = '"$0"', i = true },
    ['",'] = { body = '"$0",', i = true },
    ['(']  = { body = '($0)', i = true },
    ['(('] = { body = '(\n\t$0\n)', i = true },
    ['<']  = { body = '<$0>', i = true },
    ['[']  = { body = '[$0]', i = true },
    ['{']  = { body = '{$0}', i = true },
    ['{s'] = { body = '{ $0 }', i = true },
    ['{{'] = { body = '{\n\t$0\n}', i = true },
  },
  c = {
    f = { body = '$1($2) {\n\t$0\n}', b = true },
  },
  lua = {
    f = { body = 'function $1($2)\n\t$0\nend' },
    p = { body = 'Plug(\'$0\')'},
    r = { body = 'return'},
    s = { body = '$1 = { body = \'$0\'},', b = true},
  },
  tex = {
    s =   { body = '\\section{$0}', b = true},
    ss =  { body = '\\subsection{$0}', b = true},
    sss = { body = '\\subsubsection{$0}', b = true},
  },
})

-- STATUSLINE/RULER
map('n', '<s', function()
  if vim.o.ls ~= 0 then
    set.laststatus = 0
    set.statusline = '%='
  else
    set.laststatus = 3
    set.statusline = '[%f]%=[%l/%L]'
  end
end, { desc = 'Toggle statusline.' })
set.fillchars = 'diff: ,eob: ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│'
set.laststatus = 0
set.statusline = '%='

-- SUBSTITUTE
local substitute = require('substitute')
substitute.setup({ exchange = { preserve_cursor_position = true } })
map('n', 'x',  function() substitute.operator() end)
map('n', 'xw', function() substitute.operator({ motion='iw' }) end)
map('n', 'xW', function() substitute.operator({ motion='iW' }) end)
map('n', 'xp', function() substitute.operator({ motion='ab' }) end)
map('n', 'xb', function() substitute.operator({ motion='ib' }) end)
map('n', 'xq', function() substitute.operator({ motion='iq' }) end)
map('n', 'xx', function() substitute.line() end)
map('x', 'x',  function() substitute.visual() end)
map('n', 'X',  function() substitute.eol() end)
local exchange = require('substitute.exchange')
map('n', '<space>x',  function() exchange.operator() end)
map('n', '<space>xw', function() exchange.operator({ motion='iw' }) end)
map('n', '<space>xW', function() exchange.operator({ motion='iW' }) end)
map('n', '<space>xp', function() exchange.operator({ motion='ap' }) end)
map('n', '<space>xb', function() exchange.operator({ motion='ib' }) end)
map('n', '<space>xq', function() exchange.operator({ motion='iq' }) end)
map('n', '<space>xx', function() exchange.line() end)
map('x', '<space>x',  function() exchange.visual() end)

-- SUPER-TAB
autocmd('CompleteDone', { callback = function()
  if vim.v.completed_item.user_data == nil then return end
  if vim.v.completed_item.user_data.nvim == nil then return end
  -- vim.notify(vim.inspect(vim.v.completed_item.user_data.nvim.lsp.completion_item))
  local kind = vim.v.completed_item.user_data.nvim.lsp.completion_item.kind
  if kind ~= 3 then return end
  -- <esc>a exits insert-mode and reenters it immediatly again. This fixes a bug where subsequent completions would not complete the next typed word after the previous paranthesis-insertion but rather insert new paranthesis again. This happenes at least with the ccls-lsp.
  feedkeys(replace_termcodes('()<left><esc>a<c-g>u', true, false, true), 'n', false)
end, desc = 'Append parentheses if completed item is a function or method.' })
map('i', '<tab>', function()
  local line = api.nvim_get_current_line():sub(1, get_cursor(0)[2])
  -- if pumvisible() == 1 then
    -- local items = vim.fn.complete_info({'items'}).items
    -- vim.notify(vim.inspect(items))
    -- local words = {}
    -- for _, item in ipairs(items) do
    --   table.insert(words, item.word)
    -- end
    -- vim.notify(vim.inspect(words))
  if not line:match('%S$') then
    feedkeys(replace_termcodes('<tab>', true, false, true), 'n', false)
  elseif snippets.expand() then
    return
  elseif line:match('/%S*$') then
    feedkeys(replace_termcodes('<c-x><c-f>', true, false, true), 'n', false)
  elseif bo.omnifunc ~= '' then
    feedkeys(replace_termcodes('<c-x><c-o>', true, false, true), 'n', false)
    vim.defer_fn(function()
      if pumvisible() == 1 then return end
      feedkeys(replace_termcodes('<c-x><c-n>', true, false, true), 'n', false)
    end, 100)
  else
    feedkeys(replace_termcodes('<c-x><c-n>', true, false, true), 'n', false)
  end
end, { desc = 'Super-Tab to expand snippets and trigger completion.' })
map('i', '<cr>', function()
  if pumvisible() == 1 then
    feedkeys(replace_termcodes('<c-y>', true, false, true), 'n', false)
  else
    feedkeys(replace_termcodes('<cr>', true, false, true), 'n', false)
  end
end)
map({ 'i', 's' }, '<a-j>', function()
  if pumvisible() == 1 then
    feedkeys(replace_termcodes('<down>', true, false, true), 'n', false)
  elseif snippet.active({ 1 }) then
    snippet.jump(1)
  end
end)
map({ 'i', 's' }, '<a-k>', function()
  if pumvisible() == 1 then
    feedkeys(replace_termcodes('<up>', true, false, true), 'n', false)
  elseif snippet.active({ -1 }) then
    snippet.jump(-1)
  end
end)

-- TABLINE
set.showtabline = 1
set.tabline = '%!tabline#Show()'
map('n', '<a-e>', 'gT')
map('n', '<a-r>', 'gt')
map('n', '<space>n', '<cmd>tab split<cr>')

-- TRANSFORM
map('n', 't', '<cmd>call toggle#Next()<cr>')
map({ 'n', 'x' }, 'gs', function() require('sort').sort() end)
require('mini.splitjoin').setup({ mappings = { toggle = '<space>t' } })
local gen_hook = MiniSplitjoin.gen_hook
local curly = { brackets = { '%b{}' } }
local add_comma_curly = gen_hook.add_trailing_separator(curly)
local del_comma_curly = gen_hook.del_trailing_separator(curly)
local pad_curly = gen_hook.pad_brackets(curly)
vim.b.minisplitjoin_config = {
  split = { hooks_post = { add_comma_curly } },
  join  = { hooks_post = { del_comma_curly, pad_curly, } },
}

-- UNDO
map('n', 'U', '<cmd>silent! redo<cr>')
map('n', 'u', '<cmd>silent! undo<cr>')

-- WINDOWS: MANAGEMENT
autocmd('VimResized', { callback = function() wincmd('=') end })
map('n', '<space>c', '<c-w>c')
map('n', '<space>s', '<c-w>s')
map('n', '<space>v', '<c-w>v')
map('n', '<space>z', '<c-w>z')
set.splitbelow = true
set.splitright = true

-- WINDOWS: NAVIGATION
local tmux = require('tmux')
map('n', '<a-h>', function() tmux.move_left() end)
map('n', '<a-j>', function() tmux.move_down() end)
map('n', '<a-k>', function() tmux.move_up() end)
map('n', '<a-l>', function() tmux.move_right() end)

-- WRAP
autocmd('FileType', { command = 'set formatoptions-=t' })
set.breakindent = true
set.linebreak = true
if env.TERM == 'linux' or env.TERM == 'screen' then
  set.showbreak = '  ¬ '
else
  set.showbreak = '  ↳ '
end

-- YANK
autocmd({ 'VimEnter', 'CursorMoved' }, { callback = function()
  vim.w.cursor = get_cursor(0)
end, desc = 'Save cursor-position to restore it later after yank.' })
autocmd('TextYankPost', { callback = function()
  if vim.v.event.operator ~= 'y' then return end
  api.nvim_win_set_cursor(0, vim.w.cursor)
  vim.highlight.on_yank()
end, desc = 'Restore cursor-position after yank.' })
map('n', 'yp', 'yap')
map('n', 'yw', 'yiw')
map('n', 'yW', 'yiW')
