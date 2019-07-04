call plug#begin('~/.local/share/nvim/plugins')

Plug '907th/vim-auto-save'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'junegunn/fzf.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'neoclide/coc-vimtex', { 'for': 'tex' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

call plug#end()

" LEADERS
let mapleader=' '
let maplocalleader=' '

"""""""""""
" PLUGINS "
"""""""""""

" MISC
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_node_provider = 1
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:python3_host_prog = '/bin/python'
sil! cal repeat#se('\<Plug>vim-surround', v:count)

" AUTO-SAVE
let g:auto_save = 1
let g:auto_save_silent = 1
se noswapfile

" BETTER-WHITESPACE
let g:better_whitespace_filetypes_blacklist = ['help']
let g:show_spaces_that_precede_tabs=1
let g:strip_whitelines_at_eof=1

" FZF
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>t :Tags<cr>

" VIMTEX
au FileType tex inoremap <expr><buffer> <CR> getline('.') =~ '\item\s\w' ? '<cr>\item ' : '<cr>'
let g:vimtex_compiler_progname = '/usr/bin/nvr'
let g:vimtex_view_general_viewer = 'firefox'
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

""""""""""""""""""
" VANILLA-NEOVIM "
""""""""""""""""""

" MISC
au BufEnter * se fo-=cro
au FocusGained,BufEnter,VimResume * checkt
au VimResized * wincmd =
se confirm
se fillchars+=fold:\ 
se iskeyword-=_
se mouse=a
se path-=/usr/include
se shortmess+=c
se splitbelow splitright
se tabstop=4 shiftwidth=4
nnoremap Q <nop>
nnoremap <cr> o<esc>
nnoremap <leader>s <c-z>

" COLORSCHEME
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
hi cursorline guibg=#383c4a
se cursorline
se termguicolors

" COPY & PASTE
nnoremap <a-p> "+p
inoremap <a-p> <esc>"+pa
vnoremap <leader>y "+y

" KILL
nnoremap <silent> <leader>q :qa<cr>
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <leader>d :bd<cr>
inoremap <silent> <a-q> <esc>:qa<cr>

" NAVIGATION
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <a-b> :TmuxNavigatePrevious<cr>
nnoremap <silent> <a-i> :bp<cr>
nnoremap <silent> <a-o> :bn<cr>
nnoremap <leader>w <c-w>

" PUM
se completeopt=menu,noinsert
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<C-j>"

" SEARCH & REPLACE
nnoremap <silent> <esc> :noh<cr><esc>
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gI<left><left><left>
nnoremap <leader>rr :%s///gI<left><left><left><left>
nnoremap <silent> , *``
nnoremap n nzz
nnoremap N Nzz
se ignorecase
se inccommand=nosplit
se smartcase

" STATUSLINE
se laststatus=1
se noruler
se noshowcmd
se noshowmode

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak
