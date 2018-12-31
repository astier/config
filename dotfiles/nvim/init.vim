" Plugins
call plug#begin('~/.local/share/nvim/plugins')
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" General
let mapleader=' '
let g:loaded_matchparen=1
let g:airline_theme='luna'
set autochdir
set confirm
set expandtab
set ignorecase
set laststatus=1
set mouse=a
set scrolloff=100
set shiftwidth=4
set smartcase
set softtabstop=4
set splitright
set splitbelow
set tabstop=4
set title
set titlestring=NVIM\ -\ %t

" Vimrc
au bufwritepost init.vim :so $MYVIMRC
noremap <leader>c :edit $MYVIMRC<cr>

" Resize
au vimresized * wincmd =
nnoremap + :res +1<cr>
nnoremap - :res -1<cr>
nnoremap <a-+> :vertical res +1<cr>
nnoremap <a--> :vertical res -1<cr>
tnoremap + :res +1<cr>
tnoremap - :res -1<cr>
tnoremap <a-+> :vertical res +1<cr>
tnoremap <a--> :vertical res -1<cr>

" Windows
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l
nnoremap <a-c> <c-w>c
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l
tnoremap <a-c> <c-\><c-n><c-w>c

" Terminal
au termopen * :set nonu nornu | :startinsert
au bufenter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <leader>ts :sp<cr>:term<cr>
nnoremap <leader>tv :vsp<cr>:term<cr>
tnoremap ,<esc> <c-\><c-n>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <a-f> :NERDTreeFocus<cr>
tnoremap <a-f> <c-\><c-n>:NERDTreeFocus<cr>

" Misc
au bufenter * set fo-=cro
noremap <leader>h :noh<cr>
noremap <leader>s :%s//g<left><left>
nnoremap <cr> o<esc>
