" FIRST THINGS FIRST
aug group | au! | aug end
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
    sil !curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    au group vimenter * PlugInstall --sync | source $MYVIMRC
en
nn <silent> <space>pc :PlugClean<cr>
nn <silent> <space>pp :PlugUpgrade <bar> PlugUpdate<cr>
cal plug#begin($XDG_DATA_HOME.'/nvim/plugins')
    Plug 'airblade/vim-gitgutter'
    Plug 'AndrewRadev/switch.vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'cohama/lexima.vim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'junegunn/fzf.vim', { 'on': 'Buffers' }
    Plug 'kevinhwang91/nvim-bqf'
    Plug 'lervag/vimtex', { 'for': 'tex' }
    Plug 'machakann/vim-sandwich'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'rbong/vim-flog', { 'on': 'Flog' }
    Plug 'stsewd/gx-extended.vim'
    Plug 'svermeulen/vim-subversive'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive', { 'on': ['Flog', 'Gblame'] }
    Plug 'tpope/vim-sleuth'
    Plug 'wellle/targets.vim'
cal plug#end()

" APPEARANCE (echo synIDattr(synID(line("."), col("."), 1), "name"))
au group filetype sh hi link shiferror shconditional
au textyankpost * silent! lua vim.highlight.on_yank{}
colorscheme nord
hi cincluded ctermfg=none
hi comment cterm=italic
hi coperator ctermfg=none
hi errormsg ctermbg=none
hi float ctermfg=none
hi function ctermfg=none
hi link conftodo comment
hi matchparen cterm=none ctermbg=none ctermfg=none
hi number ctermfg=none
hi vimaugroup ctermfg=none
hi vimmaprhs ctermfg=none
hi vimnotation ctermfg=none
hi warningmsg  ctermbg=none ctermfg=none
se cursorline | hi clear cursorline

" BUFFERS
au group textchanged,insertleave * nested if &readonly == 0 | sil! up | en
au group vimenter * silent! let @#=expand('#2:p')
nn <silent> <a-e> :bp<cr><c-g>
nn <silent> <a-r> :bn<cr><c-g>
nn <silent> <space>s <c-w>s
nn <silent> <space>t :tabn<cr>
nn <silent> <space>v <c-w>v
nn <silent> <tab> :b#<cr>
nn <silent> F :Buffers<cr>
nn <silent> f :FZF<cr>

" COMMENTS
au group filetype * se formatoptions-=cro
nn <silent> gcp my :norm vip <bar> gc<cr> `y
se commentstring=//\ %s

" COMPLETION
hi pmenusel ctermfg=none
se completeopt=menuone,noinsert
se infercase shortmess+=c
se pumheight=8 pumwidth=0

" EDITING - CHANGE
nm cp cip
nm cw ciw
nm cW ciW
nn c "_c
nn C "_C
xn c "_c

" EDITING - COPY
nn Y y$
nn yp my yip `y
nn yw my yiw `y
nn yW my yiW `y

" EDITING - CUT
nn dp dap
nn dw daw
nn dW daW

" EDITING - PASTE
ino <c-v> <esc>pa
let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1
nm s  <plug>(SubversiveSubstitute)
nm S  <plug>(SubversiveSubstituteToEndOfLine)
nm ss <plug>(SubversiveSubstituteLine)
xm ss <plug>(SubversiveSubstitute)

" FORMAT
fu! Format()
    let l:save = winsaveview()
    exe 'retab! | sil up'
    cal system('format ' . bufname('%'))
    exe 'edit'
    cal winrestview(l:save)
endf
nn <silent> <space>gf :cal Format()<cr>

" GIT
au group filetype * if index(['floggraph'], &ft) < 0 | nn <buffer> gqp gqip | en
au group filetype * if index(['floggraph'], &ft) < 0 | nn <buffer> gqq Vgq | en
au group filetype floggraph nm <buffer> <rightmouse> <leftmouse><cr>
au group filetype floggraph xm <buffer> <rightmouse> <cr>
hi diffadded cterm=none ctermbg=none ctermfg=green
hi diffremoved cterm=none ctermbg=none ctermfg=red
hi difftext cterm=none ctermbg=none ctermfg=green
nn <silent> <space>kd :Gdiff<cr>
nn <silent> <space>kK :Flog -all -path=%<cr>
nn <silent> <space>kk :Flog -all<cr>

" GITGUTTER
au group vimenter,bufwritepost * GitGutter
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
nm <space>i <Plug>(GitGutterPreviewHunk)
nm <space>S <Plug>(GitGutterStageHunk)
nm <space>u <Plug>(GitGutterUndoHunk)
nm [c <Plug>(GitGutterPrevHunk)zz
nm ]c <Plug>(GitGutterNextHunk)zz
se signcolumn=yes

" INCREMENT
vn <C-a> g<C-a>
vn <C-x> g<C-x>
vn g<C-a> <C-a>
vn g<C-x> <C-x>

" KILL
nn <silent> <space>c :close<cr>zz
nn <silent> <space>d :qa!<cr>
nn <silent> <space>q :bn<bar>bd!#<cr>
nn <silent> <space>z :wincmd z<cr>

" LATEX
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
    \'callback' : 0,
    \'continuous' : 0,
    \'options' : [
        \'-verbose',
        \'-file-line-error',
        \'-synctex=0',
        \'-interaction=nonstopmode',
    \],
\}
au group filetype tex nn <silent> <space>a :VimtexCompile<cr>
au user VimtexEventCompileSuccess cal ViewPDF()
fu! ViewPDF()
    if system('pidof zathura')
        exe 'sil !wmctrl -xa zathura'
    el
        exe 'VimtexView'
    en
    exe 'ec'
endf

" LEXIMA
let g:lexima_ctrlh_as_backspace = 1
let g:lexima_enable_endwise_rules = 0
let g:lexima_map_escape = ''

" LOADED
let g:loaded_gzip = 0
let g:loaded_matchparen = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_spellfile_plugin = 0
let g:loaded_tar = 0
let g:loaded_tarPlugin = 0
let g:loaded_zip = 0
let g:loaded_zipPlugin = 0

" LSP
let g:coc_global_extensions = ['coc-json', 'coc-python', 'coc-vimtex']
nm <silent> gd <plug>(coc-definition)zz
nm <silent> gR <plug>(coc-references)
nm <silent> gr <plug>(coc-rename)
nn <silent> K :cal <sid>show_documentation()<cr>
fu! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        exe 'h '.expand('<cword>')
    elsei (coc#rpc#ready())
        cal CocActionAsync('doHover')
    el
        exe '!' . &keywordprg . " " . expand('<cword>')
    en
endf

" MISC
au group filetype diff se textwidth=72
au group filetype hog se ft=udevrules
au group filetype markdown se textwidth=80
au group vimresized * wincmd =
let g:fzf_preview_window = []
se clipboard=unnamedplus
se expandtab shiftwidth=4 tabstop=4
se nofoldenable
se nojoinspaces
se noswapfile
se notimeout
se splitbelow splitright
se virtualedit=block
se wildmode=longest:full,full

" MOUSE
nm <silent> <2-rightmouse> <rightmouse>
nm <silent> <3-rightmouse> <rightmouse>
nm <silent> <4-rightmouse> <rightmouse>
se mouse=a
se mousemodel=popup

" NAVIGATION
let g:tmux_navigator_no_mappings = 1
nn <silent> <a-h> :TmuxNavigateLeft<cr>
nn <silent> <a-j> :TmuxNavigateDown<cr>
nn <silent> <a-k> :TmuxNavigateUp<cr>
nn <silent> <a-l> :TmuxNavigateRight<cr>
ino <silent> <a-h> <c-o>:TmuxNavigateLeft<cr>
ino <silent> <a-j> <c-o>:TmuxNavigateDown<cr>
ino <silent> <a-k> <c-o>:TmuxNavigateUp<cr>
ino <silent> <a-l> <c-o>:TmuxNavigateRight<cr>

" NETRW
au group filetype netrw nm <buffer> <c-rightmouse> <Plug>NetrwSLeftmouse
au group filetype netrw nm <buffer> <cr> mf
au group filetype netrw nm <buffer><silent> <rightmouse> -<left>
au group filetype netrw nm <buffer><silent> h -<left>
au group filetype netrw nn <buffer><silent> <leftmouse> <leftmouse>:cal NetrwOpen()<cr>
au group filetype netrw nn <buffer><silent> <space>e :Rexplore<cr>
au group filetype netrw nn <buffer><silent> l :cal NetrwOpen()<cr>
hi netrwMarkFile ctermfg=yellow
let g:netrw_altfile = 1
let g:netrw_banner = 0
let g:netrw_dirhistmax = 0
let g:netrw_list_hide = '^\.*/$'
nn <silent> <space>e :Explore <bar> :sil! /<c-r>=expand("%:t")<cr><cr>:nohl<cr>

" NETRW - OPEN
fu! NetrwOpen()
    let path = expand('%:p')
    if !isdirectory(path)
        " Fixes bug where the current directory is added two times
        " to the end of the path-variable
        let path = fnamemodify(path, ':h') . '/'
    en
    let file = fnameescape(path . getline('.'))
    let mime = system('file -bL --mime-type ' . file)
    if isdirectory(file) || empty(glob(file)) || mime =~# '\(text/.*\|.*/json\|.*csv\)'
        exe "normal \<Plug>NetrwLocalBrowseCheck zz"
    el
        exe 'sil !open' file
    en
endf

" OBJECTS
au User targets#mappings#user cal targets#mappings#extend({
\   'b': {}, 'q': {}, 'm': {
\       'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}],
\       'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]
\   },
\})
let g:textobj_sandwich_no_default_key_mappings = 1
nm cm cIm
nm dm dIm
nm sm sIm
nm ym yIm
nm yl my yal `y

" SEARCH
hi incsearch cterm=none ctermbg=yellow ctermfg=black
hi search    cterm=none ctermbg=none   ctermfg=red
nn n nzz
nn N Nzz
nn <silent> <esc> :noh <bar> echo<cr>
nn <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nn <silent> , :let @/= expand('<cword>') <bar> se hlsearch <cr>
xn <silent> , :<c-u>let @/= getline(".")[getpos("'<")[2] - 1:getpos("'>")[2] - 1] <bar> se hlsearch <cr>
se ignorecase smartcase
se inccommand=nosplit

" SHORTCUTS
ino <c-l> <esc>la
nm <rightmouse> <leftmouse>gx
nn <a-d> 4<c-y>
nn <a-f> 4<c-e>
nn <c-r> <c-r>:echo<cr>
nn <cr> o<esc>
nn <p <ap
nn >p >ap
nn G G0
nn gg gg0
nn Q <nop>
nn u u:echo<cr>
nn vp vip
nn { {zz
nn } }zz

" SNIPPETS
let g:vsnip_snippet_dir = $XDG_CONFIG_HOME.'/nvim/snippets'
im   <silent> <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)'      : '<a-tab>'
im   <silent> <expr> <tab>   vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
smap <silent> <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)'      : '<a-tab>'
smap <silent> <expr> <tab>   vsnip#available(1) ? '<plug>(vsnip-expand-or-next)' : '<tab>'

" SORT
nn <silent> gsi my :norm vii<cr> :sort i<cr> `y
nn <silent> gss my vip :sort i<cr> `y
xn <silent> gs  my :sort i<cr> `y

" SPELL
au group filetype gitcommit,markdown,tex setlocal spell
hi spellrare cterm=none ctermfg=none
se spellcapcheck=
se spellfile=$XDG_DATA_HOME/nvim/spell/en.utf-8.add

" STATE
au group bufwinenter * if index(ignore_ft, &ft) < 0 | sil! loadview | en
au group bufwinleave * if index(ignore_ft, &ft) < 0 | sil! mkview | en
let ignore_ft = ['diff', 'gitcommit', 'gitrebase']
se viewoptions=cursor

" STATUSLINE
hi statusline ctermbg=none ctermfg=8
hi statuslinenc ctermbg=none ctermfg=8
hi vertsplit ctermbg=none ctermfg=8
se fillchars+=eob:\ ,fold:\ ,stl:─,stlnc:─,vert:│
se noruler noshowcmd noshowmode laststatus=0
se statusline=\  rulerformat=%=%l/%L

" STATUSLINE - DEFINITION
fu! StatusLine()
    if empty(expand('%'))
        retu repeat('─', winwidth(0))
    en
    let left = '[' . substitute(expand('%:t'), '^[^/]*\/', '', '') . ']'
    let right = '[' . line('.') . '/' . line('$') . ']'
    retu left . repeat('─', winwidth(0) - len(left) - len(right)) . right
endf

" STATUSLINE - TOGGLE
fu! StatusLineToggle()
    if &laststatus == 0
        exe 'se laststatus=2 statusline=%{StatusLine()}'
    else
        exe 'se laststatus=0  statusline=\ '
    en
endf
nn <silent> <space>b :cal StatusLineToggle()<cr>

" SWITCH
let g:switch_custom_definitions = [
    \['+', '-'],
    \['0', '1'],
    \['<', '>'],
    \['==', '!='],
    \['pick', 'f', 'r'],
    \['yes', 'no'],
\]
let g:switch_mapping = 't'

" TABLINE
hi tabline ctermbg=none ctermfg=8
hi tablinefill ctermbg=none
hi tablinesel ctermbg=none ctermfg=none
se showtabline=0

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
nn <silent> <space><space> :cal T(getline('.'))<cr>
xn <silent> <space><space> "vy :cal T(substitute(@v, '\n$', '', ''))<cr>
nn <silent> <space>l :T lint %<cr>
nn <silent> <space>a :T execute<cr>

" TREESITTER
highlight tserror ctermfg=15
nm df vafjd
lua require 'nvim-treesitter.configs'.setup {
\   ensure_installed = {"bash", "c", "cpp", "json", "lua", "python"},
\   highlight = {
\       enable = false,
\       additional_vim_regex_highlighting = true,
\   },
\   textobjects = {
\       select = {
\           enable = true,
\           keymaps = {
\               ["af"] = "@function.outer",
\               ["if"] = "@function.inner",
\           },
\       },
\       move = {
\           enable = true,
\           goto_next_start = {
\              ["]f"] = "@function.outer",
\           },
\           goto_next_end = {
\              ["]F"] = "@function.outer",
\           },
\           goto_previous_start = {
\              ["[f"] = "@function.outer",
\           },
\           goto_previous_end = {
\              ["[F"] = "@function.outer",
\           },
\       },
\       swap = {
\           enable = true,
\           swap_next = {
\              ["]a"] = "@parameter.inner",
\           },
\           swap_previous = {
\              ["[a"] = "@parameter.inner",
\           },
\       },
\   },
\}

" WRAP
nn $ g$
nn 0 g0
nn j gj
nn k gk
xn $ g$
xn 0 g0
xn j gj
xn k gk
se breakindent
se linebreak
