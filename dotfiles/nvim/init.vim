call plug#begin('~/.local/share/nvim/plugins')
Plug '907th/vim-auto-save'
Plug 'Shougo/deoplete.nvim', { 'do': ': UpdateRemotePlugins' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'airblade/vim-gitgutter'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', { 'for': ['sh', 'tex'] }
call plug#end()

" Leaders
let mapleader=' '
let maplocalleader=' '

" Plugins-Misc
au BufWritePost * GitGutter
sil! cal repeat#se('\<Plug>vim-surround', v:count)
let g:ale_lint_on_text_changed = 'never'
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:show_spaces_that_precede_tabs=1
let g:strip_whitelines_at_eof=1

" Deoplete
let g:deoplete#enable_at_startup = 1
au! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"

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

" Terminal
au BufEnter term://* star
au TermOpen * setl nonu nornu scl=no | star
nnoremap <silent><a-t> :te<cr>
set hidden

" Settings-Misc
au BufEnter * se fo-=cro
let g:loaded_python_provider = 1
let g:python3_host_prog = '/bin/python'
" se autochdir
se mouse=a
se tabstop=4 shiftwidth=4
nnoremap Q <nop>
nnoremap <cr> o<esc>
nnoremap <a-cr> O<esc>
nnoremap <a-p> "+p
vnoremap <a-y> "+y
nnoremap <a-s> <c-z>

" Colorscheme
let g:enable_italic_font = 1
" let g:enable_bold_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
" se termguicolors

" Statusline
se laststatus=0
se statusline=\ 
se noruler
se noshowcmd
se noshowmode
se signcolumn=yes

" Search & Replace
nnoremap <silent><esc> :noh<cr><esc>
nnoremap <a-r> :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <silent># *
se inccommand=nosplit

" Save
au FocusGained,BufEnter,VimResume * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
se confirm
se noswapfile

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
nnoremap <silent><a-d> :bd<cr>
tnoremap <silent><a-q> <c-\><c-n>:qa<cr>
tnoremap <silent><a-c> <c-\><c-n>:clo<cr>
tnoremap <silent><a-d> <c-\><c-n>:bd!<cr>

" Wrap
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak

" LaTeX-Snippets
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
