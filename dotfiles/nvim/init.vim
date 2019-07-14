call plug#begin('~/.local/share/nvim/plugins')

Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator', { 'on': [ 'TmuxNavigateDown', 'TmuxNavigateLeft', 'TmuxNavigateRight', 'TmuxNavigateUp' ] }
Plug 'cohama/lexima.vim'
Plug 'junegunn/fzf.vim', { 'on': [ 'Buffers', 'Files', 'Tags' ] }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale', { 'for': [ 'sh', 'tex', 'zsh' ] }

call plug#end()

" LEADERS
let mapleader=' '
let maplocalleader=' '

" ALE
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%][%severity%][%code%] %s'
let g:ale_sh_shfmt_options = '-ci -sr -p -s'
let g:ale_fixers = {
	\ '*': ['remove_trailing_lines', 'trim_whitespace'],
	\ 'sh': ['shfmt'],
\}

" AUTOCOMMANDS
au bufenter * se fo-=cro
au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"zz" | en
au focusgained,bufenter,vimresume * checkt
au focuslost * sil! wa
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

" APPEARANCE
let g:indentLine_char = '▏'
let g:indentLine_fileTypeExclude = ['help', 'json', 'man', 'markdown', 'tex']
let g:nord_bold = 0
let g:nord_bold_vertical_split_line = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_uniform_diff_background = 1
let g:nord_uniform_status_lines = 1
colorscheme nord
se cursorline
se fillchars+=eob:\ 
se fillchars+=fold:\ 
se fillchars+=vert:\ 
se signcolumn=yes
se termguicolors

" FZF
au filetype fzf se ls=0
  \| au bufleave <buffer> se ls=2
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>t :Tags<cr>

" KILL
nnoremap <leader>s <c-z>
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <leader>d :bd<cr>
nnoremap <silent> <leader>q :qa<cr>

" LOADED
let g:loaded_gzip = 1
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
nnoremap <silent> gs vip:sort u<cr>
vnoremap <silent> gs :sort u<cr>
nnoremap Q <nop>

" NAVIGATION
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <a-e> :bp<cr>
nnoremap <silent> <a-r> :bn<cr>
nnoremap <c-j> 4<c-e>
nnoremap <c-k> 4<c-y>

" NETRW
let g:netrw_banner = 0
let g:netrw_liststyle = 3
nnoremap <silent> <leader>e :Explore<cr>

" SETTINGS
se autowriteall
se confirm
se mouse=a
se path+=**
se path-=/usr/include
se splitbelow splitright
se tabstop=4 shiftwidth=4
se updatetime=100
sil! cal repeat#se('\<Plug>vim-surround', v:count)

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
au bufenter * se ls=1 noru nosc nosmd
let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#wordcount#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_a = ''
let g:airline_section_x = ''
let g:airline_section_z = ''
let g:airline_section_error = ''
let g:airline_section_warning = ''
let g:airline_skip_empty_sections = 1

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak

" VIMTEX
au FileType tex inoremap <expr><buffer> <CR> getline('.') =~ '\item\s\w' ? '<cr>\item ' : '<cr>'
let g:vimtex_view_general_viewer = 'firefox'
let g:vimtex_compiler_latexmk = {
	\ 'backend' : 'nvim',
	\ 'background' : 1,
	\ 'build_dir' : 'tex',
	\ 'callback' : 1,
	\ 'continuous' : 1,
	\ 'executable' : 'latexmk',
	\ 'options' : [
		\ '-verbose',
		\ '-file-line-error',
		\ '-synctex=0',
		\ '-interaction=nonstopmode'
	\ ],
\}
