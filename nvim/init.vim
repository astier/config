" FIRST THINGS FIRST
aug group | au! | aug end
scriptencoding utf-8

" PLUGINS
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
  sil !curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
en
nn <space>pc <cmd>PlugClean<cr>
nn <space>pp <cmd>PlugUpgrade<bar>PlugUpdate<cr>
cal plug#begin($XDG_DATA_HOME.'/nvim/plugins')
  Plug 'airblade/vim-gitgutter'
  Plug 'AndrewRadev/switch.vim'
  Plug 'cohama/lexima.vim'
  Plug 'Darazaki/indent-o-matic'
  Plug 'ethanholz/nvim-lastplace'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'ibhagwan/fzf-lua'
  Plug 'junegunn/fzf'
  Plug 'kevinhwang91/nvim-bqf'
  Plug 'machakann/vim-sandwich'
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  Plug 'mhinz/vim-grepper'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'nathom/tmux.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'rbong/vim-flog'
  Plug 'scrooloose/nerdtree'
  Plug 'stevearc/stickybuf.nvim'
  Plug 'stsewd/gx-extended.vim'
  Plug 'svermeulen/vim-subversive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'vijaymarupudi/nvim-fzf'
  Plug 'wellle/targets.vim'
cal plug#end()

" APPEARANCE
au group filetype * se nocursorline
au group textyankpost * sil! lua vim.highlight.on_yank{}
colorscheme colors
nn <space>H <cmd>exe 'hi' synIDattr(synID(line('.'), col('.'), 1), "name")<cr>

" AUTO-PAIR
let g:lexima_ctrlh_as_backspace = 1
let g:lexima_enable_basic_rules = 0
let g:lexima_enable_endwise_rules = 0

" BUFFERS
au group textchanged,insertleave * nested if !&ro | sil! up | en
au group vimenter * sil! let @#=expand('#2:p')
nn <a-e> <cmd>bp<cr><c-g>
nn <a-r> <cmd>bn<cr><c-g>
nn <space>d <cmd>qa!<cr>
nn <space>q <cmd>bd!<cr>
nn q <cmd>b#<cr>
se hidden noswapfile

" COMMENTS
au filetype c setl commentstring=//\ %s
au group filetype * se formatoptions-=cro
nn gci my<cmd>norm vii<bar>gc<cr>`y
nn gcp my<cmd>norm vip<bar>gc<cr>`y

" COMPLETION
au filetype * se omnifunc=v:lua.vim.lsp.omnifunc
se completeopt=menuone,noinsert
se pumheight=8 pumwidth=0
se shortmess+=c
lua << EOF
local cmp = require'cmp'
cmp.setup {
  completion = {
    autocomplete = false,
    completeopt = table.concat(vim.opt.completeopt:get(), ","),
  },
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
  documentation = false,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<c-space>'] = cmp.mapping.complete(),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
        buffer        = '',
        nvim_lsp      = '',
      })[entry.source.name]
      vim_item.kind = ({
        Text          = '',
        Method        = '',
        Function      = '',
        Constructor   = '',
        Field         = '',
        Variable      = '',
        Class         = 'ﴯ',
        Interface     = '',
        Module        = '',
        Property      = '',
        Unit          = '',
        Value         = '',
        Enum          = '',
        Keyword       = '',
        Snippet       = '﬌',
        Color         = '',
        File          = '',
        Reference     = '',
        Folder        = '',
        EnumMember    = 'ℰ',
        Constant      = '',
        Struct        = 'פּ',
        Event         = '',
        Operator      = '',
        TypeParameter = '',
      })[vim_item.kind]
      return vim_item
    end
  },
}
EOF

" EDITING - CHANGE
nm cp cip
nm cw ciw
nm cW ciW
nn c "_c
nn C "_C
xn c "_c

" EDITING - COPY
nn Y y$
nn yp myyap<cmd>ec<cr>`y
nn yw myyiw`y
nn yW myyiW`y
xn y myy<cmd>ec<cr>`y

" EDITING - CUT
nn <expr> dp &diff ? 'dp' : 'dap<cmd>ec<cr>'
nn dw daw
nn dW daW

" EDITING - PASTE
ino <c-v> <c-r>+
nn cP yap}p
nn p p<cmd>ec<cr>

" EDITING - REPLACE
let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1
nm s <plug>(SubversiveSubstitute)
nm S <plug>(SubversiveSubstituteToEndOfLine)
nm ss <plug>(SubversiveSubstituteLine)
xm ss <plug>(SubversiveSubstitute)
nm sw siw
nm sW siW

" EDITING - UNDO
ino ! !<c-g>u
ino , ,<c-g>u
ino . .<c-g>u
ino ? ?<c-g>u
nn <c-r> <c-r><cmd>ec<cr>
nn U <c-r><cmd>ec<cr>
nn u u<cmd>ec<cr>

" EXPLORER
" Start NERDTree when Vim starts with a directory argument.
au stdinreadpre * let s:std_in=1
au vimenter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | winc p | ene | exe 'cd '.argv()[0] | en
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $XDG_DATA_HOME.'/nvim/NERDTreeBookmarks'
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeHijackNetrw = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeShowHidden = 1
let g:NERDTreeSortOrder = ['\/$', 'LICENSE', 'README.*', 'CHANGELOG', 'FAQ', 'Makefile', '[[extension]]']
let g:NERDTreeStatusline = -1
nn <rightmouse> <cmd>NERDTreeToggle<cr>
nn <space>E <cmd>NERDTreeFind<cr>
nn <space>e <cmd>NERDTreeToggle<cr>

aug nerdtree | au! filetype nerdtree call NERDTreeInit() | aug end
fu! NERDTreeInit()
  au nerdtree bufenter * if &ft ==# 'nerdtree' | let g:NERDTreeMouseMode = 3 | en
  nn <buffer> <leftmouse> <leftmouse><cmd>cal <sid>Open()<cr>
  nn <buffer> l <cmd>cal <sid>Open()<cr>
endf

fu! s:Open()
  if &ft !=# 'nerdtree' | retu | en
  if g:NERDTreeMouseMode == 3 | let g:NERDTreeMouseMode = 0 | en
  let file = shellescape(g:NERDTreeFileNode.GetSelected().path.str())
  if file ==# shellescape(b:NERDTree.root.path.str())
    norm U
  elsei split(file, '\.')[-1] =~? '\(pdf\|png\|jpg\|jpeg\|ods\)'
    cal system('open ' . file)
  el
    norm o
  en
endf

" FILETYPE
au group filetype diff se textwidth=72
au group filetype hog se ft=udevrules
au group filetype markdown se textwidth=80
let g:tex_flavor = 'latex'

" FORMATTING
nn gqp gqip
nn gqq Vgq

" FUZZY - CONFIG
lua << EOF
require'fzf-lua'.setup {
  winopts = {
    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    preview = { hidden = 'hidden' },
  },
  files = {
    cmd = 'ffind -type f',
    git_icons = false,
    file_icons = false,
  },
  git = {
    files = { git_icons = false, file_icons = false },
    status = { git_icons = false, file_icons = false },
  },
  oldfiles = {
    cwd_only = true,
    git_icons = false,
    file_icons = false,
  },
  grep = { git_icons = false, file_icons = false },
  helptags = { previewer = { _ctor = false } },
  lines = { git_icons = false, file_icons = false },
  lsp = { git_icons = false, file_icons = false },
  quickfix = { git_icons = false, file_icons = false },
}
EOF

" FUZZY - MAPPINGS (MISC)
nn fb <cmd>lua require('fzf-lua').buffers()<cr>
nn fB <cmd>lua require('fzf-lua').builtin()<cr>
nn fc <cmd>lua require('fzf-lua').commands()<cr>
nn ff <cmd>lua require('fzf-lua').files()<cr>
nn fh <cmd>lua require('fzf-lua').help_tags()<cr>
nn fl <cmd>lua require('fzf-lua').lines()<cr>
nn fo <cmd>lua require('fzf-lua').oldfiles()<cr>
nn fQ <cmd>lua require('fzf-lua').loclist()<cr>
nn fq <cmd>lua require('fzf-lua').quickfix()<cr>
nn fR <cmd>lua require('fzf-lua').registers()<cr>

" FUZZY - MAPPINGS (GREP)
nn fg <cmd>lua require('fzf-lua').grep()<cr>
nn fG <cmd>lua require('fzf-lua').live_grep()<cr>
nn fw <cmd>lua require('fzf-lua').grep_cword()<cr>
nn fW <cmd>lua require('fzf-lua').grep_cWORD()<cr>
xn fw <cmd>lua require('fzf-lua').grep_visual()<cr>

" FUZZY - MAPPINGS (LSP)
nn fd <cmd>lua require('fzf-lua').lsp_definitions()<cr>
nn fi <cmd>lua require('fzf-lua').lsp_implementations()<cr>
nn fr <cmd>lua require('fzf-lua').lsp_references()<cr>
nn fs <cmd>lua require('fzf-lua').lsp_document_symbols()<cr>
nn fS <cmd>lua require('fzf-lua').lsp_workspace_symbols()<cr>

" GIT
au group filetype floggraph nm <buffer> <rightmouse> <leftmouse><cr>
au group filetype floggraph nm <buffer> <space>q <plug>(FlogQuit)
au group filetype floggraph xm <buffer> <rightmouse> <cr>
let g:flog_permanent_default_arguments = { 'date': 'short' }
nn <expr> <space>km &diff ? '<cmd>x<cr>zz' : '<cmd>Gdiffsplit<cr>'
nn <space>kd <cmd>0G diff<cr>
nn <space>kg :Flog -search=
nn <space>kK <cmd>Flog -all -path=%<cr>
nn <space>kk <cmd>Flog -all<cr>
nn <space>kr <cmd>G reset --hard<bar>e<cr>

" GITGUTTER
au group vimenter,bufwritepost * GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_modified_removed = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_above_and_below = '│'
nm <space>i <cmd>GitGutterPreviewHunk<cr>
nm <space>S <cmd>GitGutterStageHunk<cr>
nm <space>u <cmd>sil GitGutterUndoHunk<cr>
nm [c <cmd>sil GitGutterPrevHunk<cr>zz
nm ]c <cmd>sil GitGutterNextHunk<cr>zz
se signcolumn=yes

" GREP
se grepprg=grep\ -IRn\ --exclude-dir=.?*
let g:grepper = {
\ 'grep': {'grepprg': 'grep -IRn --exclude-dir=.?*'},
\ 'highlight' : 1,
\ 'side_cmd' : 'new',
\ 'simple_prompt' : 1,
\ 'tools': ['grep'],
\}
nm gw <plug>(GrepperOperator)iw
nm gW <plug>(GrepperOperator)iW
xm gw <plug>(GrepperOperator)
nn gb <cmd>Grepper -buffer<cr>
nn gB <cmd>Grepper -buffers<cr>
nn gG <cmd>Grepper<cr>

" INCREMENT
nn + <c-a>
nn - <c-x>
se nrformats=
xn + g<C-a>
xn - g<C-x>

" INDENTATION
nn <p <ap
nn >p >ap
se expandtab
se shiftwidth=2
se tabstop=2

" LOADED
let g:loaded_2html_plugin = 0
let g:loaded_getscript = 0
let g:loaded_getscriptPlugin = 0
let g:loaded_gzip = 0
let g:loaded_logiPat = 0
let g:loaded_matchit = 0
let g:loaded_matchparen = 0
let g:loaded_netrw = 0
let g:loaded_netrwPlugin = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_python_provider = 0
let g:loaded_rrhelper = 0
let g:loaded_ruby_provider = 0
let g:loaded_spellfile_plugin = 0
let g:loaded_tar = 0
let g:loaded_tarPlugin = 0
let g:loaded_vimball = 0
let g:loaded_vimballPlugin = 0
let g:loaded_zip = 0
let g:loaded_zipPlugin = 0

" LSP - SERVERS
lua << EOF
vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
require 'lspconfig'.ccls.setup { capabilities = capabilities }
require 'lspconfig'.jedi_language_server.setup { capabilities = capabilities }
EOF

" LSP - MAPPINGS
nn <expr> K '<cmd>'.(index(['vim','help'], &ft) >= 0 ? 'h '.expand('<cword>') : 'lua vim.lsp.buf.hover()').'<cr>'
nn ga <cmd>lua vim.lsp.buf.code_action()<cr>
nn gd <cmd>lua vim.lsp.buf.definition()<cr>
nn gr <cmd>lua vim.lsp.buf.references()<cr>
nn gR <cmd>lua vim.lsp.buf.rename()<cr>
nn gs <cmd>lua vim.lsp.buf.document_symbol()<cr>
nn gS <cmd>lua vim.lsp.buf.workspace_symbol()<cr>

" MISC - MAPPINGS
nn <expr> <cr> &ft == 'qf' ? '<cr>' : 'o<esc>'
nn guw myguiw`y
nn guW myguiW`y
nn gUw mygUiw`y
nn gUW mygUiW`y
nn Q q
xn . :norm.<cr>
xn q :'<,'>:normal @q<cr>

" MISC - SETTINGS
lua require'nvim-lastplace'.setup{}
se clipboard=unnamedplus
se nofoldenable
se nojoinspaces
se notimeout
se virtualedit=block

" MOTIONS
ino <c-l> <right>
nn <a-d> 4<c-y>
nn <a-f> 4<c-e>
nn <c-i> <c-i>zz
nn <c-o> <c-o>zz
nn <silent> n nzz
nn <silent> N Nzz
nn F g$
nn G G0
nn gg gg0
nn H H0
nn J myJ`y
nn L L0
nn M M0
nn { {zz
nn } }zz

" MOUSE
nm <2-rightmouse> <rightmouse>
nm <3-rightmouse> <rightmouse>
nm <4-rightmouse> <rightmouse>
se mouse=a
se mousemodel=popup

" QUICKFIX
au filetype qf se nonu
lua << EOF
require('bqf').setup{
  preview = {
    auto_preview = false,
    border_chars = { '│', '│', '─', '─', '┌', '┐', '└', '┘', '█' },
  },
  func_map = { split = '<c-s>', },
  filter = { fzf = { action_for = { ['ctrl-s'] = 'split' } } },
}
EOF
hi! link bqfpreviewrange none
hi bqfsign ctermfg=yellow

" SANDWICH
let g:textobj_sandwich_no_default_key_mappings = 1
nm saw saiw
nm saW saiW

" SEARCH
cno <expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter><cmd>noh<bar>ec<cr>zz' : '<enter>'
nn <esc> <cmd>noh<bar>ec<cr><esc>
nn <a-esc> <cmd>se hls<cr>
nn <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nn ,w <cmd>let @/= expand('<cword>')<bar>se hls<cr>
xn ,w <cmd>let @/= getline(".")[col('v') - 1 : getpos('.')[2] - 1]<bar>se hls<cr><esc>
se ignorecase smartcase
se inccommand=nosplit
se shortmess+=Ss

" SNIPPETS
let g:vsnip_snippet_dir = $XDG_CONFIG_HOME.'/nvim/snippets'
im <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)' : '<a-tab>'
im <expr> <tab> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
smap <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)' : '<a-tab>'
smap <expr> <tab> vsnip#available(1) ? '<plug>(vsnip-expand-or-next)' : '<tab>'

" SORT
nm <silent> ,s myvii:sort i<cr>`y
xn <silent> ,s my:sort i<cr>`y

" SPELL
se spellcapcheck=
se spellfile=$XDG_DATA_HOME/nvim/spell/en.utf-8.add

" STATUSLINE
fu! s:statusLine()
  if bufname() =~# 'NERD' || empty(expand('%'))
    retu repeat('─', winwidth(0))
  en
  let l:left = '[' . substitute(expand('%:t'), '^[^/]*\/', '', '') . ']'
  let l:right = '[' . line('.') . '/' . line('$') . ']'
  retu l:left . repeat('─', winwidth(0) - len(l:left) - len(l:right)) . l:right
endf
nn <expr> <space>b &ls ? '<cmd>se stl=\  ls=0<cr>' : '<cmd>se ls=2 stl=%{<sid>statusLine()}<cr>'
se fillchars+=diff:\ ,eob:\ ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│
se noruler noshowcmd noshowmode laststatus=0
se statusline=\  rulerformat=%=%l/%L

" SYMBOLS
let g:tagbar_autofocus = 1
let g:tagbar_compact = 2
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_map_showproto = 'd'
let g:tagbar_show_data_type = 1
let g:tagbar_silent = 1
let g:tagbar_singleclick = 1
let g:tagbar_zoomwidth = 0
nn <space>t <cmd>Tagbar<cr>

" TABLINE
se showtabline=1
se tabline=%!TabLine()
fu! TabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    el
      let s .= '%#TabLine#'
    en
    let s .= '%' . (i + 1) . 'T'
    let bufnr = tabpagebuflist(i + 1)[tabpagewinnr(i + 1) - 1]
    let s .= '[' . pathshorten(bufname(bufnr)) . '] '
  endfo
  let s .= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let s .= '%=%#TabLineSel#%999X'
  en
  retu s
endf

" SWITCH
let g:switch_custom_definitions = [
\ ['+', '-'],
\ ['0', '1'],
\ ['<', '>'],
\ ['==', '!='],
\ ['on', 'off'],
\ ['pick', 'fixup', 'reword'],
\ ['yes', 'no'],
\]
let g:switch_mapping = 't'

" TARGETS
au group user targets#mappings#user cal targets#mappings#extend({
\ 'q': {}, 'b': {
\   'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}],
\   'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]
\ },
\})
nm cb cIb
nm db dIb
nm sb sIb
nm yb myyIb`y
nm cnb cInb
nm dnb dInb
nm snb sInb
nm ynb myyInb`y

" TMUXSEND
fu! T(...)
  if !empty(system('tmux has -t $(cat /tmp/tmuxsend)'))
    exe system('tmux neww -ac "#{pane_current_path}" -PF "#{pane_id}" > /tmp/tmuxsend')
    sil !tmux lastp
  en
  exe system('tmux send -t $(cat /tmp/tmuxsend) ' . shellescape(join(a:000)) . ' ENTER')
  if system('tmux display -p "#{window_id}"') != system('tmux display -pt $(cat /tmp/tmuxsend) "#{window_id}"')
    sil !tmux selectw -t $(cat /tmp/tmuxsend)
  en
endf
com! -complete=shellcmd -nargs=+ T cal T(expandcmd(<q-args>))
nn <space><space> <cmd>cal T(getline('.'))<cr>
xn <space><space> "vy <cmd>cal T(substitute(@v, '\n$', '', ''))<cr>
nn <space>a <cmd>T execute<cr>
nn <space>l <cmd>T lint %<cr>

" WILDMENU
se path-=/usr/include path+=**
se wildcharm=<c-z>
se wildignore+=*.o
se wildignore+=*.pdf
se wildignore+=*.zip
se wildignore+=*/.ccls_cache/*
se wildignore+=*/.git/*
se wildignore+=*/.idea/*
se wildignore+=*/.vscode/*
se wildignore+=*/__pycache__/*
se wildignore+=*/build/*
se wildmode=longest:list,full

" WINDOWS
au group vimresized * winc =
nn <a-h> <cmd>lua require('tmux').move_left()<cr>
nn <a-j> <cmd>lua require('tmux').move_down()<cr>
nn <a-k> <cmd>lua require('tmux').move_up()<cr>
nn <a-l> <cmd>lua require('tmux').move_right()<cr>
nn <space>c <c-w>czz
nn <space>s <c-w>s
nn <space>v <c-w>v
nn <space>z <c-w>z<cmd>cclose<cr>
se splitbelow splitright

" WRAP
au group filetype * se formatoptions-=t
nn $ g$
nn 0 g0
nn <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nn <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
xn $ g$
xn 0 g0
se breakindent
se breakindentopt=shift:2
se linebreak
se showbreak=↳\ 
