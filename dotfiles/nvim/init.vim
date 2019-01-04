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
nnoremap ,r :%s//g<left><left>
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

" Vimrc
au bufwritepost $MYVIMRC :so $MYVIMRC
nnoremap <silent>,, :e $MYVIMRC<cr>

" Theme
colorscheme hybrid_material
let g:airline_theme='hybrid'
let g:airline_powerline_fonts = 1
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:loaded_matchparen=1
set noshowmode
set termguicolors

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
nnoremap <silent><a-.> :res +1<cr>
nnoremap <silent><a-,> :res -1<cr>
nnoremap <silent><a-+> :vert res +1<cr>
nnoremap <silent><a--> :vert res -1<cr>
tnoremap <silent><a-.> <c-\><c-n>:res +1<cr>:star<cr>
tnoremap <silent><a-,> <c-\><c-n>:res -1<cr>:star<cr>
tnoremap <silent><a-+> <c-\><c-n>:vert res +1<cr>:star<cr>
tnoremap <silent><a--> <c-\><c-n>:vert res -1<cr>:star<cr>

" Windows
nnoremap ,w :vsp<cr>
nnoremap ,c :clo<cr>
tnoremap ,c <c-\><c-n>:clo<cr>

" Terminal
au bufenter * if &buftype == 'terminal' | star | endif
au termopen * :set nonu nornu | star
nnoremap <silent>,t :bo sp<cr>:te<cr>
tnoremap <silent>,t <c-\><c-n>:vsp<cr>:te<cr>
tnoremap ,<esc> <c-\><c-n>

" Bbye
nnoremap ,qw :Bw<cr>
nnoremap ,qa :bufdo :Bw<cr>

" Git-Gutter
set updatetime=1000

" Goyo
nnoremap <silent>,f :Goyo<cr>
tnoremap <silent>,f <c-\><c-n>:Goyo<cr>:star<cr>

" NERDTree
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent>,e :NERDTreeToggle<cr>
tnoremap <silent>,e <c-\><c-n>:NERDTreeToggle<cr>
