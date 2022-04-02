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
call plug#begin(stdpath('data') . '/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'airblade/vim-rooter'
  Plug 'AndrewRadev/switch.vim'
  Plug 'Darazaki/indent-o-matic'
  Plug 'farmergreg/vim-lastplace'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'ibhagwan/fzf-lua'
  Plug 'junegunn/fzf'
  Plug 'kevinhwang91/nvim-bqf'
  Plug 'machakann/vim-sandwich'
  Plug 'majutsushi/tagbar'
  Plug 'mhinz/vim-grepper'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'nathom/tmux.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'numToStr/Comment.nvim'
  Plug 'rbong/vim-flog'
  Plug 'scrooloose/nerdtree'
  Plug 'stevearc/stickybuf.nvim'
  Plug 'stsewd/gx-extended.vim'
  Plug 'svermeulen/vim-subversive'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'vijaymarupudi/nvim-fzf'
  Plug 'wellle/targets.vim'
  Plug 'windwp/nvim-autopairs'
call plug#end()

" APPEARANCE
autocmd group filetype * set nocursorline
autocmd group textyankpost * silent! lua vim.highlight.on_yank{}
colorscheme colors
nnoremap <space>H <cmd>execute 'highlight' synIDattr(synID(line('.'), col('.'), 1), "name")<cr>

" AUTOPAIR
lua << EOF
require('nvim-autopairs').setup{}
local npairs = require'nvim-autopairs'
local Rule   = require'nvim-autopairs.rule'
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}
EOF

" BUFFERS
autocmd group textchanged,insertleave * nested if !&ro | silent! update | endif
autocmd group vimenter * silent! let @#=expand('#2:p')
nnoremap <space>d <cmd>qa!<cr>
nnoremap <space>q <cmd>bd!<cr>
nnoremap q <cmd>b#<cr>
set noswapfile

" COMMENTS
autocmd group filetype * set formatoptions-=cro
lua require('Comment').setup()
nmap gcj gco
nmap gck gcO
nmap gcl gcA
nmap gcp gcip
unmap gbc

" COMPLETION
autocmd group filetype * set omnifunc=v:lua.vim.lsp.omnifunc
autocmd group filetype c lua require('cmp').setup.buffer {
\ completion = { autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged } }
\}
set completeopt=menuone,noinsert
set pumheight=8 pumwidth=0
set shortmess+=c
lua << EOF
local cmp = require 'cmp'
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
        buffer        = '',
        nvim_lsp      = '',
      })[entry.source.name]
      if (os.getenv("TERM") == "linux" or os.getenv("TERM") == "screen") then
        vim_item.kind = ({
          Text          = '',
          Method        = '[f]',
          Function      = '[f]',
          Constructor   = '[C]',
          Field         = '[v]',
          Variable      = '[v]',
          Class         = '[c]',
          Interface     = '[i]',
          Module        = '[m]',
          Property      = '[p]',
          Unit          = '[u]',
          Value         = '[V]',
          Enum          = '[e]',
          Keyword       = '[k]',
          Snippet       = '[~]',
          Color         = 'Clr',
          File          = '[F]',
          Reference     = '[r]',
          Folder        = '[D]',
          EnumMember    = '[em]',
          Constant      = '[π]',
          Struct        = '[s]',
          Event         = '[!]',
          Operator      = '[%]',
          TypeParameter = '[t]',
        })[vim_item.kind]
      else
        vim_item.kind = ({
          Text          = '',
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
      end
      return vim_item
    end
  },
}
EOF

" EDITING - CHANGE
nmap cp cip
nmap cw ciw
nmap cW ciW
nnoremap c "_c
nnoremap C "_C
xnoremap c "_c

" EDITING - COPY
nnoremap yp <cmd>silent normal myyap`y<cr>
nnoremap yw myyiw`y
nnoremap yW myyiW`y
xnoremap y <cmd>silent normal! myy`y<cr>

" EDITING - CUT
nnoremap <expr> dp &diff ? 'dp' : '<cmd>silent normal dap<cr>'
nnoremap dw daw
nnoremap dW daW
xnoremap d <cmd>silent normal! d<cr>

" EDITING - PASTE
inoremap <c-v> <c-r>+
nnoremap cP yap}p
nnoremap p <cmd>silent normal! p<cr>
nnoremap P <cmd>silent normal! P<cr>

" EDITING - REPLACE
let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1
nmap s <plug>(SubversiveSubstitute)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap ss <plug>(SubversiveSubstituteLine)
xmap ss <plug>(SubversiveSubstitute)
nmap sp sip
nmap sw siw
nmap sW siW

" EDITING - UNDO
inoremap ! !<c-g>u
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
nnoremap <c-r> <cmd>call ExeCmdAndRecenter('redo')<cr>
nnoremap U <cmd>call ExeCmdAndRecenter('redo')<cr>
nnoremap u <cmd>call ExeCmdAndRecenter('undo')<cr>

" FUNCTIONS
fun! ExeCmdAndRecenter(cmd)
  let old_lines = [line('w0'), line('w$')]
  silent execute a:cmd
  if !(line('w0') >= old_lines[0] && line('w$') <= old_lines[1])
    normal zz
  endif
endfun

" EXPLORER
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $XDG_DATA_HOME.'/nvim/NERDTreeBookmarks'
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeSortOrder = ['\/$', 'LICENSE', 'README.*', 'CHANGELOG', 'FAQ', 'Makefile', '[[extension]]']
let g:NERDTreeStatusline = -1
let NERDTreeWinPos='right'
nnoremap <rightmouse> <cmd>NERDTreeToggle<cr>
nnoremap <space>E <cmd>NERDTreeFind<cr>
nnoremap <space>e <cmd>NERDTreeToggle<cr>
if $TERM ==# 'linux' || $TERM ==# 'screen'
  let NERDTreeDirArrowCollapsible=''
  let NERDTreeDirArrowExpandable=''
endif

autocmd group filetype nerdtree call NERDTreeInit()
autocmd group bufenter * if &ft ==# 'nerdtree' | let g:NERDTreeMouseMode = 3 | endif
fun! NERDTreeInit()
  nnoremap <buffer> <leftmouse> <leftmouse><cmd>call <sid>Open()<cr>
  nnoremap <buffer> l <cmd>call <sid>Open()<cr>
endfun

fun! s:Open()
  if &ft !=# 'nerdtree' | return | endif
  if g:NERDTreeMouseMode == 3 | let g:NERDTreeMouseMode = 0 | endif
  let file = shellescape(g:NERDTreeFileNode.GetSelected().path.str())
  if file ==# shellescape(b:NERDTree.root.path.str())
    normal U
  elseif split(file, '\.')[-1] =~? '\(pdf\|png\|jpg\|jpeg\|ods\)'
    call system('open ' . file)
  else
    normal o
   endif
 endfun

" FILETYPE
autocmd group filetype diff set textwidth=72
autocmd group filetype hog set ft=udevrules
autocmd group filetype markdown set textwidth=80
let g:tex_flavor = 'latex'

" FORMATTING
nnoremap gqp gqip
nnoremap gqq Vgq

" FUZZY - CONFIG
lua << EOF
require 'fzf-lua'.setup {
  winopts = {
    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    preview = { hidden = 'hidden' },
    hl = { border = 'statusline' },
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
nnoremap fb <cmd>lua require 'fzf-lua'.buffers()<cr>
nnoremap fB <cmd>lua require 'fzf-lua'.builtin()<cr>
nnoremap fc <cmd>lua require 'fzf-lua'.commands()<cr>
nnoremap ff <cmd>lua require 'fzf-lua'.files()<cr>
nnoremap fh <cmd>lua require 'fzf-lua'.help_tags()<cr>
nnoremap fl <cmd>lua require 'fzf-lua'.blines()<cr>
nnoremap fo <cmd>lua require 'fzf-lua'.oldfiles()<cr>
nnoremap fQ <cmd>lua require 'fzf-lua'.loclist()<cr>
nnoremap fq <cmd>lua require 'fzf-lua'.quickfix()<cr>
nnoremap fR <cmd>lua require 'fzf-lua'.registers()<cr>

" FUZZY - MAPPINGS (GREP)
nnoremap fg <cmd>lua require 'fzf-lua'.grep()<cr>
nnoremap fG <cmd>lua require 'fzf-lua'.live_grep()<cr>
nnoremap fw <cmd>lua require 'fzf-lua'.grep_cword()<cr>
nnoremap fW <cmd>lua require 'fzf-lua'.grep_cWORD()<cr>
xnoremap fw <cmd>lua require 'fzf-lua'.grep_visual()<cr>

" FUZZY - MAPPINGS (LSP)
nnoremap fd <cmd>lua require 'fzf-lua'.lsp_definitions()<cr>
nnoremap fi <cmd>lua require 'fzf-lua'.lsp_implementations()<cr>
nnoremap fr <cmd>lua require 'fzf-lua'.lsp_references()<cr>
nnoremap fs <cmd>lua require 'fzf-lua'.lsp_document_symbols()<cr>
nnoremap fS <cmd>lua require 'fzf-lua'.lsp_workspace_symbols()<cr>

" GIT
autocmd group filetype floggraph nmap <buffer> <rightmouse> <leftmouse><cr>
autocmd group filetype floggraph nmap <buffer> <space>q <plug>(FlogQuit)
autocmd group filetype floggraph xmap <buffer> <rightmouse> <cr>
let g:flog_permanent_default_arguments = { 'date': 'short' }
nnoremap <expr> <space>km &diff ? '<cmd>x<cr>zz' : '<cmd>Gdiffsplit<cr>'
nnoremap <space>kd <cmd>0G diff<cr>
nnoremap <space>kg :Flog -search=
nnoremap <space>kK <cmd>Flog -all -path=%<cr>
nnoremap <space>kk <cmd>Flog -all<cr>
nnoremap <space>kr <cmd>G reset --hard<bar>e<cr>

" GITGUTTER
autocmd group vimenter,bufwritepost * GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
nmap <space>i <cmd>GitGutterPreviewHunk<cr>
nmap <space>S <cmd>GitGutterStageHunk<cr>
nmap <space>u <cmd>silent GitGutterUndoHunk<cr>
nmap [c <cmd>silent GitGutterPrevHunk<cr>zz
nmap ]c <cmd>silent GitGutterNextHunk<cr>zz
set signcolumn=yes

" GREP
set grepprg=grep\ -IRn\ --exclude-dir=.?*
let g:grepper = {
\ 'grep': {'grepprg': 'grep -IRn --exclude-dir=.?*'},
\ 'highlight' : 1,
\ 'side_cmd' : 'new',
\ 'simple_prompt' : 1,
\ 'tools': ['grep'],
\}
nmap gw <plug>(GrepperOperator)iw
nmap gW <plug>(GrepperOperator)iW
xmap gw <plug>(GrepperOperator)
nnoremap <space>G :Grepper<space>
nnoremap <space>g <cmd>Grepper<cr>

" INCREMENT
nnoremap + <c-a>
nnoremap - <c-x>
set nrformats=
xnoremap + g<c-a>
xnoremap - g<c-x>

" INDENTATION
nnoremap <p <ap
nnoremap >p >ap
set expandtab
set shiftwidth=4
set tabstop=4

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
let g:loaded_remote_plugins = 0
let g:loaded_rrhelper = 0
let g:loaded_ruby_provider = 0
let g:loaded_spellfile_plugin = 0
let g:loaded_tar = 0
let g:loaded_tarPlugin = 0
let g:loaded_tutor_mode_plugin = 0
let g:loaded_vimball = 0
let g:loaded_vimballPlugin = 0
let g:loaded_zip = 0
let g:loaded_zipPlugin = 0

" LSP - SERVERS
lua << EOF
vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities)
require 'lspconfig'.ccls.setup { capabilities = capabilities }
require 'lspconfig'.jedi_language_server.setup { capabilities = capabilities }
EOF

" LSP - MAPPINGS
nnoremap <expr> K '<cmd>'.(index(['vim','help'], &ft) >= 0 ? 'h '.expand('<cword>') : 'lua vim.lsp.buf.hover()').'<cr>'
nnoremap ga <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap gR <cmd>lua vim.lsp.buf.references()<cr>
nnoremap gr <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap gs <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap gS <cmd>lua vim.lsp.buf.workspace_symbol()<cr>

" MISC - MAPPINGS
nnoremap <expr> <cr> &ft == 'qf' ? '<cr>' : 'o<esc>'
nnoremap guw myguiw`y
nnoremap guW myguiW`y
nnoremap gUw mygUiw`y
nnoremap gUW mygUiW`y
nnoremap Q q
xnoremap . :normal .<cr>
xnoremap q :'<,'>:normal @q<cr>

" MISC - SETTINGS
set clipboard=unnamedplus
set nofoldenable
set notimeout
set virtualedit=block

" MOTIONS
" noremap <silent> s <cmd>call feedkeys('/'.getcharstr().getcharstr()."\r")<cr>
" noremap <silent> S <cmd>call feedkeys('?'.getcharstr().getcharstr()."\r")<cr>
inoremap <c-l> <right>
nnoremap <a-d> 4<c-y>
nnoremap <a-f> 4<c-e>
nnoremap <c-i> <c-i>zz
nnoremap <c-o> <c-o>zz
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap F g$
xnoremap F g$
nnoremap G G0
nnoremap gg gg0
nnoremap H H0
nnoremap J myJ`y
nnoremap L L0
nnoremap M M0
nnoremap { {zz
nnoremap } }zz

" MOUSE
nmap <2-rightmouse> <rightmouse>
nmap <3-rightmouse> <rightmouse>
nmap <4-rightmouse> <rightmouse>
set mouse=a
set mousemodel=popup

" QUICKFIX
autocmd group filetype qf set nonu
lua << EOF
require 'bqf'.setup{
  preview = {
    border_chars = { '│', '│', '─', '─', '┌', '┐', '└', '┘', '█' },
  },
  func_map = { split = '<c-s>', },
  filter = { fzf = { action_for = { ['ctrl-s'] = 'split' } } },
}
EOF
highlight! link bqfpreviewrange none
highlight bqfsign ctermfg=yellow

" ROOTER
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1

" SANDWICH
let g:textobj_sandwich_no_default_key_mappings = 1
nmap saw saiw
nmap saW saiW

" SEARCH
cno <expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter><cmd>echo<bar>noh<cr>zz' : '<enter>'
nnoremap <esc> <cmd>echo<bar>noh<cr><esc>
nnoremap <a-esc> <cmd>set hls<cr>
nnoremap <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nnoremap ,w <cmd>let @/= expand('<cword>')<bar>set hls<cr>
xnoremap ,w <cmd>let @/= getline(".")[col('v') - 1 : getpos('.')[2] - 1]<bar>set hls<cr><esc>
set ignorecase smartcase
set shortmess+=Ss

" SNIPPETS
let g:vsnip_snippet_dir = $XDG_CONFIG_HOME.'/nvim/snippets'
imap <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)' : '<a-tab>'
imap <expr> <tab> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
smap <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)' : '<a-tab>'
smap <expr> <tab> vsnip#available(1) ? '<plug>(vsnip-expand-or-next)' : '<tab>'

" SORT
nmap <silent> ,s myvii:sort i<cr>`y
xnoremap <silent> ,s my:sort i<cr>`y

" SPELL
set spellcapcheck=
set spellfile=$XDG_DATA_HOME/nvim/spell/en.utf-8.add

" STATUSLINE
fun! s:statusLine()
  let left = '[' . pathshorten(expand('%')) . ']'
  let right = '[' . line('.') . '/' . line('$') . ']'
  if &ft =~# '\(floggraph\|nerdtree\|tagbar\)' || empty(expand('%'))
    let left = ''
  endif
  return left . repeat('─', winwidth(0) - len(left) - len(right)) . right
endfun
nnoremap <expr> <space>b &ls ? '<cmd>set stl=\  ls=0<cr>' : '<cmd>set ls=2 stl=%{<sid>statusLine()}<cr>'
set fillchars+=diff:\ ,eob:\ ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│
set noruler noshowcmd noshowmode laststatus=0
set statusline=\  rulerformat=%=%l/%L

" TABLINE
set showtabline=1
set tabline=%!TabLine()
fun! TabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    let s .= '%' . (i + 1) . 'T'
    let bufnr = tabpagebuflist(i + 1)[tabpagewinnr(i + 1) - 1]
    let s .= '[' . pathshorten(bufname(bufnr)) . '] '
  endfor
  let s .= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let s .= '%=%#TabLineSel'
  endif
  return s
endfun

" TAGBAR
let g:tagbar_autofocus = 1
let g:tagbar_compact = 2
let g:tagbar_indent = 0
let g:tagbar_map_showproto = 'd'
let g:tagbar_position = 'left'
let g:tagbar_show_data_type = 1
let g:tagbar_silent = 1
let g:tagbar_singleclick = 1
let g:tagbar_zoomwidth = 0
nnoremap <space>T <cmd>Tagbar<cr>
if $TERM ==# 'linux' || $TERM ==# 'screen'
  let g:tagbar_iconchars = ['<', '>']
else
  let g:tagbar_iconchars = ['▸', '▾']
endif

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

" TABS
nnoremap <a-e> <cmd>tabp<cr>
nnoremap <a-r> <cmd>tabn<cr>
nnoremap <space>n <cmd>tab sp<cr>
tnoremap <silent> <a-e> <c-\><c-n><cmd>tabp<cr>
tnoremap <silent> <a-r> <c-\><c-n><cmd>tabn<cr>

" TARGETS
autocmd group user targets#mappings#user call targets#mappings#extend({
\ 'q': {}, 'b': {
\   'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}],
\   'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]
\ },
\})
nmap cb cIb
nmap db dIb
nmap sb sIb
nmap yb myyIb`y
nmap cnb cInb
nmap dnb dInb
nmap snb sInb
nmap ynb myyInb`y

" TERMINAL
autocmd group bufenter,focusgained,termopen term://* startinsert
autocmd group termopen * nnoremap <buffer><leftrelease> <leftrelease>i
autocmd group termopen * setlocal signcolumn=no

" TMUX
command! -complete=shellcmd -nargs=* T call system('iwltm --send '.shellescape(expandcmd(<q-args>)))
nnoremap <space><space> <cmd>call T(getline('.'))<cr>
xnoremap <space><space> "vy <cmd>call T(substitute(@v, '\n$', '', ''))<cr>
nnoremap <space>a <cmd>T execute<cr>
nnoremap <space>l <cmd>T lint %<cr>

" WILDMENU
set path-=/usr/include path+=**
set wildcharm=<c-z>
set wildignore+=*.o
set wildignore+=*.pdf
set wildignore+=*.zip
set wildignore+=*/.ccls_cache/*
set wildignore+=*/.git/*
set wildignore+=*/.idea/*
set wildignore+=*/.vscode/*
set wildignore+=*/__pycache__/*
set wildignore+=*/build/*
set wildmode=longest:list,full

" WINDOWS
autocmd group vimresized * wincmd =
nnoremap <a-h> <cmd>lua require 'tmux'.move_left()<cr>
nnoremap <a-j> <cmd>lua require 'tmux'.move_down()<cr>
nnoremap <a-k> <cmd>lua require 'tmux'.move_up()<cr>
nnoremap <a-l> <cmd>lua require 'tmux'.move_right()<cr>
nnoremap <space>c <c-w>czz
nnoremap <space>s <c-w>s
nnoremap <space>v <c-w>v
nnoremap <space>z <c-w>z<cmd>cclose<cr>
set splitbelow splitright
tnoremap <silent> <a-h> <c-\><c-n><cmd>lua require 'tmux'.move_left()<cr>
tnoremap <silent> <a-j> <c-\><c-n><cmd>lua require 'tmux'.move_down()<cr>
tnoremap <silent> <a-k> <c-\><c-n><cmd>lua require 'tmux'.move_up()<cr>
tnoremap <silent> <a-l> <c-\><c-n><cmd>lua require 'tmux'.move_right()<cr>

" WRAP
autocmd group filetype * set formatoptions-=t
nnoremap $ g$
nnoremap 0 g0
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
xnoremap $ g$
xnoremap 0 g0
set breakindent
set breakindentopt=shift:2
set linebreak

if $TERM ==# 'linux' || $TERM ==# 'screen'
  set showbreak=¬\ 
else
  set showbreak=﬌\ 
endif
