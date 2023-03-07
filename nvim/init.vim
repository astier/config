" FIRST THINGS FIRST
augroup group | autocmd! | augroup end
scriptencoding utf-8

" PLUGINS
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
  execute '!curl -fLo' plug_path '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd group vimenter * PlugInstall --sync | source $MYVIMRC
endif
nnoremap <space>pc <cmd>PlugClean<cr>
nnoremap <space>pp <cmd>PlugUpgrade<bar>PlugUpdate<cr>
call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'gbprod/substitute.nvim'
  Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
  Plug 'idbrii/textobj-word-column.vim'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'kana/vim-textobj-indent'
  Plug 'kana/vim-textobj-user'
  Plug 'machakann/vim-sandwich'
  Plug 'nathom/tmux.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'numToStr/Comment.nvim'
  Plug 'rbong/vim-flog'
  Plug 'romainl/vim-qf'
  Plug 'stsewd/gx-extended.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'wellle/targets.vim'
call plug#end()

" APPEARANCE
autocmd group filetype * set nocursorline
autocmd group textyankpost * lua vim.highlight.on_yank()
colorscheme custom
nnoremap <space>H <cmd>execute 'highlight' synIDattr(synID(line('.'), col('.'), 1), "name")<cr>

" BUFFERS
autocmd group textchanged,insertleave * nested if !&ro | silent! update | endif
nnoremap <space>d <cmd>qa!<cr>
nnoremap q <cmd>silent! b#<cr>
set noswapfile

" CHANGE
nmap cp cip
nmap cw ciw
nmap cW ciW
nnoremap c "_c
nnoremap C "_C
xnoremap c "_c

" COMMENTS
autocmd group filetype * set formatoptions-=cro
lua require('Comment').setup()
nmap gcj gco
nmap gck gcO
nmap gcl gcA
nmap gcp gcip
onoremap u <cmd>lua require('uncomment').uncomment()<cr>

" COMPLETION
autocmd group BufRead * call completion#SetMethod()
inoremap <expr> <tab> pumvisible() ? '<down>' : completion#CanComplete() ? completion#Complete() : '<tab>'
inoremap <expr> <s-tab> pumvisible() ? '<up>' : '<s-tab>'
inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'
lua require('completionitemkind')
set completeopt=menuone,noinsert
set pumheight=8 pumwidth=0
set shortmess+=c

" DELETE
nnoremap <expr> dp &diff ? 'dp' : '<cmd>silent normal! dap<cr>'
nnoremap dw daw
nnoremap dW daW
xnoremap d <cmd>silent normal! d<cr>

" FORMATTING
nnoremap gqp gqip
nnoremap gqq Vgq

" FUZZY - CONFIG
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

" FUZZY - MAPPINGS (MISC)
nnoremap fb <cmd>FzfLua buffers<cr>
nnoremap fB <cmd>FzfLua builtin<cr>
nnoremap fc <cmd>FzfLua commands<cr>
nnoremap ff <cmd>FzfLua files<cr>
nnoremap fh <cmd>FzfLua help_tags<cr>
nnoremap fl <cmd>FzfLua blines<cr>
nnoremap fo <cmd>FzfLua oldfiles<cr>
nnoremap fQ <cmd>FzfLua loclist<cr>
nnoremap fq <cmd>FzfLua quickfix<cr>
nnoremap fR <cmd>FzfLua registers<cr>

" FUZZY - MAPPINGS (GREP)
nnoremap fg <cmd>FzfLua grep<cr>
nnoremap fG <cmd>FzfLua live_grep<cr>
nnoremap fw <cmd>FzfLua grep_cword<cr>
nnoremap fW <cmd>FzfLua grep_cWORD<cr>
xnoremap fw <cmd>FzfLua grep_visual<cr>

" FUZZY - MAPPINGS (LSP)
nnoremap fd <cmd>FzfLua lsp_definitions<cr>
nnoremap fi <cmd>FzfLua lsp_implementations<cr>
nnoremap fr <cmd>FzfLua lsp_references<cr>
nnoremap fs <cmd>FzfLua lsp_document_symbols<cr>
nnoremap fS <cmd>FzfLua lsp_workspace_symbols<cr>

" GIT
autocmd group filetype floggraph nmap <buffer> <rightmouse> <leftmouse><cr>
autocmd group filetype floggraph nmap <buffer> <space>q <plug>(FlogQuit)
autocmd group filetype floggraph xmap <buffer> <rightmouse> <cr>
let g:flog_permanent_default_opts = { 'date': 'short' }
nnoremap <expr> <space>km &diff ? '<cmd>x<cr>zz' : '<cmd>Gdiffsplit<cr>'
nnoremap <space>kd <cmd>0G diff<cr>
nnoremap <space>kg :Flog -search=
nnoremap <space>kK <cmd>Flog -all -path=%<cr>
nnoremap <space>kk <cmd>Flog -all<cr>
nnoremap <space>kr <cmd>G reset --hard<bar>e<cr>

" GITGUTTER
let g:gitgutter_map_keys = 0
let g:gitgutter_floating_window_options = {
\ 'border': 'single',
\ 'relative': 'cursor',
\ 'row': 1,
\ 'col': 0,
\ 'width': 42,
\ 'height': &previewheight,
\ 'style': 'minimal',
\}
nnoremap <space>i <cmd>silent GitGutterPreviewHunk<cr>
nnoremap <space>S <cmd>silent GitGutterStageHunk<cr>
nnoremap <space>u <cmd>silent GitGutterUndoHunk<cr>
nnoremap [c <cmd>silent GitGutterPrevHunk<cr>zz
nnoremap ]c <cmd>silent GitGutterNextHunk<cr>zz
set signcolumn=yes

" GREP
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m
command! -nargs=+ -complete=file_in_path Grep silent grep! <args><bar>echo
nnoremap <space>g :Grep<space>

" INDENTATION
autocmd group bufread * call indent#Detect()
filetype indent off
nnoremap <p <ap
nnoremap >p >ap
set expandtab
set shiftwidth=2
set tabstop=2

" LOADED
let g:loaded_2html_plugin = 0
let g:loaded_gzip = 0
let g:loaded_matchit = 0
let g:loaded_matchparen = 0
let g:loaded_netrwPlugin = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_remote_plugins = 0
let g:loaded_ruby_provider = 0
let g:loaded_spellfile_plugin = 0
let g:loaded_tarPlugin = 0
let g:loaded_tutor_mode_plugin = 0
let g:loaded_vimball = 0
let g:loaded_vimballPlugin = 0
let g:loaded_zipPlugin = 0

" LSP
lua << EOF
vim.diagnostic.disable()
vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
local border = 'single'
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K',  vim.lsp.buf.hover, bufopts)
end
local lspconfig = require('lspconfig')
lspconfig.ccls.setup({
  on_attach = on_attach,
  init_options = {
    diagnostics = { onOpen = -1, onChange = -1, onSave = -1 },
  },
})
local servers = { 'jedi_language_server', 'marksman' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
  })
end
EOF

" MAKE
set makeprg=lint
set errorformat=%f:%l:%c:%m
set errorformat+=%f:%l:%c\ %m
set errorformat+=%f:%l:%m
set errorformat+=%f:%l\ %m
nnoremap <space>l <cmd>silent make! %<cr>

" MAPPINGS
inoremap <c-space> <space>
nnoremap <expr> <cr> &ft == 'qf' ? '<cr>' : 'o<esc>'
nnoremap guw myguiw`y
nnoremap guW myguiW`y
nnoremap gUw mygUiw`y
nnoremap gUW mygUiW`y
nnoremap J myJ`y
nnoremap Q q
nnoremap t <cmd>call toggle#Next()<cr>
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
noremap $ g$
noremap F g$
noremap 0 g0
noremap ^ g^
noremap gg gg0
noremap G G0
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
inoremap <c-v> <c-r>+
nnoremap cP <cmd>silent normal! yap}p<cr>
nnoremap p <cmd>silent! normal! p<cr>
nnoremap P <cmd>silent! normal! P<cr>

" QUICKFIX
autocmd group filetype qf nnoremap <buffer> o <cr><plug>(qf_qf_toggle_stay)
autocmd group filetype qf setl nonu scl=no wrap
nmap <space>q <plug>(qf_qf_toggle_stay)
nmap [q <plug>(qf_qf_previous)zz
nmap ]q <plug>(qf_qf_next)zz

" SANDWICH
" Combine with targets.vim (https://github.com/machakann/vim-sandwich/issues/92)
let g:sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1
nmap sd <plug>(operator-sandwich-delete)a
nmap sr <plug>(operator-sandwich-replace)a
nmap sdf <plug>(sandwich-delete)f
nmap srf <plug>(sandwich-replace)f
nmap sa <plug>(operator-sandwich-add)
xmap sa <plug>(operator-sandwich-add)
nmap sab saib
nmap saB saab
nmap saw saiw
nmap saW saiW

" SCROLLING
nnoremap <a-d> 4<c-y>
nnoremap <a-f> 4<c-e>

" SEARCH
cnoremap <expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter><cmd>echo<bar>noh<cr>zz' : '<enter>'
nnoremap <esc> <cmd>echo<bar>noh<cr><esc>
nnoremap <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nnoremap ,w <cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hls<cr>
xnoremap ,w <cmd>let @/=visual#GetSelection()<bar>set hls<cr><esc>
nnoremap ,c <cmd>set ignorecase!<cr>
nnoremap ,h <cmd>set hlsearch!<cr>
set ignorecase smartcase
set shortmess+=Ss

" SETTINGS
set clipboard=unnamedplus
set nofoldenable
set notimeout
set path=.,,**
set virtualedit=block
set wildmode=longest:list,full

" SNIPPETS
inoremap <c-j> <esc><cmd>call search('<++>')<cr>ca<
inoremap <c-k> <esc><cmd>call search('<++>', 'b')<cr>ca<
nnoremap <c-j> <cmd>call search('<++>')<cr>ca<
nnoremap <c-k> <cmd>call search('<++>', 'b')<cr>ca<

" SNIPPETS - (
inoremap (<tab>  ()<left>
inoremap (,      (),<left><left>
inoremap (;      ();<left><left>
inoremap ((<tab> (<cr>)<c-o>O<tab>
inoremap ((,     (<cr>),<c-c>O<tab>
inoremap ((;     (<cr>);<c-c>O<tab>

" SNIPPETS - [
inoremap [<tab>  []<left>
inoremap [,      [],<left><left>
inoremap [s<tab> [  ]<left><left>
inoremap [s,     [  ],<left><left><left>
inoremap [[<tab> [<cr>]<c-o>O<tab>
inoremap [[,     [<cr>],<c-c>O<tab>

" SNIPPETS - {
inoremap {<tab>  {}<left>
inoremap {,     {},<left><left>
inoremap {s<tab> {  }<left><left>
inoremap {s,    {  },<left><left><left>
inoremap {{<tab> {<cr>}<c-o>O<tab>
inoremap {{,    {<cr>},<c-c>O<tab>

" SNIPPETS - QUOTES
inoremap "<tab>  ""<left>
inoremap ",<tab> "",<left><left>
inoremap '<tab>  ''<left>
inoremap ',<tab> '',<left><left>
inoremap <<tab>  <><left>
inoremap `<tab>  ``<left>

" SORT
nmap <silent> gs myvii:sort i<cr>`y
xnoremap <silent> gs my:sort i<cr>`y

" SPELL
set spellcapcheck=
set spellfile=$XDG_STATE_HOME/nvim/spell/en.utf-8.add

" STATUS (CMDLINE/RULER/STATUSLINE)
nnoremap <expr> ,s &ls ? '<cmd>se stl=%= ls=0<cr>' : '<cmd>se ls=3 stl=\[%f\]%=\[%l/%L\]<cr>'
set fillchars+=diff:\ ,eob:\ ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│
set noshowcmd noshowmode
set rulerformat=%=\[%l/%L\] noruler
set statusline=%= laststatus=0

" SUBSTITUTE
lua require('substitute').setup()
nnoremap s <cmd>lua require('substitute').operator()<cr>
nnoremap sA <cmd>lua require('substitute').operator({ motion='a' })<cr>
nnoremap sp <cmd>lua require('substitute').operator({ motion='ip' })<cr>
nnoremap sb <cmd>lua require('substitute').operator({ motion='Ib' })<cr>
nnoremap sB <cmd>lua require('substitute').operator({ motion='ab' })<cr>
nnoremap sw <cmd>lua require('substitute').operator({ motion='iw' })<cr>
nnoremap sW <cmd>lua require('substitute').operator({ motion='iW' })<cr>
nnoremap S <cmd>lua require('substitute').eol()<cr>
nnoremap ss <cmd>lua require('substitute').line()<cr>
xnoremap ss <cmd>lua require('substitute').visual()<cr>
nnoremap sx <cmd>lua require('substitute.exchange').operator()<cr>
nnoremap sxb <cmd>lua require('substitute.exchange').operator({ motion='Ib' })<cr>
nnoremap sxB <cmd>lua require('substitute.exchange').operator({ motion='ab' })<cr>
nnoremap sxw <cmd>lua require('substitute.exchange').operator({ motion='iw' })<cr>
nnoremap sxW <cmd>lua require('substitute.exchange').operator({ motion='iW' })<cr>
nnoremap sxx <cmd>lua require('substitute.exchange').line()<cr>
xnoremap sx <cmd>lua require('substitute.exchange').visual()<cr>

" TABLINE
set showtabline=1
set tabline=%!tabline#Show()

" TABS
nnoremap <a-e> <cmd>tabp<cr>
nnoremap <a-r> <cmd>tabn<cr>
nnoremap <space>n <cmd>tab split<cr>
tnoremap <silent> <a-e> <c-\><c-n><cmd>tabp<cr>
tnoremap <silent> <a-r> <c-\><c-n><cmd>tabn<cr>

" TARGETS
autocmd group user targets#mappings#user call targets#mappings#extend({
\ 'b': {
\   'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}],
\   'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]
\ },
\})
nmap cb cIb
nmap db dIb
" Call as cmd to fix flog-error
nmap yb <cmd>silent! normal myyIb`y<cr>

" TEXTOBJ
nmap cv civ
nmap dc my^dic`y
nmap dv dav

" UNDO
nnoremap <c-r> <cmd>call center#ExeCmdAndCenter('redo')<cr>
nnoremap U <cmd>call center#ExeCmdAndCenter('redo')<cr>
nnoremap u <cmd>call center#ExeCmdAndCenter('undo')<cr>

" WINDOWS
autocmd group vimresized * wincmd =
nnoremap <a-h> <cmd>lua require('tmux').move_left()<cr>
nnoremap <a-j> <cmd>lua require('tmux').move_down()<cr>
nnoremap <a-k> <cmd>lua require('tmux').move_up()<cr>
nnoremap <a-l> <cmd>lua require('tmux').move_right()<cr>
tnoremap <a-h> <c-\><c-n><cmd>lua require('tmux').move_left()<cr>
tnoremap <a-j> <c-\><c-n><cmd>lua require('tmux').move_down()<cr>
tnoremap <a-k> <c-\><c-n><cmd>lua require('tmux').move_up()<cr>
tnoremap <a-l> <c-\><c-n><cmd>lua require('tmux').move_right()<cr>
nnoremap <space>c <c-w>c
nnoremap <space>s <c-w>s
nnoremap <space>v <c-w>v
nnoremap <space>z <c-w>z
set splitbelow splitright

" WRAP
autocmd group filetype * set formatoptions-=t
set breakindent
set breakindentopt=shift:2
set linebreak
if $TERM ==# 'linux' || $TERM ==# 'screen'
  set showbreak=¬\ 
else
  set showbreak=↳\ 
endif

" YANK
nnoremap <silent> y :<c-u>call yank#AndJumpBack()<cr>g@
nnoremap yp <cmd>silent normal! myyap`y<cr>
nnoremap yw myyiw`y
nnoremap yW myyiW`y
nnoremap yy myyy`y
xnoremap y <cmd>silent normal! myy`y<cr>
