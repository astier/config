call plug#begin('~/.local/share/nvim/plugins')

" MISC
Plug '907th/vim-auto-save'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/lexima.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" AUTOCOMPLETION, LINTING, FORMATTING, LSP, SNIPPETS
Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'neoclide/coc-neco', { 'for': 'vim' }
Plug 'neoclide/coc-vimtex', { 'for': 'tex' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale', { 'for': [ 'sh', 'tex', 'vim' ] }

" NAVIGATION
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags', { 'for': [ 'tex' ] }

" SNIPPETS
Plug 'SirVer/ultisnips', { 'for': [ 'tex' ] }
Plug 'honza/vim-snippets', { 'for': [ 'tex' ] }

" VISUAL
Plug 'Yggdroot/indentLine'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ntpeters/vim-better-whitespace'

call plug#end()

" LEADERS
let mapleader=' '
let maplocalleader=' '

"""""""""""
" PLUGINS "
"""""""""""

" MISC
au BufWritePost * GitGutter
let g:indentLine_fileTypeExclude = ['help', 'json', 'man', 'markdown', 'tex']
let g:indentLine_char = '▏'
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_node_provider = 1
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:python3_host_prog = '/bin/python'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']
sil! cal repeat#se('\<Plug>vim-surround', v:count)

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

" AUTO-SAVE
let g:auto_save = 1
let g:auto_save_silent = 1
se noswapfile

" BETTER-WHITESPACE
let g:better_whitespace_filetypes_blacklist = ['help']
let g:show_spaces_that_precede_tabs=1
let g:strip_whitelines_at_eof=1

" COC
let g:coc_global_extensions = [ 'coc-ultisnips' ]
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<C-j>"

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
se mouse=a
se path-=/usr/include
se shortmess+=c
se splitbelow splitright
se tabstop=4 shiftwidth=4
nnoremap Q <nop>
nnoremap <cr> o<esc>
nnoremap <leader>p "+p
inoremap <a-p> <esc>"+pa
vnoremap <leader>y "+y
nnoremap <leader>s <c-z>

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

" SEARCH & REPLACE
nnoremap <silent> <esc> :noh<cr><esc>
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//g<left><left>
nnoremap <leader>rr :%s///g<left><left><left>
nnoremap <silent> , *
nnoremap n nzz
nnoremap N Nzz
se inccommand=nosplit
se ignorecase
se smartcase

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
