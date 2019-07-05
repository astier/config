call plug#begin('~/.local/share/nvim/plugins')
Plug '907th/vim-auto-save'
Plug 'airblade/vim-gitgutter'
Plug 'ajh17/VimCompletesMe'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'tpope/vim-commentary'
call plug#end()

let mapleader=' '
let maplocalleader=' '

" AUTOCOMMANDS
au BufEnter * se fo-=cro
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif
au BufWritePost * GitGutter
au FocusGained,BufEnter,VimResume * checkt
au VimResized * wincmd =

" COLORSCHEME
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
hi cursorline guibg=#383c4a
hi gitgutterdelete guifg=#CC6666
se cursorline
se termguicolors

" KILL
nnoremap <silent> <leader>q :qa<cr>
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <leader>d :bd<cr>

" MAPPINGS
nnoremap Q <nop>
nnoremap <cr> o<esc>
nnoremap <leader>s <c-z>
nnoremap <leader>w <c-w>
nnoremap <leader>p "+p
vnoremap <leader>y "+y

" NAVIGATION
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <a-b> :TmuxNavigatePrevious<cr>
nnoremap <silent> <a-i> :bp<cr>
nnoremap <silent> <a-o> :bn<cr>

" PROVIDERS
let g:loaded_node_provider = 1
let g:loaded_python_provider = 1
let g:loaded_python3_provider = 1
let g:loaded_ruby_provider = 1

" SAVE
let g:auto_save = 1
let g:auto_save_silent = 1
se noswapfile
se confirm

" SETTINGS
se completeopt=menuone,noinsert
se fillchars+=fold:\ 
se iskeyword-=_
se mouse=a
se path-=/usr/include
se path+=**
se shortmess+=c
se splitbelow splitright
se tabstop=4 shiftwidth=4

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

" STANDARD-PLUGINS
let g:loaded_gzip = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_tar      = 1
let g:loaded_tarPlugin= 1
let g:loaded_zip = 1
let g:loaded_zipPlugin= 1

" STATUSLINE
se laststatus=1
se noruler
se noshowcmd
se noshowmode
se signcolumn=yes

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak
