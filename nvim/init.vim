" FIRST THINGS FIRST
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
    Plug 'junegunn/fzf.vim', { 'on': 'Buffers' }
    Plug 'junegunn/vim-easy-align'
    Plug 'kevinhwang91/nvim-bqf'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'lervag/vimtex', { 'for': 'tex' }
    Plug 'machakann/vim-sandwich'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'rbong/vim-flog', { 'on': 'Flog' }
    Plug 'romgrk/barbar.nvim', { 'on': 'BarbarEnable' }
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'sickill/vim-pasta'
    Plug 'svermeulen/vim-subversive'
    Plug 'szw/vim-maximizer'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive', { 'on': 'Flog' }
    Plug 'tpope/vim-sleuth'
    Plug 'wellle/targets.vim'
call plug#end()

" APPEARANCE (echo synIDattr(synID(line("."), col("."), 1), "name"))
au textyankpost * silent! lua vim.highlight.on_yank{}
colorscheme nord
hi cincluded ctermfg=none
hi comment cterm=italic
hi errormsg ctermbg=none
hi float ctermfg=none
hi function ctermfg=none
hi link conftodo comment
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
let bufferline.closable = v:true
let bufferline.icons = v:true
let bufferline.maximum_padding = 1
nn <silent> <space>b :BarbarEnable<cr>

" BUFFERS
au group textchanged,insertleave * nested sil! up
au group vimenter * silent! let @#=expand('#2:p')
nn <silent> <a-E> :BufferMovePrevious<cr>
nn <silent> <a-e> :BufferPrevious<cr>
nn <silent> <a-R> :BufferMoveNext<cr>
nn <silent> <a-r> :BufferNext<cr>
nn <silent> <space>s <c-w>s
nn <silent> <space>t :tabn<cr>
nn <silent> <space>v <c-w>v
nn <silent> <tab> :b#<cr>
nn <silent> F :Buffers<cr>
nn <silent> f :FZF<cr>

" COMMENTS
au group bufenter * se formatoptions-=cro
nn <silent> gcp my :norm vip <bar> gc<cr> `y
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
ino <c-v> <esc>pa
let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1
nm s  <plug>(SubversiveSubstitute)
nm S  <plug>(SubversiveSubstituteToEndOfLine)
nm ss <plug>(SubversiveSubstituteLine)
xm s  <plug>(SubversiveSubstitute)

" EASY-ALIGN
nmap ga  <plug>(EasyAlign)
xmap ga  <plug>(EasyAlign)
xmap gaa <plug>(EasyAlign)*<space>

" EXPLORER - NETRW
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
        exe "normal \<Plug>NetrwLocalBrowseCheck zz"
    el
        exe 'sil !open' file
    en
endf
au group filetype netrw nm <buffer> <c-rightmouse> <Plug>NetrwSLeftmouse
au group filetype netrw nm <buffer> <cr> mf
au group filetype netrw nm <buffer><silent> <rightmouse> -<left>
au group filetype netrw nm <buffer><silent> h -<left>
au group filetype netrw nn <buffer><silent> <leftmouse> <leftmouse>:cal Open()<cr>
au group filetype netrw nn <buffer><silent> <space>e :Rexplore<cr>
au group filetype netrw nn <buffer><silent> l :cal Open()<cr>
hi netrwMarkFile cterm=bold ctermfg=yellow
let g:netrw_altfile = 1
let g:netrw_banner = 0
let g:netrw_dirhistmax = 0
let g:netrw_list_hide = '^\.*/$'
nn <silent> <c-e> :Explore <bar> :sil! /<c-r>=expand("%:t")<cr><cr>:nohl<cr>

" EXPLORER - NERDTree
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
au bufenter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | exe "normal! \<C-W>w" | exe 'buffer'.buf | en
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $XDG_DATA_HOME.'/nvim/NERDTreeBookmarks'
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeIgnore = ['.git$', '__pycache__$', 'tags$', '\.aux$', '\.fdb_latexmk$', '\.fls$', '\.log$', '\.nav$', '\.out$', '\.snm$', '\.gz$', '\.toc$']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 3
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = ''
let g:NERDTreeWinPos = "right"
nn <silent> <rightmouse> :NERDTreeToggle<cr>
nn <silent> <space>e :NERDTreeToggle<cr>

" FOLD
se foldexpr=nvim_treesitter#foldexpr()
se foldmethod=expr
se nofoldenable

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

" INCREMENT
vn <C-a> g<C-a>
vn <C-x> g<C-x>
vn g<C-a> <C-a>
vn g<C-x> <C-x>

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

" MAXIMIZER
let g:maximizer_set_default_mapping = 1
let g:maximizer_set_mapping_with_bang = 1
nn <silent> <space>m :MaximizerToggle<cr>

" MISC
au group filetype diff se textwidth=72
au group filetype hog se ft=udevrules
au group filetype markdown se textwidth=80
au group vimresized * wincmd =
let g:fzf_preview_window = []
se clipboard=unnamedplus
se expandtab shiftwidth=4 tabstop=4
se nojoinspaces
se noswapfile
se notimeout
se splitbelow splitright
se virtualedit=block
se wildmode=longest,list

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
\   'b': {}, 'q': {}, 'd': {
\       'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}],
\       'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]
\   },
\})
let g:textobj_sandwich_no_default_key_mappings = 1
nm cd cId

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
nn <a-d> 4<c-y>
nn <a-f> 4<c-e>
nn <cr> o<esc>
nn <p <ap
nn >p >ap
nn G G0
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
nn <silent> gsi my :norm vii<cr> :sort i<cr> `y
nn <silent> gss my vip :sort i<cr> `y
xn <silent> gs  my :sort i<cr> `y

" SPELL
au group filetype gitcommit,markdown,tex setlocal spell
se spellcapcheck=
se spellfile=$XDG_CONFIG_HOME/nvim/spell/en.utf-8.add

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
se rulerformat=%=%l/%L
fu! StatusLine()
    if bufname() =~# 'NERD' || empty(expand('%'))
        retu repeat('―', winwidth(0))
    en
    let left = '─[' . substitute(expand('%'), '^[^/]*\/', '', '') . ']'
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

" TREESITTER
highlight tserror ctermfg=15
lua << END
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {"bash", "c", "cpp", "json", "lua", "python"},
    highlight = { enable = false },
    indent = { enable = true },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
            },
        },
        move = {
            enable = true,
            goto_next_start = {
               ["]f"] = "@function.outer",
            },
            goto_next_end = {
               ["]F"] = "@function.outer",
            },
            goto_previous_start = {
               ["[f"] = "@function.outer",
            },
            goto_previous_end = {
               ["[F"] = "@function.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
               ["]a"] = "@parameter.inner",
            },
            swap_previous = {
               ["[a"] = "@parameter.inner",
            },
        },
    },
}
END

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
