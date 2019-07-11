call plug#begin('~/.local/share/nvim/plugins')

Plug '907th/vim-auto-save'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'tpope/vim-commentary'

call plug#end()

" LEADERS
let mapleader=' '
let maplocalleader=' '

" AUTOCOMMANDS
au bufenter * se fo-=cro
au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"zz" | en
au focusgained,bufenter,vimresume * checkt
au vimresized * wincmd =

" CLIPBOARD
nnoremap <c-c> "+yy
vnoremap <c-c> "+y
inoremap <c-v> <esc>"+pa
nnoremap <c-v> "+p
vnoremap <c-v> dk"+p
nnoremap <c-x> "+dd
vnoremap <c-x> "+d

" COMPLETION
fu Completion()
	let prefix_line = strpart(getline('.'), -1, col('.'))
	let prefix_word = matchstr(prefix_line, "[^ \t]*$")
	if (strlen(prefix_word)==0)
		retu "\<tab>"
	elsei (match(prefix_word, '\/') != -1)
		retu "\<c-x>\<c-f>"
	el
		retu "\<c-x>\<c-n>"
	en
endf
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
inoremap <expr> <esc> pumvisible() ? "\<c-e>" : "\<esc>"
inoremap <expr> <s-tab> pumvisible() ? "\<C-p>" : Completion()
inoremap <expr> <tab> pumvisible() ? "\<C-n>" : Completion()
se completeopt=menuone,noinsert
se shortmess+=c

" COLORSCHEME
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
hi cursorline guibg=#383c4a
hi gitgutterdelete guifg=#CC6666
se cursorline
se termguicolors

" KILL
nnoremap <leader>s <c-z>
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <leader>d :bd<cr>
nnoremap <silent> <leader>q :qa<cr>

" LOADED
let g:loaded_gzip = 1
let g:loaded_matchparen = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_node_provider = 1
let g:loaded_python3_provider = 1
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_tar      = 1
let g:loaded_tarPlugin= 1
let g:loaded_zip = 1
let g:loaded_zipPlugin= 1

" MAPPINGS
nnoremap <cr> o<esc>
nnoremap g<cr> O<esc>
nnoremap <leader>w <c-w>
nnoremap <silent> gs vip:sort<cr>
vnoremap <silent> gs :sort<cr>
nnoremap Q <nop>

" NAVIGATION
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <a-r> :bn<cr>
nnoremap <c-j> 4<c-e>
nnoremap <c-k> 4<c-y>
nnoremap <leader>b :ls<cr>:b<space>
nnoremap <leader>f :fin<space>

" GitGutter
au bufwritepost * GitGutter
let g:auto_save = 1
let g:auto_save_silent = 1
se noswapfile
se signcolumn=yes

" SETTINGS
se confirm
se fillchars+=eob:\ 
se fillchars+=fold:\ 
se mouse=a
se path+=**
se path-=/usr/include
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
