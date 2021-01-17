aug group | au! | aug end
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
    silent !curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimenter * PlugInstall --sync | source $MYVIMRC
endif
nnoremap <silent> <space>pc :PlugClean<cr>
nnoremap <silent> <space>pp :PlugUpgrade <bar> PlugUpdate<cr>
call plug#begin($XDG_DATA_HOME.'/nvim/plugins')
    Plug 'airblade/vim-gitgutter'
    Plug 'AndrewRadev/switch.vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'cohama/lexima.vim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'lervag/vimtex', { 'for': 'tex' }
    Plug 'machakann/vim-sandwich'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'rbong/vim-flog', { 'on': 'Flog' }
    Plug 'romgrk/barbar.nvim'
    Plug 'svermeulen/vim-subversive'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive', { 'on': 'Flog' }
    Plug 'tpope/vim-sleuth'
    Plug 'wellle/targets.vim'
call plug#end()

" APPEARANCE (echo synIDattr(synID(line("."), col("."), 1), "name"))
colorscheme nord
hi cincluded ctermfg=none
hi comment cterm=italic
hi errormsg ctermbg=none
hi float ctermfg=none
hi function ctermfg=none
hi matchparen cterm=none ctermbg=none ctermfg=none
hi number ctermfg=none
hi vimaugroup ctermfg=none
hi vimmaprhs ctermfg=none
hi vimnotation ctermfg=none
hi warningmsg ctermbg=none ctermfg=none
se cursorline | hi clear cursorline

" BARBAR
highlight bufferinactive ctermfg=8
let bufferline = {}
let bufferline.animation = v:false
let bufferline.auto_hide = v:true
let bufferline.closable = v:false
let bufferline.icons = v:false
let bufferline.maximum_padding = 0

" BUFFERS
au group textchanged,insertleave * nested sil! up
nn <a-tab> :ls<cr>:b<space>
nn <silent> <a-e> :BufferPrevious<cr>
nn <silent> <a-r> :BufferNext<cr>
nn <silent> <space>f :FZF<cr>
nn <silent> <space>s <c-w>s
nn <silent> <space>t :tabn<cr>
nn <silent> <tab> :b#<cr>

" COMMENTS
au group bufenter * se formatoptions-=cro
nm gcp my vip gc `y
se commentstring=//\ %s

" COMPLETION
hi pmenusel ctermfg=none
ino <expr> <c-k> pumvisible() ? "\<c-e>" : "\<c-k>"
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
ino <c-v> <c-o>p
let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1
nm s  <plug>(SubversiveSubstitute)
nm S  <plug>(SubversiveSubstituteToEndOfLine)
nm ss <plug>(SubversiveSubstituteLine)
xm s  <plug>(SubversiveSubstitute)

" EXPLORER
fu! Open()
    let path = expand('%:p')
    if !isdirectory(path)
        " Fixes bug where the current directory is added two times
        " to the end of the path-variable
        let path = fnamemodify(path, ':h') . '/'
    en
    let file = fnameescape(path . getline('.'))
    let mime = system('file -bL --mime-type ' . file)
    if isdirectory(file) || empty(glob(file)) || mime =~# '\(text/.*\|.*/json\|.*csv\)'
        exe "normal \<Plug>NetrwLocalBrowseCheck"
    el
        exe 'sil !open' file
    en
endf
au group filetype netrw nm <buffer> <c-rightmouse> <Plug>NetrwSLeftmouse
au group filetype netrw nm <buffer> <cr> mf
au group filetype netrw nn <buffer><silent> <leftmouse> <leftmouse>:cal Open()<cr>
au group filetype netrw nn <buffer><silent> <rightmouse> :sil! norm -<cr>
au group filetype netrw nn <buffer><silent> <space>e :Rexplore<cr>
au group filetype netrw nn <buffer><silent> h :sil! norm -<cr>
au group filetype netrw nn <buffer><silent> l :cal Open()<cr>
hi netrwMarkFile cterm=bold ctermfg=yellow
let g:netrw_altfile = 1
let g:netrw_banner = 0
let g:netrw_browsex_viewer= 'open'
let g:netrw_dirhistmax = 0
let g:netrw_keepdir = 0
let g:netrw_list_hide = '^\.*/$'
nn <silent> <rightmouse> :Explore <bar> :sil! /<c-r>=expand("%:t")<cr><cr>:nohl<cr>
nn <silent> <space>e :Explore <bar> :sil! /<c-r>=expand("%:t")<cr><cr>:nohl<cr>

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
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
nm <space>i <Plug>(GitGutterPreviewHunk)
nm <space>S <Plug>(GitGutterStageHunk)
nm <space>u <Plug>(GitGutterUndoHunk)
nm [c <Plug>(GitGutterPrevHunk)zz
nm ]c <Plug>(GitGutterNextHunk)zz
se signcolumn=yes

" KILL
nn <silent> <space>c :close<cr>zz
nn <silent> <space>d :qa!<cr>
nn <silent> <space>q :BufferClose<cr>
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
au group filetype gitcommit,markdown,tex setlocal spell
au group filetype hog se ft=udevrules
au group filetype markdown se textwidth=80
au group vimresized * wincmd =
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
se clipboard=unnamedplus
se expandtab shiftwidth=4 tabstop=4
se hidden
se nofoldenable
se nojoinspaces
se noswapfile
se notimeout
se splitbelow splitright
se virtualedit=block
se wildmode=longest,list
set spellcapcheck=

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

" OBJECTS
au User targets#mappings#user cal targets#mappings#extend({
    \ 'd': {'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}]},
    \ 's': {'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]},
    \ 'b': {}, 'q': {},
\ })
let g:textobj_sandwich_no_default_key_mappings = 1
nm cd cId
nm cs cIs

" SEARCH
hi incsearch cterm=none ctermbg=yellow ctermfg=black
hi search    cterm=none ctermbg=none   ctermfg=red
nn n nzz
nn N Nzz
nn / <nop>
nn ? <nop>
nn f /
nn F ?
nn <silent> <esc> :noh <bar> echo<cr>
nn <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nn <silent> , :let @/= expand('<cword>') <bar> se hlsearch <cr>
xn <silent> , :<c-u>let @/= getline(".")[getpos("'<")[2] - 1:getpos("'>")[2] - 1] <bar> se hlsearch <cr>
se ignorecase smartcase
se inccommand=nosplit

" SHORTCUTS
ino <c-l> <esc>la
nn <a-d> 4<c-y>
nn <a-f> 4<c-e>
nn <cr> o<esc>
nn <p <ap
nn >p >ap
nn gg gg0
nn Q <c-q>
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
nm <silent> gsi my vii :sort i<cr> `y
nn <silent> gss my vip :sort i<cr> `y
xn <silent> gs  my :sort i<cr> `y

" STATE
au group bufwinenter * if index(ignore_ft, &ft) < 0 | sil! loadview | en
au group bufwinleave * if index(ignore_ft, &ft) < 0 | sil! mkview | en
let ignore_ft = ['diff', 'gitcommit', 'gitrebase']
se viewoptions=cursor

" STATUSLINE
hi statusline ctermbg=none ctermfg=8
hi statuslinenc ctermbg=none ctermfg=8
hi vertsplit ctermbg=none ctermfg=8
se fillchars+=eob:\ ,fold:\ ,stl:―,stlnc:―,vert:▏
se noruler noshowcmd noshowmode laststatus=0
se rulerformat=%=%l/%L
fu! StatusLine()
    if empty(expand('%'))
        retu repeat('―', winwidth(0))
    en
    let left = '―[' . substitute(expand('%'), '^[^/]*\/', '', '') . ']'
    let right = '[' . line('.') . '/' . line('$') . ']'
    retu left . repeat('―', winwidth(0) - len(left) - len(right)) . right
endf
se statusline=\ 

" SWITCH
au group filetype gitrebase let b:switch_custom_definitions = [['pick', 'f', 'r', 'd']]
let g:switch_custom_definitions = [['0', '1'], ['==', '!=']]
let g:switch_mapping = 't'

" TABLINE
hi tabline ctermbg=none ctermfg=8
hi tablinefill ctermbg=none
hi tablinesel ctermbg=none ctermfg=none
se showtabline=0

" TMUXRENAME
fu! TmuxRename()
    if &ft == 'git'
        cal system('tmux renamew git')
    el
        cal system('tmux renamew "#{b:pane_current_path}"')
    en
endf
au group vimenter,vimresume,focusgained * cal TmuxRename()
au group vimleave,vimsuspend * cal system('tmux setw automatic-rename')

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
