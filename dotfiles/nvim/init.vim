" Plugins
call plug#begin('~/.local/share/nvim/plugins')
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" Misc
au bufenter * set fo-=cro
let mapleader=','
nnoremap <leader>r :%s//g<left><left>
nnoremap <cr> o<esc>
nnoremap <silent><a-h> :noh<cr>
set autochdir
set confirm
set cursorline
set mouse=a
set number relativenumber
set splitright splitbelow
set title titlestring=NVIM\ -\ %t

" Navigation
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l

" Resize
au vimresized * wincmd =
nnoremap <silent><a-.> :res +1<cr>
nnoremap <silent><a-,> :res -1<cr>
nnoremap <silent><a-+> :vertical res +1<cr>
nnoremap <silent><a--> :vertical res -1<cr>
tnoremap <silent><a-.> <c-\><c-n>:res +1<cr>:startinsert<cr>
tnoremap <silent><a-,> <c-\><c-n>:res -1<cr>:startinsert<cr>
tnoremap <silent><a-+> <c-\><c-n>:vertical res +1<cr>:startinsert<cr>
tnoremap <silent><a--> <c-\><c-n>:vertical res -1<cr>:startinsert<cr>

" Theme
colorscheme hybrid_material
let g:airline_theme='hybrid'
let g:airline_powerline_fonts = 1
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:loaded_matchparen=1
set noshowmode
set termguicolors

" Vimrc
au bufwritepost $MYVIMRC :so $MYVIMRC
noremap <silent><space>c :edit $MYVIMRC<cr>

" Windows
nnoremap <leader>s <c-w>s
nnoremap <leader>v <c-w>v
nnoremap <leader>c <c-w>c
tnoremap <leader>s <c-\><c-n><c-w>s
tnoremap <leader>v <c-\><c-n><c-w>v
tnoremap <leader>c <c-\><c-n><c-w>c

" Terminal
au termopen * :set nonu nornu | startinsert
au bufenter * if &buftype == 'terminal' | startinsert | endif
nnoremap <silent><leader>ts :sp<cr>:te<cr>
nnoremap <silent><leader>tv :vsp<cr>:te<cr>
tnoremap <silent><leader>ts <c-\><c-n>:sp<cr>:te<cr>
tnoremap <silent><leader>tv <c-\><c-n>:vsp<cr>:te<cr>
tnoremap <leader><esc> <c-\><c-n>

" Goyo
nnoremap <silent><a-f> :Goyo<cr>
tnoremap <silent><a-f> <c-\><c-n>:Goyo<cr>:startinsert<cr>

" NERDTree
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent><a-e> :NERDTreeFocus<cr>
tnoremap <silent><a-e> <c-\><c-n>:NERDTreeFocus<cr>
