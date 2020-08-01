" FIRST THINGS FIRST
aug group | au! | aug en
let mapleader = ' '

" PLUGINS
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
    sil !curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    au vimenter * PlugInstall --sync | so $MYVIMRC
en
cal plug#begin($XDG_DATA_HOME.'/nvim/plugins')
    Plug 'machakann/vim-sandwich'
    Plug 'rhysd/clever-f.vim'
    Plug 'svermeulen/vim-subversive'
cal plug#end()

" CLIPBOARD
nn <c-c> "+yy
xn <c-c> "+y
nn <c-v> "+p
nn <c-x> "+dd
xn <c-x> "+d

" COMMENTARY
nm gc  <Plug>VSCodeCommentary
nm gcc <Plug>VSCodeCommentaryLine
om gc  <Plug>VSCodeCommentary
xm gc  <Plug>VSCodeCommentary
nm gcp gcip

" LOADED
let g:loaded_gzip = 0
let g:loaded_matchparen = 0
let g:loaded_netrw = 0
let g:loaded_netrwPlugin = 0
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

" MISC
au group filetype markdown se textwidth=80
nn <silent> : :cal VSCodeNotify('workbench.action.showCommands')<cr>
nn <silent> <space>i :cal VSCodeNotify('git.openChange')<cr>
nn <silent> <space>u :cal VSCodeNotify('git.revertSelectedRanges')<cr>
nn <silent> gs vip:sort i<cr>
xn <silent> gs :sort i<cr>
se nojoinspaces
se noswapfile
se notimeout

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nn <silent> <esc> :noh<cr>
nn <silent> , *``
nn <silent> n nzz
nn <silent> N Nzz
se ignorecase smartcase

" SHORTCUTS
nn <cr> o<esc>
nn <p <ap
nn >p >ap
nn cp cip
nn dp dap
nn gqp gqip
nn gqq Vgq
nn Q <c-q>
nn vp vip
nn Y y$

" SUBVERSIVE
let g:subversivePromptWithCurrent = 1
let g:subversivePreserveCursorPosition = 1
nm s <plug>(SubversiveSubstitute)
xm s <plug>(SubversiveSubstitute)
nm ss <plug>(SubversiveSubstituteLine)
nm S <plug>(SubversiveSubstituteToEndOfLine)
nm <leader>r <plug>(SubversiveSubstituteWordRange)ie
xm <leader>r <plug>(SubversiveSubstituteRange)ie
xn ie <esc>ggVG
ono ie :exe "norm! ggVG"<cr>

" WRAP & FOLD
nm $ g$
nm 0 g0
nm j gj
nm k gk
xm $ g$
xm 0 g0
xm j gj
xm k gk
