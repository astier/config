cal plug#begin('~/.local/share/nvim/plugins')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips', { 'for': ['python', 'sh', 'snippets', 'tex'] }
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'benmills/vimux', { 'for': 'python' }
Plug 'christoomey/vim-tmux-navigator', { 'on': ['TmuxNavigateDown', 'TmuxNavigateLeft', 'TmuxNavigateRight', 'TmuxNavigateUp'] }
Plug 'cohama/lexima.vim'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files', 'Tags'] }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale', { 'for': ['python', 'sh', 'tex'] }

cal plug#end()

" LEADERS
let mapleader = ' '
let maplocalleader = ' '

" ALE
nnoremap <silent> <leader>i :%retab<cr>:silent! ALEFix<cr>
let g:ale_disable_lsp = 1
let g:ale_history_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%][%code%] %s'
let g:ale_sh_shfmt_options = '-ci -sr -p -s -i 4'
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'python': ['isort', 'black'],
    \ 'sh': ['shfmt'],
\ }

" APPEARANCE
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_uniform_diff_background = 1
let g:nord_uniform_status_lines = 1
colorscheme nord
hi statusline ctermbg=none ctermfg=16
hi statuslinenc ctermbg=none ctermfg=16
hi vertsplit ctermbg=none ctermfg=16
se fillchars+=eob:\ ,vert:\▏,fold:-,stl:_,stlnc:_
se stl=\  ls=0 noru nosc nosmd scl=yes

" AUTOCOMMANDS
au bufenter * se formatoptions-=cro
au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"zz" | en
au bufwritepost * GitGutter
au filetype gitcommit,tex setl spell
au focusgained,vimresume * checkt
au textchanged,insertleave * nested silent up
au vimresized * wincmd =

" CLIPBOARD
nnoremap <c-c> "+yy
vnoremap <c-c> "+y
inoremap <c-v> <esc>"+pa
nnoremap <c-v> "+p
nnoremap <c-x> "+dd
vnoremap <c-x> "+d

" COMPLETION
call deoplete#custom#option({
   \ 'min_pattern_length': 1,
   \ 'max_list': 8,
   \ 'num_processes': -1,
   \ 'ignore_sources': { '_': ['around', 'member'] },
\ })
call deoplete#custom#var('omni', 'input_patterns', { 'tex': g:vimtex#re#deoplete })
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
let g:deoplete#sources#jedi#ignore_private_members = 1
se completeopt=menuone,noinsert
se shortmess+=c

" FOLD
se foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
se foldlevel=4
se foldmethod=expr

" FZF
au filetype fzf se ls=0
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>t :Tags<cr>

" JEDI
hi function ctermbg=none ctermfg=blue
hi jedifat ctermbg=none ctermfg=red
hi jedifunction ctermbg=none ctermfg=white
hi none ctermbg=none ctermfg=white
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 1
let g:jedi#documentation_command = '<c-q>'
let g:jedi#goto_assignments_command = 'ga'
let g:jedi#goto_command = 'gd'
let g:jedi#rename_command = '<leader>rr'

" KILL
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <leader>d :bp\|bd #<cr>
nnoremap <silent> <leader>q :qa<cr>
nnoremap <silent> <leader>x :bd<cr>
nnoremap <silent> <leader>z <c-z>

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
nnoremap <c-j> 4<c-e>
nnoremap <c-k> 4<c-y>
nnoremap <cr> o<esc>
nnoremap <leader>S <c-w>v
nnoremap <leader>s <c-w>s
nnoremap <silent> <a-e> :bp<cr>
nnoremap <silent> <a-r> :bn<cr>
nnoremap <silent> <leader><leader> :silent! b #<cr>
nnoremap <silent> gs vip:sort u<cr>
nnoremap Q <c-q>
vnoremap <silent> gs :sort u<cr>

" NERDTREE
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $HOME.'/.local/share/nvim/NERDTreeBookmarks'
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', '^tex']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeQuitOnOpen = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = ''
nnoremap <silent> <leader>e :NERDTreeToggle<cr>

" SETTINGS
let g:UltiSnipsSnippetDirectories = [ $HOME.'/.config/nvim/UltiSnips' ]
let g:lexima_enable_endwise_rules = 0
let g:rooter_silent_chdir = 1
se commentstring=//\ %s
se confirm noswapfile
se expandtab shiftwidth=4 tabstop=4
se mouse=a
se notimeout
se path+=** path-=/usr/include
se splitbelow splitright
sil! cal repeat#se('\<Plug>vim-surround', v:count)

" SEARCH & REPLACE
fu! CenterSearch()
    let cmdtype = getcmdtype()
    if cmdtype == '/' || cmdtype == '?' | retu "\<enter>zz" | en
    retu "\<enter>"
endfu
cnoremap <silent> <expr> <enter> CenterSearch()
nnoremap <silent> <esc> :noh<cr>:echo<cr><esc>
nnoremap <leader>rs :%s///gI<left><left><left><left>
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gI<left><left><left>
nnoremap <silent> , *``
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
se ignorecase smartcase inccommand=nosplit

" TMUX
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
au vimenter,bufenter * call system("tmux rename-window " . expand("%:t"))
au vimleave * call system("tmux setw automatic-rename")

" VIMTEX
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_fold_enabled = 1
let g:vimtex_view_general_viewer = 'zathura'
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
let g:vimtex_compiler_callback_hooks = ['FocusViewer']
fu! FocusViewer(status)
    if system('pidof zathura')
        exe 'silent !wmctrl -xa zathura'
    el
        exe 'VimtexView'
    en
endfu

" VIMUX
nnoremap <silent> <leader>a :call VimuxRunCommand("clear; python " . bufname("%"))<cr>
nnoremap <silent> <f2> :call VimuxRunCommand("clear; python " . bufname("%"))<cr>
nnoremap <silent> <leader>vd :VimuxCloseRunner<cr>
nnoremap <silent> <leader>vi :VimuxInspectRunner<cr>
nnoremap <silent> <leader>vl :VimuxRunLastCommand<cr>
nnoremap <silent> <leader>vp :VimuxPromptCommand<cr>
nnoremap <silent> <leader>vx :VimuxInterruptRunner<cr>
nnoremap <silent> <leader>vz :cal VimuxZoomRunner()<cr>

" WHITESPACE
hi whitespace ctermbg=red
au bufwinenter * mat Whitespace /\s\+$\| \+\ze\t/
au insertenter * mat Whitespace /\s\+\%#\@<!$\| \+\ze\t/
au insertleave * mat Whitespace /\s\+$\| \+\ze\t/
au bufwinleave * cal clearmatches()

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak
