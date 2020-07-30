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
Plug 'tpope/vim-commentary'
cal plug#end()

" vscode-neovim readme
" rename
" gitgutter
" fold

" CLIPBOARD
nn <c-c> "+yy
xn <c-c> "+y
nn <c-v> "+p
nn <c-x> "+dd
xn <c-x> "+d

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
nn <silent> gs vip:sort i<cr>
xn <silent> gs :sort i<cr>
se nojoinspaces
se noswapfile
se notimeout

" VSCODE
nn <silent> : :cal VSCodeNotify('workbench.action.showCommands')<cr>
nn <silent> <space>i :cal VSCodeNotify('git.openChange')<cr>
nn <silent> <space>u :cal VSCodeNotify('git.revertSelectedRanges')<cr>

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
" nn <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nn <silent> <esc> :noh<cr>
nn <silent> , *``
nn <silent> n nzz
nn <silent> N Nzz
se ignorecase smartcase

" SHORTCUTS
nm gcp gcip
nn <cr> o<esc>
nn <p <ap
nn >p >ap
nn cp cip
nn dp dap
nn Q <c-q>
nn vp vip
nn Y y$
