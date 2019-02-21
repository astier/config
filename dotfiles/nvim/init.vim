" Plugins
call plug#begin('~/.local/share/nvim/plugins')
Plug '907th/vim-auto-save'
Plug 'Shougo/deoplete.nvim', { 'do': ': UpdateRemotePlugins' , 'for': ['python', 'sh', 'tex', 'vim']}
Plug 'Shougo/neco-vim', {'for': 'vim'}
Plug 'airblade/vim-gitgutter'
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
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine', { 'for': 'python'}
Plug 'zchee/deoplete-jedi', { 'for': 'python'}
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Misc
let mapleader=' '
let maplocalleader=' '
let nvi = $HOME.'/miniconda3/envs/nvi/bin/'
au BufEnter * se fo-=cro
nnoremap <cr> o<esc>
nnoremap <silent>,, :e $MYVIMRC<cr>
se autochdir
se tabstop=4 shiftwidth=4
se mouse=a
se number relativenumber
se signcolumn=yes
se scrolloff=5
se splitbelow splitright
" se title titlestring=nvim
se updatetime=100
silent! call repeat#se('\<Plug>vim-surround', v:count)

" Save
au FocusGained,BufEnter * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
se autowriteall
se confirm

" Search
nnoremap <silent># *<s-n>
nnoremap <silent><esc> :noh<cr><esc>
nnoremap ,r :%s//g<left><left>

" Theme
let g:enable_italic_font = 1
let g:enable_bold_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
se termguicolors

" Airline
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#middle_click_preserves_windows = 1
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#wordcount#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%t'
let g:airline_theme='angr'
se noshowmode

" Brackets
inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>

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
tnoremap <silent>,d <c-\><c-n>:Bw!<cr>
nnoremap <silent>,q :xa<cr>
tnoremap <silent>,q <c-\><c-n>:xa<cr>

" Terminal
au BufEnter term://* star
au TermOpen * :setl nonu nornu scl=no | star
tnoremap ,<esc> <c-\><c-n>
nnoremap <silent>,t :te<cr>
tnoremap <silent>,t <c-\><c-n>:te<cr>
se hidden

" Goyo
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent>,f :Goyo<cr>
tnoremap <silent>,f <c-\><c-n>:Goyo<cr>:star<cr>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['.git', '__pycache__', 'tags']
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeStatusline='NERDTree'
nnoremap <silent>,e :NERDTreeToggle<cr>
tnoremap <silent>,e <c-\><c-n>:NERDTreeToggle<cr>

" ALE & Deoplete
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['isort', 'black', 'remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'sh': ['shellcheck'],
    \ 'tex': ['chktex'],
\}
let g:ale_python_black_options = '-l79'
let g:ale_python_pylint_options = '--disable=C0102,C0103,C0111,C0330,C0200,R0903,R0913,R0914,W0511 --max-line-length=79'
let g:ale_python_black_executable = nvi.'black'
let g:deoplete#enable_at_startup = 1
au! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"
nnoremap <silent>,af :ALEFix<cr>
nnoremap <silent>,ah :LspHover<cr>
nnoremap <silent>,ar :LspRename<cr>
nnoremap <silent>,ad :LspDefinition<cr>

" LSP
let g:lsp_diagnostics_enabled = 0
let g:lsp_preview_keep_focus = 0
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
\ })
endif

" Python
au FileType python setl colorcolumn=80
au FileType python inoremap <silent><buffer>,d <esc>:read $DOTFILES/nvim/snippets/python/def.py<cr>:norm =ae<cr>4li
let g:python3_host_prog = nvi.'python'

" VimTex
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : 'tex',
    \ 'callback' : 1,
    \ 'continuous' : 0,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode'
    \ ],
\}

" LaTeX
let g:tex_flavor = 'latex'
let g:indentLine_fileTypeExclude = ['tex']
nnoremap <silent>,ac :VimtexCompile<cr>
nnoremap <silent>,av :VimtexView<cr>
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
