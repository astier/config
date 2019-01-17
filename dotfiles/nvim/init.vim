" Plugins
call plug#begin('~/.local/share/nvim/plugins')
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lervag/vimtex'
Plug 'michaeljsmith/vim-indent-object'
Plug 'moll/vim-bbye'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
call plug#end()

" Misc
let mapleader=' '
let maplocalleader=' '
au BufEnter * set fo-=cro
nnoremap <cr> o<esc>
nnoremap <silent>,, :e $MYVIMRC<cr>
set autochdir
set breakindent linebreak
set expandtab shiftwidth=4
set foldlevel=100
set mouse=a
set number relativenumber
set splitbelow splitright
set title titlestring=NVIM\ -\ %t
set updatetime=100

" Save
au FocusGained,BufEnter * checkt
au CursorHold * up
set autowriteall
set confirm

" Search
nnoremap * #
nnoremap # *
nnoremap <silent><esc> :noh<cr><esc>
nnoremap ,r :%s//g<left><left>

" Theme & Airline
colorscheme hybrid_material
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#excludes = ['bash$']
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#middle_click_preserves_windows = 1
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#wordcount#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%t'
let g:airline_theme='hybrid'
let g:enable_italic_font = 1
set cursorline
set noshowmode
set termguicolors

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
nnoremap <silent>,c :clo<cr>
tnoremap <silent>,c <c-\><c-n>:clo<cr>
nnoremap <silent>,d :Bw<cr>
nnoremap <silent>,q :xa<cr>
tnoremap <silent>,q <c-\><c-n>:xa<cr>

" Terminal
au BufEnter term://* star
au TermOpen * :set nonu nornu | star
nnoremap <silent>,t :bo sp<cr>:te<cr>
tnoremap <silent>,t <c-\><c-n>:vs<cr>:te<cr>
tnoremap ,<esc> <c-\><c-n>

" Goyo & Limelight
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

" Python
au FileType python setlocal colorcolumn=80
au FileType python set foldmethod=indent
let g:ale_fixers = {'python': ['autopep8']}
let g:ale_linters = {'python': ['pyls', 'pylint']}
let g:python3_host_prog = '~/miniconda3/bin/python'
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:lsp_preview_keep_focus = 0
au! CompleteDone * if pumvisible() == 0 | pclose | endif
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
nnoremap <silent>gh :LspHover<cr>
nnoremap <silent>,af :ALEFix<cr>
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"

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
