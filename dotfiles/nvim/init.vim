call plug#begin('~/.local/share/nvim/plugins')

" AUTOCOMPLETION, LINTING, FORMATTING, LSP
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'neoclide/coc-json', { 'for': 'json' }
Plug 'neoclide/coc-neco', { 'for': 'vim' }
Plug 'neoclide/coc-vimtex', { 'for': 'tex' }
Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }
Plug 'w0rp/ale', { 'for': [ 'sh', 'tex', 'vim' ] }

" NAVIGATION
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags', { 'for': [ 'tex' ] }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" SNIPPETS
Plug 'SirVer/ultisnips', { 'for': [ 'tex' ] }
Plug 'honza/vim-snippets', { 'for': [ 'tex' ] }
Plug 'neoclide/coc-snippets', { 'for': [ 'tex' ] }

" VISUAL
Plug 'Yggdroot/indentLine'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'machakann/vim-highlightedyank'
Plug 'ntpeters/vim-better-whitespace'

" UTILS
Plug '907th/vim-auto-save'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'moll/vim-bbye'
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

" ALE
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_info_str = 'I'
let g:ale_echo_msg_format = '[%linter%][%severity%][%code%] %s'
" bibclean, gitlint, markdownlint, vint, alex, write-good
let g:ale_fixers = {
	\ '*': ['remove_trailing_lines', 'trim_whitespace'],
	\ 'sh': ['shfmt'],
\}
let g:ale_sh_shfmt_options = '-ci -sr -p -s'

" AUTO-PAIR
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = ''

" BETTER-WHITESPACE
let g:better_whitespace_filetypes_blacklist = ['help']
let g:show_spaces_that_precede_tabs=1
let g:strip_whitelines_at_eof=1

" COC
let g:coc_global_extensions = [ 'coc-ultisnips' ]
" Trigger completion via <c-space>
inoremap <silent><expr> <c-space> coc#refresh()
" Confirm completion via <cr>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Backspace-function to help update completion after backspace
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~# '\s'
endfunction
" Manage Completion via TAB
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()

" GOYO
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent> <leader>g :Goyo<cr>
tnoremap <silent> <leader>g <c-\><c-n>:Goyo<cr>:star<cr>

" INDENTLINE
let g:indentLine_fileTypeExclude = ['help', 'json', 'man', 'markdown', 'tex']
let g:indentLine_char = '▏'

" MISC
au BufWritePost * GitGutter
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_node_provider = 1
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:python3_host_prog = '/bin/python'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']
sil! cal repeat#se('\<Plug>vim-surround', v:count)

" FZF
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>a :Tags<cr>

" NERDTREE
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $HOME.'/.local/share/nvim/.NERDTreeBookmarks'
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', 'tex']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeQuitOnOpen = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = 'NERDTree'
nnoremap <silent> <leader>e :NERDTreeToggle<cr><c-w>=
tnoremap <silent> <leader>e <c-\><c-n>:NERDTreeToggle<cr><c-w>=

" TAGBAR
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_indent = 1
let g:tagbar_silent = 1
nnoremap <silent> <leader>t :TagbarToggle<cr>

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

" COLORSCHEME
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
hi cursorline guibg=#282C34
hi gitgutterdelete guifg=#CC6666
se termguicolors

" KILL
nnoremap <silent> <leader>q :qa<cr>
inoremap <silent> <a-q> <esc>:qa<cr>
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <leader>d :Bd<cr>
nnoremap <silent> <leader>x :Bd<cr>:clo<cr>

" MISC
au BufEnter * se fo-=cro
se fillchars+=fold:\ 
se mouse=a
se path-=/usr/include
se shortmess+=c
se tabstop=4 shiftwidth=4
se updatetime=400
nnoremap Q <nop>
nnoremap <cr> o<esc>
nnoremap <leader>p "+p
inoremap <a-p> <esc>"+pa
vnoremap <leader>y "+y
nnoremap <leader>s <c-z>

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

" RESIZE
au VimResized * wincmd =
nnoremap <silent> <a-J> :res +1<cr>
nnoremap <silent> <a-K> :res -1<cr>
nnoremap <silent> <a-L> :vert res +1<cr>
nnoremap <silent> <a-H> :vert res -1<cr>
se splitbelow splitright

" SAVE
au FocusGained,BufEnter,VimResume * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
se confirm
se noswapfile

" SEARCH & REPLACE
nnoremap <silent> <esc> :noh<cr><esc>
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <leader>rr :%s///g<left><left><left>
nnoremap <silent> , *
se inccommand=nosplit
se ignorecase
se smartcase

" STATUSLINE
se laststatus=1
se noruler
se noshowcmd
se noshowmode
se signcolumn=yes

" TERMINAL
au BufEnter term://* star
au TermOpen * setl nonu nornu scl=no | star
se hidden

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak
