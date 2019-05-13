call plug#begin('~/.local/share/nvim/plugins')
Plug '907th/vim-auto-save'
Plug 'Shougo/deoplete.nvim', { 'do': ': UpdateRemotePlugins' }
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'machakann/vim-highlightedyank'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale', { 'for': ['sh', 'tex'] }
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Leaders
let mapleader=' '
let maplocalleader=' '

" Misc
au BufWritePost * GitGutter
sil! cal repeat#se('\<Plug>vim-surround', v:count)
let g:ale_lint_on_text_changed = 'never'
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:show_spaces_that_precede_tabs=1
let g:strip_whitelines_at_eof=1

" Airline
let g:airline_theme='hybrid'
let g:airline_powerline_fonts = 1
let g:airline_section_c = '%t'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#middle_click_preserves_windows = 1

" Deoplete
let g:deoplete#enable_at_startup = 1
au! CompleteDone * if pumvisible() == 0 | pclose | endif
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Goyo
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent><a-g> :Goyo<cr>
tnoremap <silent><a-g> <c-\><c-n>:Goyo<cr>:star<cr>

" indentLine
let g:indentLine_fileTypeExclude = ['man', 'tex']
let g:indentLine_char = '▏'

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['.git', '__pycache__', 'tags']
let NERDTreeMinimalUI=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeStatusline='NERD'
nnoremap <silent><a-e> :NERDTreeToggle<cr><c-w>=
tnoremap <silent><a-e> <c-\><c-n>:NERDTreeToggle<cr><c-w>=

" Misc
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

" Colorscheme
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
se cursorline
se termguicolors

" Save
au FocusGained,BufEnter,VimResume * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
se confirm
se noswapfile

" Search & Replace
nnoremap <silent><esc> :noh<cr><esc>
nnoremap <a-r> :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <silent># *
se inccommand=nosplit

" Statusline
se laststatus=0
se statusline=\ 
se noruler
se noshowcmd
se noshowmode
se signcolumn=yes

" Terminal
au BufEnter term://* star
au TermOpen * setl nonu nornu scl=no | star
nnoremap <silent><a-t> :te<cr>
set hidden

" Brackets
inoremap {{ {}<left>
inoremap (( ()<left>
inoremap [[ []<left>
inoremap '' ''<left>
inoremap "" ""<left>

" Kill
nnoremap <silent><a-q> :qa<cr>
nnoremap <silent><a-c> :clo<cr>
nnoremap <silent><a-d> :Bd<cr>
tnoremap <silent><a-q> <c-\><c-n>:qa<cr>
tnoremap <silent><a-c> <c-\><c-n>:clo<cr>
tnoremap <silent><a-d> <c-\><c-n>:Bd!<cr>

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

" Wrap
nnoremap $ g$
nnoremap 0 g0
" nnoremap j gj
" nnoremap k gk
se breakindent linebreak
