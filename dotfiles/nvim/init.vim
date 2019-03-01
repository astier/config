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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-jedi', { 'for': 'python'}
call plug#end()

" Misc
let mapleader=' '
let maplocalleader=' '
let nvi = $HOME.'/miniconda3/envs/nvi/bin/'
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1
au BufEnter * se fo-=cro
au BufWritePost * GitGutter
nnoremap <cr> o<esc>
nnoremap <silent><a-v><a-v> :e $MYVIMRC<cr>
nnoremap <silent><a-v><a-s> :setl spell<cr>
se autochdir
se tabstop=4 shiftwidth=4
se mouse=a
se nu rnu
se signcolumn=yes
se scrolloff=5
se splitbelow splitright
sil! cal repeat#se('\<Plug>vim-surround', v:count)

" Save
au FocusGained,BufEnter * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
" se autowriteall
se confirm

" Search
nnoremap <silent># *
nnoremap <silent><esc> :noh<cr><esc>
nnoremap ,r :%s//g<left><left>

" Theme
let g:enable_italic_font = 1
let g:enable_bold_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
se termguicolors

" Statuslin
se noshowmode
se laststatus=0

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
nnoremap <silent><a-J> :res +1<cr>
nnoremap <silent><a-K> :res -1<cr>
nnoremap <silent><a-L> :vert res +1<cr>
nnoremap <silent><a-H> :vert res -1<cr>
tnoremap <silent><a-J> <c-\><c-n>:res +1<cr>:star<cr>
tnoremap <silent><a-K> <c-\><c-n>:res -1<cr>:star<cr>
tnoremap <silent><a-L> <c-\><c-n>:vert res +1<cr>:star<cr>
tnoremap <silent><a-H> <c-\><c-n>:vert res -1<cr>:star<cr>

" Windows & Buffers
nnoremap <silent><a-c> :clo<cr>
tnoremap <silent><a-c> <c-\><c-n>:clo<cr>
nnoremap <silent><a-d> :Bw<cr>
tnoremap <silent><a-d> <c-\><c-n>:Bw!<cr>
nnoremap <silent><a-q> :qa<cr>
tnoremap <silent><a-q> <c-\><c-n>:qa<cr>

" Terminal
au BufEnter term://* star
au TermOpen * :setl nonu nornu scl=no | star
tnoremap ,<esc> <c-\><c-n>
nnoremap <silent><a-s> :te<cr>
tnoremap <silent><a-s> <c-\><c-n>:te<cr>
se hidden

" Goyo
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent><a-m> :Goyo<cr>
tnoremap <silent><a-m> <c-\><c-n>:Goyo<cr>:star<cr>

" ALE & Deoplete
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['isort', 'black'],
\}
" let g:ale_linters = {
"     \ 'python': ['pylint'],
"     \ 'sh': ['shellcheck'],
"     \ 'tex': ['chktex'],
" \}
let g:ale_python_black_options = '-l79'
let g:ale_python_pylint_options = '--disable=C0102,C0103,C0111,C0330,C0200,R0903,R0913,R0914,W0511 --max-line-length=79'
let g:ale_python_black_executable = nvi.'black'
let g:deoplete#enable_at_startup = 1
au! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"
nnoremap <silent><a-a>f :ALEFix<cr>
nnoremap <silent><a-a>h :LspHover<cr>
nnoremap <silent><a-a>r :LspRename<cr>
nnoremap <silent><a-a>d :LspDefinition<cr>

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
" au FileType python setl colorcolumn=80
au FileType python inoremap <silent><buffer>,d <esc>:read $DOTFILES/nvim/snippets/python/def.py<cr>:norm =ae<cr>4li
let g:python3_host_prog = nvi.'python'

" VimTex
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'zathura'
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

" LaTeX
let g:tex_flavor = 'latex'
nnoremap <silent><a-a>c :VimtexCompile<cr>
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
