" PLUGINS
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
  execute '!curl -fLo' plug_path '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd vimenter * PlugInstall --sync | source $MYVIMRC
endif
nnoremap <space>pc <cmd>PlugClean<cr>
nnoremap <space>pp <cmd>PlugUpgrade<bar>PlugUpdate<cr>
call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'aserowy/tmux.nvim'
  Plug 'chrisgrieser/nvim-various-textobjs'
  Plug 'dcampos/nvim-snippy'
  Plug 'echasnovski/mini.ai'
  Plug 'echasnovski/mini.splitjoin'
  Plug 'gbprod/substitute.nvim'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'ibhagwan/fzf-lua', { 'branch': 'main' }
  Plug 'idbrii/textobj-word-column.vim'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'kana/vim-textobj-user'
  Plug 'kevinhwang91/nvim-bqf'
  Plug 'machakann/vim-sandwich'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'rbong/vim-flog'
  Plug 'romainl/vim-qf'
  Plug 'ThePrimeagen/harpoon'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
call plug#end()

lua << EOF
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

-- APPEARANCE
vim.cmd.colorscheme('custom')
autocmd('FileType', { callback =
  function() vim.opt_local.cursorline = false
end })
map('n', '<space>H', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local synID = vim.fn.synID(row, col, 1)
  local synIDattr = vim.fn.synIDattr(vim.fn.synID(row, col, 1), 'name')
  vim.cmd.highlight(synIDattr)
end, { desc = 'Show highlight-group under the cursor.' })

-- AUTOCHDIR
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local root = vim.fs.root(0, '.git')
    if root then vim.uv.chdir(root) end
  end,
})

-- AUTOSAVE
autocmd({ 'TextChanged', 'InsertLeave' }, {
  nested = true,
  callback = function()
    if vim.bo.readonly then return end
    vim.cmd.update({ mods = { silent = true } })
  end
})

-- BUFFERS
map('n', '<space>d', function() vim.cmd.quitall({ bang = true }) end)
map('n', 'q', function() vim.cmd.buffer('#') end)
vim.opt.swapfile = false

-- CHANGE
map({ 'n', 'x' }, 'c', '"_c')
map('n', 'C', '"_C')
map('n', 'cp', 'cip', { remap = true })
map('n', 'cw', 'ciw', { remap = true })
map('n', 'cW', 'ciW', { remap = true })

-- CMDLINE/RULER
vim.opt.cmdheight = 0
vim.opt.ruler = false
vim.opt.showcmd = false
vim.opt.showmode = false

-- COMMENTING
autocmd('FileType', { command = 'set formatoptions-=cro' })
autocmd('FileType', { pattern = 'vim', command = 'setl cms=\\"\\ %s' })
map('n', 'gcp', 'gcip', { remap = true })
map('n', 'gcu', 'gcgc', { remap = true })
map('n', 'gcj', function()
  local comment = vim.bo.commentstring:gsub('%%s', '')
  vim.api.nvim_feedkeys('o' .. comment, 'n', false)
end)
map('n', 'gck', function()
  local comment = vim.bo.commentstring:gsub('%%s', '')
  vim.api.nvim_feedkeys('O' .. comment, 'n', false)
end)
map('n', 'gcl', function()
  local comment = vim.bo.commentstring:gsub('%%s', '')
  if vim.bo.filetype == 'python' then
    comment = ' ' .. comment
  end
  vim.api.nvim_feedkeys('A ' .. comment, 'n', false)
end)

-- COMPLETION
vim.opt.completeopt = { 'menuone', 'noinsert' }
vim.opt.pumheight = 8
vim.opt.pumwidth = 0
vim.opt.shortmess:append('c')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require('cmp')
local snippy = require('snippy')
cmp.setup({
  completion = {
    autocomplete = false,
    completeopt = table.concat(vim.opt.completeopt:get(), ","),
  },
  view = { docs = { auto_open = false } },
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  window = {
    completion = {
      border = 'single',
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal,CursorLine:LspSignatureActiveParameter',
    },
    documentation = {
      border = 'single',
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal,CursorLine:LspSignatureActiveParameter',
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<tab>'] = cmp.mapping(function(fallback)
      if snippy.can_expand() then
        snippy.expand()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end),
    ['<a-j>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = 'select' })
      elseif snippy.can_jump(1) then
        snippy.next()
      end
    end),
    ['<a-k>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({ behavior = 'select' })
      elseif snippy.can_jump(-1) then
        snippy.previous()
      end
    end),
    ['K'] = cmp.mapping(function(fallback)
      if cmp.visible_docs() then
        cmp.close_docs()
      elseif cmp.visible() then
        cmp.open_docs()
      else
        fallback()
      end
    end),
    ['<cr>']  = cmp.mapping.confirm({ select = true }),
    ['<a-d>'] = cmp.mapping.scroll_docs(-4),
    ['<a-f>'] = cmp.mapping.scroll_docs(4),
  }),
  sources = cmp.config.sources(
    {{ name = 'path' }},
    {{ name = 'nvim_lsp' }},
    {{ name = 'buffer' }}
  ),
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = ({})[vim_item.kind]
      vim_item.menu = ({})[entry.source.name]
      return vim_item
    end
  },
})

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
  fzf_args = vim.env.FZF_DEFAULT_OPTS,
  winopts = {
    border = 'single',
    preview = { hidden = 'hidden' },
    hl = { border = 'FloatBorder' },
  },
  files = { cmd = vim.env.FZF_DEFAULT_COMMAND },
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
autocmd('FileType', {
  pattern = 'floggraph',
  callback = function()
    map('n', '<rightmouse>', '<leftmouse><cr>', { buffer = true, remap = true })
    map('x', '<rightmouse>', '<esc><leftmouse><cr>', { buffer = true, remap = true })
    map('n', 'q', '<Plug>(FlogQuit)', { buffer = true })
  end
})
vim.g.flog_permanent_default_opts = { date = 'short' }
map('n', '<space>kg', ':Flog -search=')
map('n', '<space>kf', '<cmd>Flog -all -path=%<cr>')
map('n', '<space>kk', '<cmd>Flog -all<cr>')

-- GIT-GUTTER
map('n', '<space>i', '<cmd>silent GitGutterPreviewHunk<cr>')
map('n', '<space>S', '<cmd>silent GitGutterStageHunk<cr>')
map('n', '<space>u', '<cmd>silent GitGutterUndoHunk<cr>')
map('n', '[c', '<cmd>silent GitGutterPrevHunk<cr>zz')
map('n', ']c', '<cmd>silent GitGutterNextHunk<cr>zz')
vim.g.gitgutter_map_keys = 0
vim.opt.signcolumn = 'yes'

-- HARPOON
map('n', '<space>a', function() require('harpoon.mark').add_file() end)
map('n', '<space>m', function() require('harpoon.ui').toggle_quick_menu() end)
map('n', '<space>1', function() require('harpoon.ui').nav_file(1) end)
map('n', '<space>2', function() require('harpoon.ui').nav_file(2) end)
map('n', '<space>3', function() require('harpoon.ui').nav_file(3) end)
map('n', '<space>4', function() require('harpoon.ui').nav_file(4) end)
vim.cmd.highlight({ 'link HarpoonBorder WinSeparator', bang = true })

-- INDENTATION
map('n', '<p', '<ap')
map('n', '>p', '>ap')
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- LOADED
vim.g.loaded_matchparen = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- LSP
-- Diagnostics
vim.diagnostic.enable(false)
vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
-- Border
local border = 'single'
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
-- LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local opts = { buffer = args.buf }
    map('i', '<c-k>', vim.lsp.buf.signature_help, opts)
    map('n', '<c-k>', vim.lsp.buf.signature_help, opts)
    map('v', '<c-k>', vim.lsp.buf.signature_help, opts)
    map('n', '<space>r', vim.lsp.buf.rename, opts)
    map('n', 'ga', vim.lsp.buf.code_action, opts)
    map('n', 'gD', vim.lsp.buf.declaration, opts)
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gi', vim.lsp.buf.implementation, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
-- Servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
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
EOF

" MAKE
set makeprg=lint
set errorformat=%f:%l:%c:%m
set errorformat+=%f:%l:%c\ %m
set errorformat+=%f:%l:%m
set errorformat+=%f:%l\ %m
nnoremap <space>l <cmd>silent make! %<cr>

" MAPPINGS
nnoremap <expr> <cr> &ft == 'qf' ? '<cr>' : 'o<esc>'
nnoremap <space>g :silent grep!<space>
nnoremap guw guiw
nnoremap guW guiW
nnoremap gUw gUiw
nnoremap gUW gUiW
nnoremap Q q
xnoremap <silent> . :normal! .<cr>
xnoremap q :'<,'>:normal! @q<cr>

" MOTIONS
inoremap <c-l> <right>
nnoremap <c-i> <c-i>zz
nnoremap <c-o> <c-o>zz
nnoremap n nzz
nnoremap N Nzz
nnoremap A g$a
nnoremap I g0i
noremap gH g0
noremap gh g^
noremap gl g$
noremap j gj
noremap k gk
noremap H H0
noremap L L0
noremap M M0
noremap { {zz
noremap } }zz

" MOUSE
nmap <2-rightmouse> <rightmouse>
nmap <3-rightmouse> <rightmouse>
nmap <4-rightmouse> <rightmouse>
set mousemodel=extend
set mousescroll=ver:4

" QUICKFIX
autocmd filetype qf setl nonu scl=no
nmap <space>q <plug>(qf_qf_toggle_stay)
nmap [q <plug>(qf_qf_previous)zz
nmap ]q <plug>(qf_qf_next)zz
lua << EOF
require('bqf').setup({
  preview = {
    border_chars = { '│', '│', '─', '─', '┌', '┐', '└', '┘', '█' },
    show_title = false,
  },
  func_map = { split = '<c-s>', },
  filter = { fzf = { action_for = { ['ctrl-s'] = 'split' } } },
})
EOF
highlight bqfsign ctermfg=yellow
highlight! link bqfpreviewborder comment
highlight! link bqfpreviewrange none

" SANDWICH (https://github.com/machakann/vim-sandwich/issues/92)
let g:sandwich_no_default_key_mappings = 1
nmap s   <Plug>(operator-sandwich-add)
xmap s   <Plug>(operator-sandwich-add)
nmap sd  <Plug>(operator-sandwich-delete)a
nmap sr  <Plug>(operator-sandwich-replace)a
nmap sw siw
nmap sW siW

" SCROLLING
nnoremap <a-d> 4<c-y>
nnoremap <a-f> 4<c-e>

" SEARCH
cnoremap <expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter><cmd>noh<cr>zz' : '<enter>'
nnoremap <esc> <cmd>noh<cr><esc>
nnoremap <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
xnoremap <space>w <cmd>let @/=visual#GetSelection()<bar>set hls<cr><esc>

lua << EOF
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

-- SEARCH
map('n', '<space>w', function()
  vim.fn.setreg('/', '\\<' .. vim.fn.expand('<cword>') .. '\\>')
  vim.opt.hlsearch = true
end)
map('n', '<c', '<cmd>set ignorecase!<cr>')
map('n', '<h', '<cmd>set hlsearch!<cr>')
vim.opt.ignorecase = true
vim.opt.shortmess:append('sS')
vim.opt.smartcase = true

-- SETTINGS
vim.opt.clipboard = 'unnamedplus'
vim.opt.foldenable = false
vim.opt.path:append('**')
vim.opt.spellcapcheck = ''
vim.opt.spellfile = '$XDG_STATE_HOME/nvim/spell/en.utf-8.add'
vim.opt.timeout = false
vim.opt.virtualedit = 'block'

-- SNIPPETS
require('snippy').setup({
  mappings = {
    s = {
      ['<a-j>'] = 'next',
      ['<a-k>'] = 'previous',
    },
    x = { ['<tab>'] = 'cut_text' },
  },
})

-- STATUSLINE/RULER
map('n', '<s', function()
  if vim.o.ls ~= 0 then
    vim.opt.laststatus = 0
    vim.opt.statusline = '%='
  else
    vim.opt.laststatus = 3
    vim.opt.statusline = '[%f]%=[%l/%L]'
  end
end, { desc = 'Toggle statusline.' })
vim.o.fillchars = 'diff: ,eob: ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│'
vim.opt.laststatus = 0
vim.opt.statusline = '%='

-- SUBSTITUTE
local substitute = require('substitute')
substitute.setup({ exchange = { preserve_cursor_position = true } })
map('n', 'x',  function() substitute.operator() end)
map('n', 'xw', function() substitute.operator({ motion='iw' }) end)
map('n', 'xW', function() substitute.operator({ motion='iW' }) end)
map('n', 'xp', function() substitute.operator({ motion='ab' }) end)
map('n', 'xb', function() substitute.operator({ motion='ib' }) end)
map('n', 'xq', function() substitute.operator({ motion='iq' }) end)
map('x', 'x',  function() substitute.visual() end)
map('n', 'X',  function() substitute.eol() end)
local exchange = require('substitute.exchange')
map('n', 'xx',  function() exchange.operator() end)
map('n', 'xxw', function() exchange.operator({ motion='iw' }) end)
map('n', 'xxW', function() exchange.operator({ motion='iW' }) end)
map('n', 'xxp', function() exchange.operator({ motion='ap' }) end)
map('n', 'xxb', function() exchange.operator({ motion='ib' }) end)
map('n', 'xxq', function() exchange.operator({ motion='iq' }) end)
map('x', 'X',   function() exchange.visual() end)

-- TABLINE
vim.opt.showtabline = 1
vim.opt.tabline = '%!tabline#Show()'
map('n', '<a-e>', 'gT')
map('n', '<a-r>', 'gt')
map('n', '<space>n', '<cmd>tab split<cr>')

-- TEXTOBJECTS
require('mini.ai').setup({ silent = true })
require('various-textobjs').setup({ notifyNotFound = false })
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
  local foundURL = vim.fn.mode():find('v')
  if not foundURL then return end
  vim.cmd.normal { '"zy', bang = true }
  local url = vim.fn.getreg('z')
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
map('n', '<c-r', '<cmd>call center#ExeCmdAndCenter("redo")<cr>')
map('n', 'U', '<cmd>call center#ExeCmdAndCenter("redo")<cr>')
map('n', 'u', '<cmd>call center#ExeCmdAndCenter("undo")<cr>')

-- WINDOWS: MANAGEMENT
autocmd('VimResized', { callback = function() vim.cmd.wincmd('=') end })
map('n', '<space>c', '<c-w>c')
map('n', '<space>s', '<c-w>s')
map('n', '<space>v', '<c-w>v')
map('n', '<space>z', '<c-w>z')
vim.opt.splitbelow = true
vim.opt.splitright = true

-- WINDOWS: NAVIGATION
local tmux = require('tmux')
tmux.setup({
  copy_sync = { enable = false },
  navigation = { enable_default_keybindings = false },
  resize = { enable_default_keybindings = false },
})
map('n', '<a-h>', function() tmux.move_left() end)
map('n', '<a-j>', function() tmux.move_bottom() end)
map('n', '<a-k>', function() tmux.move_top() end)
map('n', '<a-l>', function() tmux.move_right() end)

-- WRAP
autocmd('FileType', { command = 'set formatoptions-=t' })
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.showbreak = '  ↳ '
if vim.env.TERM == 'linux' or vim.env.TERM == 'screen' then
  vim.opt.showbreak = '  ¬ '
else
  vim.opt.showbreak = '  ↳ '
end

-- YANK
autocmd({ 'VimEnter', 'CursorMoved' }, {
  callback = function()
    yank_pos = vim.api.nvim_win_get_cursor(0)
  end
})
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
    if vim.v.event.operator == 'y' then
      vim.api.nvim_win_set_cursor(0, yank_pos)
    end
    print(' ')
  end
})
map('n', 'yp', 'yap')
map('n', 'yw', 'yiw')
map('n', 'yW', 'yiW')
EOF
