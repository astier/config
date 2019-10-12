cal plug#begin('~/.local/share/nvim/plugins')

" BASICS
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator', { 'on': ['TmuxNavigateDown', 'TmuxNavigateLeft', 'TmuxNavigateRight', 'TmuxNavigateUp'] }
Plug 'cohama/lexima.vim'
Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files', 'Tags'] }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" IDE
Plug 'SirVer/ultisnips', { 'for': ['python', 'snippets', 'tex'] }
Plug 'benmills/vimux', { 'for': 'python' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'ludovicchabant/vim-gutentags', { 'for': ['python', 'tex'] }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale', { 'for': ['python', 'sh', 'tex', 'vim'] }

" REPLACEABLE
Plug 'ntpeters/vim-better-whitespace'

cal plug#end()

" LEADERS
let mapleader = ' '
let maplocalleader = ' '

" ALE
let g:ale_disable_lsp = 1
let g:ale_history_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%][%code%] %s'

" APPEARANCE
let g:nord_bold_vertical_split_line = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_uniform_diff_background = 1
let g:nord_uniform_status_lines = 1
colorscheme nord
hi StatusLine guibg=#3b4252
hi StatusLineNC guibg=#3b4252
se fillchars+=eob:\ ,vert:\ ,fold:-
se signcolumn=yes shortmess+=c termguicolors
se statusline=\  ls=0 nosc nosmd noru

" AUTOCOMMANDS
au bufenter * se formatoptions-=cro
au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"zz" | en
au bufwritepost * GitGutter
au filetype gitcommit,python,tex setl spell
au focusgained,vimresume * checkt
au textchanged,insertleave * nested silent up
au vimresized * wincmd =

" BETTER-WHITESPACE
let g:better_whitespace_filetypes_blacklist = ['help']
let g:better_whitespace_guicolor = '#bf616a'
let g:show_spaces_that_precede_tabs = 1
let g:strip_whitelines_at_eof = 1

" CLIPBOARD
nnoremap <RightMouse> "+p
vnoremap <RightMouse> "+y
nnoremap <c-c> "+yy
vnoremap <c-c> "+y
inoremap <c-v> <esc>"+pa
nnoremap <c-v> "+p
vnoremap <c-v> dk"+p
nnoremap <c-x> "+dd
vnoremap <c-x> "+d

" COC
let g:coc_global_extensions = ['coc-json', 'coc-python', 'coc-vimtex']
au cursorhold * silent cal CocActionAsync('highlight')
inoremap <silent> <expr> <c-space> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)zz
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nnoremap <silent> K :cal <SID>show_documentation()<cr>
fu! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        exe 'h '.expand('<cword>')
    el | cal CocAction('doHover') | en
endfu

" FOLD
se foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
se foldlevel=4
se foldmethod=expr

" FZF
au filetype fzf se ls=0
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
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_node_provider = 1
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:python3_host_prog = '/bin/python'

" MAPPINGS
nnoremap <a-s> <c-g>
nnoremap <cr> o<esc>
nnoremap <leader>z <c-w>s
nnoremap <leader>v <c-w>v
nnoremap <silent> <leader>i :%retab<cr>:StripWhitespace<cr>
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
nnoremap <silent> <a-i> :bp<cr>
nnoremap <silent> <a-o> :bn<cr>
nnoremap <c-j> 4<c-e>
nnoremap <c-k> 4<c-y>

" NERDTREE
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $HOME.'/.local/share/nvim/NERDTreeBookmarks'
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', '^tex']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeQuitOnOpen = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = 'NERDTree'
nnoremap <silent> <leader>e :NERDTreeToggle<cr><c-w>=

" SETTINGS
let g:UltiSnipsSnippetDirectories = [ $HOME.'/.config/nvim/UltiSnips' ]
se confirm noswapfile
se expandtab shiftwidth=4 tabstop=4
se mouse=a
se path+=** path-=/usr/include
se splitbelow splitright
sil! cal repeat#se('\<Plug>vim-surround', v:count)

" SEARCH & REPLACE
" au CursorHold * exec 'mat StatusLineTerm /'.expand('<cword>').'/'
fu! CenterSearch()
    let cmdtype = getcmdtype()
    if cmdtype == '/' || cmdtype == '?' | retu "\<enter>zz" | en
    retu "\<enter>"
endfu
cnoremap <silent> <expr> <enter> CenterSearch()
nnoremap <silent> <esc> :noh<cr>:echo<cr><esc>
nnoremap <leader>re :%s/\<<C-r><C-w>\>//gI<left><left><left>
nnoremap <leader>rw :%s///gI<left><left><left><left>
nnoremap <silent> , *``
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
se ignorecase smartcase inccommand=nosplit

" VIMTEX
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_fold_enabled = 1
let g:vimtex_view_general_viewer = 'firefox'
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'nvim',
    \ 'background' : 1,
    \ 'build_dir' : 'tex',
    \ 'callback' : 1,
    \ 'continuous' : 0,
    \ 'executable' : 'latexmk',
    \ 'options' : [
        \ '-verbose',
        \ '-file-line-error',
        \ '-synctex=0',
        \ '-interaction=nonstopmode'
    \ ],
\}

" VIMUX
nnoremap <leader>vd :VimuxCloseRunner<cr>
nnoremap <leader>vi :VimuxInspectRunner<cr>
nnoremap <leader>vl :VimuxRunLastCommand<cr>
nnoremap <leader>vp :VimuxPromptCommand<cr>
nnoremap <leader>vr :cal VimuxRunCommand("clear; run " . bufname("%"))<cr>
nnoremap <leader>vx :VimuxInterruptRunner<cr>
nnoremap <leader>vz :cal VimuxZoomRunner()<cr>

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak
