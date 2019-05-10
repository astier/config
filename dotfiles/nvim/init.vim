call plug#begin('~/.local/share/nvim/plugins')
Plug '907th/vim-auto-save'
Plug 'Shougo/deoplete.nvim', { 'do': ': UpdateRemotePlugins' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'prabirshrestha/async.vim', { 'for': 'python' }
Plug 'prabirshrestha/vim-lsp', { 'for': 'python' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', { 'for': ['python', 'sh', 'tex'] }
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
call plug#end()

" Leaders
let mapleader=' '
let maplocalleader=' '

" Misc
au BufEnter * se fo-=cro
nnoremap <a-s> <c-z>
se autochdir
se mouse=a
se tabstop=4 shiftwidth=4
nnoremap <cr> o<esc>
nnoremap <a-cr> O<esc>
nnoremap <a-p> "+p
vnoremap <a-y> "+y

" Search & Replace
nnoremap <silent><esc> :noh<cr><esc>
nnoremap <a-r> :%s///g<left><left>
nnoremap <silent># *

" Save
au FocusGained,BufEnter,VimResume * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
se confirm
se noswapfile

" Colorscheme
let g:enable_italic_font = 1
let g:enable_bold_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
se termguicolors

" Statusline
se laststatus=0
se statusline=\ 
se noruler
se noshowcmd
se noshowmode
se signcolumn=yes

" Brackets
inoremap {{ {}<left>
inoremap (( ()<left>
inoremap [[ []<left>
inoremap '' ''<left>
inoremap "" ""<left>

" Navigation
nnoremap <a-w> <c-w>
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

" Resize
au VimResized * wincmd =
nnoremap <silent><a-J> :res +1<cr>
nnoremap <silent><a-K> :res -1<cr>
nnoremap <silent><a-L> :vert res +1<cr>
nnoremap <silent><a-H> :vert res -1<cr>
tnoremap <silent><a-J> <c-\><c-n>:res +1<cr>:star<cr>
tnoremap <silent><a-K> <c-\><c-n>:res -1<cr>:star<cr>
tnoremap <silent><a-L> <c-\><c-n>:vert res +1<cr>:star<cr>
tnoremap <silent><a-H> <c-\><c-n>:vert res -1<cr>:star<cr>
se splitbelow splitright

" Kill
nnoremap <silent><a-q> :qa<cr>
nnoremap <silent><a-c> :clo<cr>
nnoremap <silent><a-d><a-d> :Bw<cr>:clo<cr>
nnoremap <silent><a-d><a-c> :Bw<cr>:clo<cr>
tnoremap <silent><a-q> <c-\><c-n>:qa<cr>
tnoremap <silent><a-c> <c-\><c-n>:clo<cr>
tnoremap <silent><a-d><a-d> <c-\><c-n>:Bw!<cr>:clo<cr>
tnoremap <silent><a-d><a-c> <c-\><c-n>:Bw!<cr>:clo<cr>

" Wrap
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak

" Terminal
au BufEnter term://* star
au TermOpen * setl nonu nornu scl=no | star
nnoremap <silent><a-t> :te<cr>
set hidden

" Plugins
au BufWritePost * GitGutter
sil! cal repeat#se('\<Plug>vim-surround', v:count)
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:show_spaces_that_precede_tabs=1
let g:strip_whitelines_at_eof=1

" Goyo
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent><a-g> :Goyo<cr>
tnoremap <silent><a-g> <c-\><c-n>:Goyo<cr>:star<cr>

" ALE
let g:ale_fixers = {
	\ '*': ['remove_trailing_lines', 'trim_whitespace'],
	\ 'python': ['isort', 'black'],
\}
let g:ale_python_black_options = '-l79'
let g:ale_python_pylint_options = '--disable=C0102,C0103,C0111,C0330,C0200,R0903,R0913,R0914,W0511 --max-line-length=79'
let g:ale_lint_on_text_changed = 'never'

" Deoplete
let g:deoplete#enable_at_startup = 1
au! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"

" LSP
let g:lsp_diagnostics_enabled = 0
let g:lsp_preview_keep_focus = 0
if executable('pyls')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'pyls',
		\ 'cmd': {server_info->['pyls']},
		\ 'whitelist': ['python'],
\})
endif

" Python
let g:loaded_python_provider = 1
let g:python3_host_prog = '/bin/python'
au FileType python inoremap <silent><buffer><a-b> breakpoint()<esc>
au FileType python inoremap <silent><buffer><a-d> <esc>:read $DOTFILES/nvim/snippets/python/def.py<cr>:norm =ae<cr>4li

" VimTex
let g:vimtex_compiler_progname = '/bin/nvr'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
	\ 'backend' : 'nvim',
	\ 'background' : 1,
	\ 'build_dir' : 'tex',
	\ 'callback' : 1,
	\ 'continuous' : 0,
	\ 'executable' : 'latexmk',
	\ 'options' : [
	\	'-verbose',
	\	'-file-line-error',
	\	'-synctex=1',
	\	'-interaction=nonstopmode'
	\ ],
\}

" LaTeX
let g:tex_flavor = 'latex'
au FileType tex inoremap <expr><buffer><CR> getline('.') =~ '\item\s\w' ? '<cr>\item ' : '<cr>'
au FileType tex nnoremap <silent><buffer>,j /\~<cr>s
au FileType tex inoremap <silent><buffer>,j <esc>/\~<cr>s
au FileType tex inoremap <silent><buffer>,e <esc>:read $DOTFILES/nvim/snippets/latex/enumerate.tex<cr>:norm =ae<cr>j10li
au FileType tex inoremap <silent><buffer>,i <esc>:read $DOTFILES/nvim/snippets/latex/itemize.tex<cr>:norm =ae<cr>j10li
au FileType tex inoremap <silent><buffer>,f <esc>:read $DOTFILES/nvim/snippets/latex/frame.tex<cr>:norm =ae<cr>j16li
au FileType tex inoremap <silent><buffer>,sa \section{}<left>
au FileType tex inoremap <silent><buffer>,sb \subsection{}<left>
au FileType tex inoremap <silent><buffer>,sc \subsubsection{}<left>
