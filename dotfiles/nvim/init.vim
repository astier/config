" Plugins
call plug#begin('~/.local/share/nvim/plugins')
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/goyo.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'michaeljsmith/vim-indent-object'
Plug 'moll/vim-bbye'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Misc
let mapleader=' '
let g:python3_host_prog = '~/miniconda3/bin/python'
let maplocalleader=' '
au BufEnter * se fo-=cro
au FocusGained,BufEnter * checkt
nnoremap <cr> o<esc>
nnoremap <silent>,, :e $MYVIMRC<cr>
se autochdir
se expandtab shiftwidth=4
se mouse=a
se number relativenumber
se scrolloff=5
se splitbelow splitright
se title titlestring=NVIM\ -\ %t
se updatetime=100
silent! call repeat#se("\<Plug>vim-surround", v:count)

" Save
nnoremap <silent>,s :wa<cr>
se autowriteall
se confirm
se hidden

" Search
nnoremap <silent># *<s-n>
nnoremap <silent><esc> :noh<cr><esc>
nnoremap ,r :%s//g<left><left>

" Theme & Airline
colorscheme hybrid_material
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#middle_click_preserves_windows = 1
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#wordcount#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%t'
let g:airline_theme='hybrid'
let g:enable_italic_font = 1
se cursorline
se noshowmode
se termguicolors

" Brackets
inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>

" Navigation
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l
nnoremap <silent><a-i> :bp<cr>
nnoremap <silent><a-o> :bn<cr>
tnoremap <silent><a-i> <c-\><c-n>:bp<cr>
tnoremap <silent><a-o> <c-\><c-n>:bn<cr>

" Wrap
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap 0 g0
se breakindent linebreak

" Resize
nnoremap <silent><a-.> :res +1<cr>
nnoremap <silent><a-,> :res -1<cr>
nnoremap <silent><a-+> :vert res +1<cr>
nnoremap <silent><a--> :vert res -1<cr>
tnoremap <silent><a-.> <c-\><c-n>:res +1<cr>:star<cr>
tnoremap <silent><a-,> <c-\><c-n>:res -1<cr>:star<cr>
tnoremap <silent><a-+> <c-\><c-n>:vert res +1<cr>:star<cr>
tnoremap <silent><a--> <c-\><c-n>:vert res -1<cr>:star<cr>

" Windows & Buffers
nnoremap <silent>,c :clo<cr>
tnoremap <silent>,c <c-\><c-n>:clo<cr>
nnoremap <silent>,d :Bw<cr>
tnoremap <silent>,d <c-\><c-n>:Bw<cr>
nnoremap <silent>,q :xa<cr>
tnoremap <silent>,q <c-\><c-n>:xa<cr>

" Terminal
au BufEnter term://* star
au TermOpen * :se nonu nornu | star
tnoremap ,<esc> <c-\><c-n>
nnoremap <silent>,tt :te<cr>
tnoremap <silent>,tt <c-\><c-n>:te<cr>
nnoremap <silent>,tv :vs<cr>:te<cr>
tnoremap <silent>,tv <c-\><c-n>:vs<cr>:te<cr>
nnoremap <silent>,ts :sp<cr>:te<cr>
tnoremap <silent>,ts <c-\><c-n>:sp<cr>:te<cr>
nnoremap <silent>,tb :bo sp<cr>:te<cr>
tnoremap <silent>,tb <c-\><c-n>:bo sp<cr>:te<cr>
tnoremap <silent>,t <c-\><c-n>:vs<cr>:te<cr>

" Goyo
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent>,f :Goyo<cr>
tnoremap <silent>,f <c-\><c-n>:Goyo<cr>:star<cr>

" NERDTree
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['__pycache__', '.git']
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeStatusline='NERDTree'
nnoremap <silent>,e :NERDTreeToggle<cr>
tnoremap <silent>,e <c-\><c-n>:NERDTreeToggle<cr>

" LaTeX
let g:tex_flavor = 'latex'
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : 'tex',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode'
    \ ],
\}
au FileType tex inoremap <expr><buffer><CR> getline('.') =~ '\item\s\w' ? '<cr>\item ' : '<cr>'
au FileType tex nnoremap <silent><buffer>,j /\~<cr>s
au FileType tex inoremap <silent><buffer>,j <esc>/\~<cr>s
au FileType tex inoremap <silent><buffer>,a <esc>:-1read $DOTFILES/nvim/snippets/latex/article.tex<cr>7j7ls
au FileType tex inoremap <silent><buffer>,e <esc>:read $DOTFILES/nvim/snippets/latex/enumerate.tex<cr>:norm =ae<cr>j9la
au FileType tex inoremap <silent><buffer>,i <esc>:read $DOTFILES/nvim/snippets/latex/itemize.tex<cr>:norm =ae<cr>j9la
au FileType tex inoremap <silent><buffer>,sa \section{}<left>
au FileType tex inoremap <silent><buffer>,sb \subsection{}<left>
au FileType tex inoremap <silent><buffer>,sc \subsubsection{}<left>
au FileType tex inoremap $ $$<left>
