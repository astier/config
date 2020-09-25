" FIRST THINGS FIRST
augroup group | autocmd! | augroup end
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
    sil !curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimenter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin($XDG_DATA_HOME.'/nvim/plugins')
    Plug 'bronson/vim-visual-star-search'
    Plug 'junegunn/vim-easy-align'
    Plug 'machakann/vim-sandwich'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'rhysd/clever-f.vim'
    Plug 'svermeulen/vim-subversive'
    Plug 'tpope/vim-commentary'
call plug#end()

" CLIPBOARD
nnoremap <c-c> "+yy
xnoremap <c-c> "+y
nnoremap <c-v> "+p

" EASY-ALIGN
nmap ga <plug>(EasyAlign)
xmap ga <plug>(EasyAlign)
xmap gaa <plug>(EasyAlign)*<space>

" GIT
nnoremap <silent> <space>i :call VSCodeNotify('git.openChange')<cr>
nnoremap <silent> <space>u :call VSCodeNotify('git.revertSelectedRanges')<cr>

" LOADED
let g:loaded_gzip = 0
let g:loaded_matchparen = 0
let g:loaded_netrw = 0
let g:loaded_netrwFileHandlers = 0
let g:loaded_netrwPlugin = 0
let g:loaded_netrwSettings = 0
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
autocmd group filetype markdown set textwidth=80
nnoremap <silent> : :call VSCodeNotify('workbench.action.showCommands')<cr>
nmap gcp my vip gc `y
set nofoldenable
set nojoinspaces
set noswapfile
set notimeout
set virtualedit=block

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nnoremap <silent> <esc> :noh <bar> call clever_f#reset()<cr>
nnoremap <silent> , *``
xmap     <silent> , *``
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
set ignorecase smartcase

" SHORTCUTS
nnoremap <cr> o<esc>
nnoremap <p <ap
nnoremap >p >ap
nnoremap cp cip
nnoremap cw ciw
nnoremap cW ciW
nnoremap dp dap
nnoremap dw daw
nnoremap dW daW
nnoremap gg gg0
nnoremap gqp gqip
nnoremap gqq Vgq
nnoremap Q <c-q>
nnoremap vp vip
nnoremap Y y$
nnoremap yp my yip `y
nnoremap yw my yiw `y
nnoremap yW my yiW `y
nnoremap { {zz
nnoremap } }zz
nnoremap ; `

" SORT
nnoremap <silent> gsp my vip :sort i<cr> `y
nmap     <silent> gsi my vii :sort i<cr> `y
xnoremap <silent> gs  my :sort i<cr> `y

" SUBVERSIVE
let g:subversivePromptWithCurrent = 1
let g:subversivePreserveCursorPosition = 1
nmap s  <plug>(SubversiveSubstitute)
xmap s  <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S  <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>r <plug>(SubversiveSubstituteWordRange)ie
xmap <leader>r <plug>(SubversiveSubstituteRange)ie
xnoremap ie <esc>ggVG
onoremap ie :exe "norm! ggVG"<cr>

" WRAP & FOLD
nmap $ g$
nmap 0 g0
nmap j gj
nmap k gk
xmap $ g$
xmap 0 g0
xmap j gj
xmap k gk
