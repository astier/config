" Plugins
call plug#begin('~/.local/share/nvim/plugins')
Plug '907th/vim-auto-save'
Plug 'Shougo/deoplete.nvim', { 'do': ': UpdateRemotePlugins' , 'for': ['python', 'tex']}
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/goyo.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'moll/vim-bbye'
Plug 'prabirshrestha/async.vim', { 'for': 'python'}
Plug 'prabirshrestha/vim-lsp', { 'for': 'python'}
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale', {'for': ['python', 'tex']}
Plug 'Yggdroot/indentLine'
Plug 'zchee/deoplete-jedi', { 'for': 'python'}
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Misc
let mapleader=' '
let maplocalleader=' '
au BufEnter * se fo-=cro
nnoremap <cr> o<esc>
nnoremap <silent>,, :e $MYVIMRC<cr>
se autochdir
se expandtab shiftwidth=4
se mouse=a
se number relativenumber
se signcolumn=yes
se scrolloff=5
se splitbelow splitright
se title titlestring=%t
se updatetime=100
silent! call repeat#se('\<Plug>vim-surround', v:count)

" Save
au FocusGained,BufEnter * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
" nnoremap <silent>,s :wa<cr>
" se autowriteall
" se confirm

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
inoremap ' ''<left>
inoremap "" ""<left>
inoremap "<cr> "

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
nnoremap <silent>,t :te<cr>
tnoremap <silent>,t <c-\><c-n>:te<cr>
se hidden

" Goyo
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent>,f :Goyo<cr>
tnoremap <silent>,f <c-\><c-n>:Goyo<cr>:star<cr>

" NERDTree
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['.git', '__pycache__', 'tags']
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeStatusline='NERDTree'
nnoremap <silent>,e :NERDTreeToggle<cr>
tnoremap <silent>,e <c-\><c-n>:NERDTreeToggle<cr>

" ALE & Deoplete
let g:ale_fixers = {'python': ['autopep8', 'isort']}
let g:ale_linters = {'python': ['pyls', 'pylint']}
let g:deoplete#enable_at_startup = 1
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"
nnoremap <silent>,af :ALEFix<cr>
nnoremap <silent>,ah :LspHover<cr>
nnoremap <silent>,ar :LspRename<cr>

" Python
au FileType python setl colorcolumn=80
au FileType python setl foldmethod=indent
au FileType python setl foldlevel=99
au! CompleteDone * if pumvisible() == 0 | pclose | endif
let g:lsp_preview_keep_focus = 0
let g:python3_host_prog = $HOME.'/miniconda3/bin/python'
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

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
au FileType tex inoremap <silent><buffer>,b <esc>:-1read $DOTFILES/nvim/snippets/latex/beamer.tex<cr>6j7ls
au FileType tex inoremap <silent><buffer>,e <esc>:read $DOTFILES/nvim/snippets/latex/enumerate.tex<cr>:norm =ae<cr>j10li
au FileType tex inoremap <silent><buffer>,i <esc>:read $DOTFILES/nvim/snippets/latex/itemize.tex<cr>:norm =ae<cr>j10li
au FileType tex inoremap <silent><buffer>,f <esc>:read $DOTFILES/nvim/snippets/latex/frame.tex<cr>:norm =ae<cr>j16li
au FileType tex inoremap <silent><buffer>,sa \section{}<left>
au FileType tex inoremap <silent><buffer>,sb \subsection{}<left>
au FileType tex inoremap <silent><buffer>,sc \subsubsection{}<left>
au FileType tex inoremap $ $$<left>
