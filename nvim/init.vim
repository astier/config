" FIRST THINGS FIRST
augroup vimrc | autocmd! | augroup end
scriptencoding utf-8

" PLUGINS
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
  execute '!curl -fLo' plug_path '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd vimrc vimenter * PlugInstall --sync | source $MYVIMRC
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
  Plug 'numToStr/Comment.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'rbong/vim-flog'
  Plug 'romainl/vim-qf'
  Plug 'ThePrimeagen/harpoon'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
call plug#end()

" APPEARANCE
autocmd vimrc filetype * setl nocursorline
colorscheme custom
nnoremap <space>H <cmd>execute 'highlight' synIDattr(synID(line('.'), col('.'), 1), "name")<cr>

" AUTOCHDIR
lua << EOF
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local root = vim.fs.root(0, '.git')
    if root then vim.uv.chdir(root) end
  end,
})
EOF

" BUFFERS
autocmd vimrc textchanged,insertleave * nested if !&ro | silent! update | endif
nnoremap <space>d <cmd>qa!<cr>
nnoremap q <cmd>silent! b#<cr>
set noswapfile

" CHANGE
nnoremap c "_c
nnoremap C "_C
xnoremap c "_c
nmap cp cip
nmap cw ciw
nmap cW ciW

" CMDLINE
autocmd vimrc cmdlineleave * echo ''
set path=.,,**

" COMMENTS
autocmd vimrc filetype * set formatoptions-=cro
lua require('Comment').setup()
nmap gcj gco
nmap gck gcO
nmap gcl gcA
nmap gcp gcip
onoremap u <cmd>lua require('uncomment').uncomment()<cr>

" COMPLETION
highlight! link CmpSelection lspsignatureactiveparameter
set completeopt=menuone,noinsert
set pumheight=8 pumwidth=0
set shortmess+=c
lua << EOF
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
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal,CursorLine:CmpSelection',
    },
    documentation = {
      border = 'single',
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal,CursorLine:CmpSelection',
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
EOF

" DELETE
nnoremap <expr> dp &diff ? 'dp' : '<cmd>silent normal! dap<cr>'
nnoremap dw daw
nnoremap dW daW
xnoremap d <cmd>silent normal! d<cr>

" FORMATTING
nnoremap gqp gqip
nnoremap gqq Vgq

" FUZZY: CONFIG
lua << EOF
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
EOF

" FUZZY: MAPPINGS (MISC)
nnoremap fb <cmd>FzfLua builtin<cr>
nnoremap fc <cmd>FzfLua commands<cr>
nnoremap ff <cmd>FzfLua files<cr>
nnoremap fh <cmd>FzfLua help_tags<cr>
nnoremap fj <cmd>FzfLua buffers<cr>
nnoremap fl <cmd>FzfLua blines<cr>
nnoremap fo <cmd>FzfLua oldfiles<cr>
nnoremap fQ <cmd>FzfLua loclist<cr>
nnoremap fq <cmd>FzfLua quickfix<cr>
nnoremap fR <cmd>FzfLua registers<cr>

" FUZZY: MAPPINGS (GREP)
nnoremap fg <cmd>FzfLua grep<cr>
nnoremap fG <cmd>FzfLua live_grep<cr>
nnoremap fw <cmd>FzfLua grep_cword<cr>
nnoremap fW <cmd>FzfLua grep_cWORD<cr>
xnoremap fw <cmd>FzfLua grep_visual<cr>

" FUZZY: MAPPINGS (LSP)
nnoremap fd <cmd>FzfLua lsp_definitions<cr>
nnoremap fi <cmd>FzfLua lsp_implementations<cr>
nnoremap fr <cmd>FzfLua lsp_references<cr>
nnoremap fs <cmd>FzfLua lsp_document_symbols<cr>
nnoremap fS <cmd>FzfLua lsp_workspace_symbols<cr>

" GIT
autocmd vimrc filetype floggraph nmap <buffer> <rightmouse> <leftmouse><cr>
autocmd vimrc filetype floggraph nmap <buffer> <space>q <plug>(FlogQuit)
autocmd vimrc filetype floggraph xmap <buffer> <rightmouse> <cr>
let g:flog_permanent_default_opts = { 'date': 'short' }
nnoremap <expr> <space>km &diff ? '<cmd>x<cr>zz' : '<cmd>Gdiffsplit<cr>'
nnoremap <space>kd <cmd>0G diff<cr>
nnoremap <space>kg :Flog -search=
nnoremap <space>kK <cmd>Flog -all -path=%<cr>
nnoremap <space>kk <cmd>Flog -all<cr>
nnoremap <space>kr <cmd>G reset --hard<bar>e<cr>
nnoremap <space>ks <cmd>G status -bs<cr>

" GITGUTTER
let g:gitgutter_map_keys = 0
nnoremap <space>i <cmd>silent GitGutterPreviewHunk<cr>
nnoremap <space>S <cmd>silent GitGutterStageHunk<cr>
nnoremap <space>u <cmd>silent GitGutterUndoHunk<cr>
nnoremap [c <cmd>silent GitGutterPrevHunk<cr>zz
nnoremap ]c <cmd>silent GitGutterNextHunk<cr>zz
set signcolumn=yes

" GREP
set grepprg=ggrep\ --vimgrep
set grepformat=%f:%l:%c:%m
command! -nargs=+ -complete=file_in_path Grep silent grep! <args><bar>echo
nnoremap <space>g :Grep<space>

" HARPOON
hi! link HarpoonBorder separator
nnoremap <space>ha <cmd>lua require("harpoon.mark").add_file()<cr>
nnoremap <space>m <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <space>1 <cmd>lua require("harpoon.ui").nav_file(1)<cr>
nnoremap <space>2 <cmd>lua require("harpoon.ui").nav_file(2)<cr>
nnoremap <space>3 <cmd>lua require("harpoon.ui").nav_file(3)<cr>
nnoremap <space>4 <cmd>lua require("harpoon.ui").nav_file(4)<cr>
nnoremap <c-n> <cmd>lua require("harpoon.ui").nav_next()<cr>
nnoremap <c-p> <cmd>lua require("harpoon.ui").nav_prev()<cr>

" INDENTATION
nnoremap <p <ap
nnoremap >p >ap
set expandtab
set shiftwidth=2
set tabstop=2

" LOADED
" Two function-calls are needed to open lsp-float-windows in insert-mode if disabled
" let g:loaded_matchparen = 0
let g:loaded_2html_plugin = 0
let g:loaded_gzip = 0
let g:loaded_matchit = 0
let g:loaded_netrwPlugin = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_remote_plugins = 0
let g:loaded_ruby_provider = 0
let g:loaded_spellfile_plugin = 0
let g:loaded_tarPlugin = 0
let g:loaded_tutor_mode_plugin = 0
let g:loaded_zipPlugin = 0

" LSP
lua << EOF
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
    vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('v', '<c-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
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
nnoremap guw myguiw`y
nnoremap guW myguiW`y
nnoremap gUw mygUiw`y
nnoremap gUW mygUiW`y
nnoremap J myJ`y
nnoremap Q q
xnoremap <silent> . :normal! .<cr>
xnoremap q :'<,'>:normal! @q<cr>

" MOTIONS
inoremap <c-l> <right>
nnoremap <c-i> <c-i>zz
nnoremap <c-o> <c-o>zz
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
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

" PASTE
nnoremap cP <cmd>silent normal! yap}p<cr>
nnoremap p <cmd>silent! normal! p<cr>
nnoremap P <cmd>silent! normal! P<cr>

" QUICKFIX
autocmd vimrc filetype qf setl nonu scl=no
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
cnoremap <expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter><cmd>echo<bar>noh<cr>zz' : '<enter>'
nnoremap <esc> <cmd>echo<bar>noh<cr><esc>
nnoremap <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nnoremap <space>w <cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hls<cr>
nnoremap <space>W <cmd>let @/='\<'.expand('<cWORD>').'\>'<bar>set hls<cr>
xnoremap <space>w <cmd>let @/=visual#GetSelection()<bar>set hls<cr><esc>
nnoremap <c <cmd>set ignorecase!<cr>
nnoremap <h <cmd>set hlsearch!<cr>
set ignorecase smartcase
set shortmess+=Ss

" SETTINGS
set clipboard=unnamedplus
set nofoldenable
set notimeout
set virtualedit=block

" SNIPPETS
lua << EOF
require('snippy').setup({
  mappings = {
    s = {
      ['<a-j>'] = 'next',
      ['<a-k>'] = 'previous',
    },
    x = { ['<tab>'] = 'cut_text' },
  },
})
EOF

" SPELL
set spellcapcheck=
set spellfile=$XDG_STATE_HOME/nvim/spell/en.utf-8.add

" STATUS (RULER/STATUSLINE)
nnoremap <expr> <s &ls ? '<cmd>se stl=%= ls=0<cr>' : '<cmd>se ls=3 stl=\[%f\]%=\[%l/%L\]<cr>'
set fillchars+=diff:\ ,eob:\ ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│
set noshowcmd noshowmode
set rulerformat=%=\[%l/%L\] noruler
set statusline=%= laststatus=0

" SUBSTITUTE
lua << EOF
local substitute = require('substitute')
substitute.setup({ exchange = { preserve_cursor_position = true } })
local map = vim.keymap.set
map('n', 'x',  function() substitute.operator() end)
map('n', 'xw', function() substitute.operator({ motion='iw' }) end)
map('n', 'xW', function() substitute.operator({ motion='iW' }) end)
map('n', 'xp', function() substitute.operator({ motion='ab' }) end)
map('n', 'xj', function() substitute.operator({ motion='ij' }) end)
map('n', 'xb', function() substitute.operator({ motion='ib' }) end)
map('n', 'xq', function() substitute.operator({ motion='iq' }) end)
map('x', 'x',  function() substitute.visual() end)
map('n', 'X',  function() substitute.eol() end)
local exchange = require('substitute.exchange')
map('n', 'xx',  function() exchange.operator() end)
map('n', 'xxw', function() exchange.operator({ motion='iw' }) end)
map('n', 'xxW', function() exchange.operator({ motion='iW' }) end)
map('n', 'xxp', function() exchange.operator({ motion='ap' }) end)
map('n', 'xxj', function() exchange.operator({ motion='ij' }) end)
map('n', 'xxb', function() exchange.operator({ motion='ib' }) end)
map('n', 'xxq', function() exchange.operator({ motion='iq' }) end)
map('x', 'X',   function() exchange.visual() end)
EOF

" TABLINE
set showtabline=1
set tabline=%!tabline#Show()
nnoremap <a-e> <cmd>tabp<cr>
nnoremap <a-r> <cmd>tabn<cr>
nnoremap <space>n <cmd>tab split<cr>
tnoremap <silent> <a-e> <c-\><c-n><cmd>tabp<cr>
tnoremap <silent> <a-r> <c-\><c-n><cmd>tabn<cr>

" TEXTOBJECTS
lua << EOF
local map = vim.keymap.set
require('mini.ai').setup({
  custom_textobjects = {
    j = {
      {'%b()', '%b[]', '%b{}', '%b""', '%b\'\'', '%b``'},
      '^.().*().$'
    },
  },
  silent = true,
})
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
-- Brackets + Quotes
map('n', 'cj', 'cij', { remap = true })
map('n', 'dj', 'dij', { remap = true })
map('n', 'yj', 'yij', { remap = true })
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
EOF

" TMUX
command! -complete=shellcmd -nargs=* T call system('iwltm --send '.shellescape(expandcmd(<q-args>)))
nnoremap <space><space> <cmd>call T(getline('.'))<cr>
xnoremap <space><space> "vy <cmd>call T(substitute(@v, '\n$', '', ''))<cr>
nnoremap <space>a <cmd>T execute<cr>

" TRANSFORM
lua << EOF
require('mini.splitjoin').setup({ mappings = { toggle = '<space>t' } })
vim.keymap.set('n', 't', '<cmd>call toggle#Next()<cr>')
vim.keymap.set({ 'n', 'x' }, 'gs', 'my<cmd>lua require("sort").sort()<cr>`y')
EOF

" UNDO
nnoremap <c-r> <cmd>call center#ExeCmdAndCenter('redo')<cr>
nnoremap U <cmd>call center#ExeCmdAndCenter('redo')<cr>
nnoremap u <cmd>call center#ExeCmdAndCenter('undo')<cr>

" WINDOWS
nnoremap <space>c <c-w>c
nnoremap <space>s <c-w>s
nnoremap <space>v <c-w>v
nnoremap <space>z <c-w>z
set splitbelow splitright

" WINDOWS: NAVIGATION
lua << EOF
return require("tmux").setup({
  copy_sync = { enable = false },
  navigation = {
    cycle_navigation = false,
    enable_default_keybindings = false,
  },
  resize = {
    enable_default_keybindings = false,
    resize_step_x = 2,
    resize_step_y = 2,
  },
})
EOF
nnoremap <a-h> <cmd>lua require('tmux').move_left()<cr>
nnoremap <a-j> <cmd>lua require('tmux').move_bottom()<cr>
nnoremap <a-k> <cmd>lua require('tmux').move_top()<cr>
nnoremap <a-l> <cmd>lua require('tmux').move_right()<cr>
tnoremap <a-h> <c-\><c-n><cmd>lua require('tmux').move_left()<cr>
tnoremap <a-j> <c-\><c-n><cmd>lua require('tmux').move_bottom()<cr>
tnoremap <a-k> <c-\><c-n><cmd>lua require('tmux').move_top()<cr>
tnoremap <a-l> <c-\><c-n><cmd>lua require('tmux').move_right()<cr>

" WINDOWS: RESIZE
autocmd vimrc vimresized * wincmd =
nnoremap <a-H> <cmd>lua require('tmux').resize_left()<cr>
nnoremap <a-J> <cmd>lua require('tmux').resize_bottom()<cr>
nnoremap <a-K> <cmd>lua require('tmux').resize_top()<cr>
nnoremap <a-L> <cmd>lua require('tmux').resize_right()<cr>
tnoremap <a-H> <c-\><c-n><cmd>lua require('tmux').resize_left()<cr>
tnoremap <a-J> <c-\><c-n><cmd>lua require('tmux').resize_bottom()<cr>
tnoremap <a-K> <c-\><c-n><cmd>lua require('tmux').resize_top()<cr>
tnoremap <a-L> <c-\><c-n><cmd>lua require('tmux').resize_right()<cr>

" WRAP
autocmd vimrc filetype * set formatoptions-=t wrap
set breakindent
set breakindentopt=shift:2
set linebreak
if $TERM ==# 'linux' || $TERM ==# 'screen'
  set showbreak=¬\ 
else
  set showbreak=↳\ 
endif

" YANK
augroup RestoreYankPos
  autocmd!
  autocmd VimEnter,CursorMoved * let s:yank_pos = getcurpos('.')
  autocmd TextYankPost *
    \ if v:event.operator ==? 'y' |
      \ call setpos('.', s:yank_pos) |
    \ endif
augroup end
autocmd vimrc textyankpost * lua vim.highlight.on_yank()
nnoremap yp yap
nnoremap yw yiw
nnoremap yW yiW
