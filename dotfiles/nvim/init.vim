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
let mapleader=' '
nnoremap <leader>r :%s//g<left><left>
nnoremap <cr> o<esc>
nnoremap <silent>,h :noh<cr>
set autochdir
set autowriteall
set confirm
set cursorline
set mouse=a
set number relativenumber
set splitright splitbelow
set title titlestring=NVIM\ -\ %t

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
nnoremap <silent><leader>c :edit $MYVIMRC<cr>

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

" Windows
nnoremap ,w <c-w>v
nnoremap ,c <c-w>c
tnoremap ,c <c-\><c-n><c-w>c

" Terminal
au bufenter * if &buftype == 'terminal' | startinsert | endif
au termopen * :set nonu nornu | startinsert
nnoremap <silent>,t <c-w>s:te<cr>
tnoremap <silent>,t <c-\><c-n><c-w>v:te<cr>
tnoremap ,<esc> <c-\><c-n>

" Goyo
nnoremap <silent>,f :Goyo<cr>
tnoremap <silent>,f <c-\><c-n>:Goyo<cr>:startinsert<cr>

" NERDTree
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent>,e :NERDTreeToggle<cr>
tnoremap <silent>,e <c-\><c-n>:NERDTreeToggle<cr>
