call plug#begin('~/.local/share/nvim/plugins')

" Utils
Plug '907th/vim-auto-save'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Navigation
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Statusline
Plug 'itchyny/vim-gitbranch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Snippets
Plug 'SirVer/ultisnips', { 'for': [ 'tex' ] }
Plug 'honza/vim-snippets', { 'for': [ 'tex' ] }
Plug 'neoclide/coc-snippets', { 'for': [ 'tex' ] }

" IDE
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'neoclide/coc-json', { 'for': 'json' }
Plug 'neoclide/coc-neco', { 'for': 'vim' }
Plug 'neoclide/coc-vimtex', { 'for': 'tex' }
Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }
Plug 'w0rp/ale', { 'for': [ 'sh', 'tex' ] }

" Visual
Plug 'Yggdroot/indentLine'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'machakann/vim-highlightedyank'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" LEADERS
let mapleader=' '
let maplocalleader=' '

" MISC-PLUGINS
au BufWritePost * GitGutter
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutToggle = ''
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:node_host_prog = '~/.yarn/bin/neovim-node-host'
let g:python3_host_prog = '/bin/python'
nnoremap <leader>f :FZF<cr>
sil! cal repeat#se('\<Plug>vim-surround', v:count)

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

" AIRLINE
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#tabline#middle_click_preserves_windows = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_a = '⎇  %{gitbranch#name()}'
let g:airline_section_x = ''
let g:airline_section_z = '%l/%L:%c'
" Stop truncating branch
" Remove explicit minwidth constraint
au VimEnter * let hunks = airline#parts#get("hunks")
au VimEnter * unlet hunks.minwidth
au VimEnter * let branch = airline#parts#get("branch")
au VimEnter * unlet branch.minwidth
" Must recreate the section to remove minwidth constraints
au VimEnter * let g:airline_section_b = airline#section#create(['hunks', 'branch'])

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

" BETTER-WHITESPACE
let g:better_whitespace_filetypes_blacklist = ['help']
let g:show_spaces_that_precede_tabs=1
let g:strip_whitelines_at_eof=1

" GOYO
au VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
nnoremap <silent> <a-g> :Goyo<cr>
tnoremap <silent> <a-g> <c-\><c-n>:Goyo<cr>:star<cr>

" INDENTLINE
let g:indentLine_fileTypeExclude = ['help', 'man', 'tex']
let g:indentLine_char = '▏'

" NERDTREE
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $HOME.'/.local/share/nvim/.NERDTreeBookmarks'
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags']
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

" MISC-VIM
au BufEnter * se fo-=cro
se fillchars+=fold:\ 
se mouse=a
se shortmess+=c
se tabstop=4 shiftwidth=4
se updatetime=400
nnoremap Q <nop>
nnoremap <cr> o<esc>
nnoremap <a-cr> O<esc>
nnoremap <a-p> "+p
inoremap <a-p> <esc>"+pa
vnoremap <a-y> "+y
nnoremap <a-s> <c-z>

" COLORSCHEME
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
colorscheme hybrid_material
hi cursorline guibg=#282C34
hi gitgutterdelete guifg=#CC6666
se termguicolors

" SAVE
au FocusGained,BufEnter,VimResume * checkt
let g:auto_save = 1
let g:auto_save_silent = 1
se confirm
se noswapfile

" SEARCH & REPLACE
nnoremap <silent> <esc> :noh<cr><esc>
nnoremap <a-r> :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <silent> # *
se inccommand=nosplit
se ignorecase
se smartcase

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
se hidden

" KILL
nnoremap <silent> <a-q> :qa<cr>
nnoremap <silent> <a-c> :clo<cr>
nnoremap <silent> <a-d> :Bd<cr>
tnoremap <silent> <a-q> <c-\><c-n>:qa<cr>
tnoremap <silent> <a-c> <c-\><c-n>:clo<cr>
tnoremap <silent> <a-d> <c-\><c-n>:Bd!<cr>
inoremap <silent> <a-q> <esc>:qa<cr>

" WINDOW-NAVIGATION
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <a-b> :TmuxNavigatePrevious<cr>
tnoremap <silent> <a-h> <c-\><c-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <a-j> <c-\><c-n>:TmuxNavigateDown<cr>
tnoremap <silent> <a-k> <c-\><c-n>:TmuxNavigateUp<cr>
tnoremap <silent> <a-l> <c-\><c-n>:TmuxNavigateRight<cr>
tnoremap <silent> <a-b> <c-\><c-n>:TmuxNavigatePrevious<cr>
nnoremap <a-w> <c-w>

" BUFFER-NAVIGATION
nnoremap <silent> <a-i> :bp<cr>
nnoremap <silent> <a-o> :bn<cr>
tnoremap <silent> <a-i> <c-\><c-n>:bp<cr>
tnoremap <silent> <a-o> <c-\><c-n>:bn<cr>

" RESIZE
au VimResized * wincmd =
nnoremap <silent> <a-J> :res +1<cr>
nnoremap <silent> <a-K> :res -1<cr>
nnoremap <silent> <a-L> :vert res +1<cr>
nnoremap <silent> <a-H> :vert res -1<cr>
tnoremap <silent> <a-J> <c-\><c-n>:res +1<cr>:star<cr>
tnoremap <silent> <a-K> <c-\><c-n>:res -1<cr>:star<cr>
tnoremap <silent> <a-L> <c-\><c-n>:vert res +1<cr>:star<cr>
tnoremap <silent> <a-H> <c-\><c-n>:vert res -1<cr>:star<cr>
se splitbelow splitright

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak
