call plug#begin('~/.local/share/nvim/plugins')
Plug '907th/vim-auto-save'
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/vim-gitbranch'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'machakann/vim-highlightedyank'
Plug 'moll/vim-bbye'
Plug 'neoclide/coc-neco', { 'for': 'vim' }
Plug 'neoclide/coc-vimtex', { 'for': 'tex' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale', { 'for': ['sh', 'tex'] }
call plug#end()

" LEADERS
let mapleader=' '
let maplocalleader=' '

" MISC
au BufWritePost * GitGutter
sil! cal repeat#se('\<Plug>vim-surround', v:count)
let g:AutoPairsFlyMode = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:show_spaces_that_precede_tabs=1
let g:strip_whitelines_at_eof=1

" AIRLINE
let g:airline_theme='hybrid'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#middle_click_preserves_windows = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_section_a = '%{gitbranch#name()}'
let g:airline_section_c = '%t'
let g:airline_section_z = '%l:%c'

" ALE
let g:ale_fixers = {
	\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_lint_on_text_changed = 'never'

" COC
set nowritebackup
set shortmess+=c
" Trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Confirm completion
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Manage Completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]	=~# '\s'
endfunction
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" GOYO
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent><a-g> :Goyo<cr>
tnoremap <silent><a-g> <c-\><c-n>:Goyo<cr>:star<cr>

" INDENTLINE
let g:indentLine_fileTypeExclude = ['man', 'tex']
let g:indentLine_char = '▏'

" NERDTREE
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['.git', '__pycache__', 'tags']
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeStatusline='NERDTree'
nnoremap <silent><a-e> :NERDTreeToggle<cr><c-w>=
tnoremap <silent><a-e> <c-\><c-n>:NERDTreeToggle<cr><c-w>=

" VIMTEX
let g:vimtex_compiler_progname = '/usr/bin/nvr'
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

" MISC
au BufEnter * se fo-=cro
let g:loaded_python_provider = 1
let g:python3_host_prog = '/bin/python'
se autochdir
se mouse=a
se tabstop=4 shiftwidth=4
nnoremap Q <nop>
nnoremap <cr> o<esc>
nnoremap <a-cr> O<esc>
nnoremap <a-p> "+p
vnoremap <a-y> "+y
nnoremap <a-s> <c-z>

" COLORSCHEME
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
se termguicolors
" hi! vertsplit gui=standout
" set fillchars+=vert:\ 

" SAVE
au FocusGained,BufEnter,VimResume * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
se confirm
se noswapfile

" SEARCH & REPLACE
nnoremap <silent><esc> :noh<cr><esc>
nnoremap <a-r> :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <silent># *
se inccommand=nosplit

" STATUSLINE
se laststatus=0
se statusline=\ 
se noruler
se noshowcmd
se noshowmode
se signcolumn=yes

" TERMINAL
au BufEnter term://* star
au TermOpen * setl nonu nornu scl=no | star
nnoremap <silent><a-t> :te<cr>
set hidden

" KILL
nnoremap <silent><a-q> :qa<cr>
nnoremap <silent><a-c> :clo<cr>
nnoremap <silent><a-d> :Bd<cr>
tnoremap <silent><a-q> <c-\><c-n>:qa<cr>
tnoremap <silent><a-c> <c-\><c-n>:clo<cr>
tnoremap <silent><a-d> <c-\><c-n>:Bd!<cr>
inoremap <silent><a-q> <esc>:qa<cr>

" NAVIGATION
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

" RESIZE
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

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak

" LATEX
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
