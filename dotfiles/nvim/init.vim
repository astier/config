" FIRST THINGS FIRST
augroup default | autocmd! | augroup end
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
call plug#begin('~/.local/share/nvim/plugins')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips', { 'for': ['python', 'sh', 'snippets', 'tex', 'vim'] }
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files'] }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'machakann/vim-sandwich'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'yunake/vimux'
call plug#end()

" APPEARANCE
autocmd default bufenter,focusgained * call system("tmux renamew " . expand("%:t"))
autocmd default vimleave * call system("tmux setw automatic-rename")
autocmd default bufwritepost * GitGutter
autocmd default filetype gitcommit,tex setlocal spell
colorscheme nord
highlight comment cterm=italic
highlight cursorlinenr ctermfg=none
highlight errormsg ctermbg=none
highlight number ctermfg=none
highlight pmenusel ctermfg=none
highlight search ctermbg=yellow
highlight statusline ctermbg=none ctermfg=16
highlight statuslinenc ctermbg=none ctermfg=16
highlight vertsplit ctermbg=none ctermfg=16
highlight warningmsg ctermbg=none ctermfg=none
set cursorline | highlight clear cursorline
set fillchars+=eob:\ ,vert:\▏,fold:-,stl:_,stlnc:_
set statusline=\  laststatus=0 showtabline=0 signcolumn=yes
set noruler noshowcmd noshowmode

" BUFFERS
autocmd default bufenter,focusgained * checktime
autocmd default bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g'\"zz" | end
autocmd default textchanged,insertleave * nested silent update
nnoremap <silent> <leader>F :Files!<cr>
nnoremap <silent> <leader>f :call system("tmux neww -a && tmux send ~/.config/nvim/vtf.sh Enter")<cr>
nnoremap <silent> <leader>b :Buffers!<cr>
nnoremap <silent> <a-tab> :bp<cr>
nnoremap <silent> <tab> :bn<cr>
nnoremap <silent> <leader><leader> :b#<cr>
set confirm noswapfile
set path+=** path-=/usr/include

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
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
call deoplete#custom#var('omni', 'input_patterns', { 'tex': g:vimtex#re#deoplete })
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
let g:deoplete#sources#jedi#ignore_private_members = 1
set completeopt=menuone,noinsert
set shortmess+=c

" FORMAT
function! Format()
    let l:save = winsaveview()
    execute 'retab! | silent update'
    call system('format ' . bufname('%'))
    execute 'edit'
    call winrestview(l:save)
endfunction
nnoremap <silent> <leader>gf :call Format()<cr>

" JEDI
highlight function ctermbg=none ctermfg=blue
highlight jedifat ctermbg=none ctermfg=red
highlight jedifunction ctermbg=none ctermfg=white
highlight none ctermbg=none ctermfg=white
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 1
let g:jedi#goto_assignments_command = 'ga'
let g:jedi#goto_command = 'gd'
let g:jedi#rename_command = '<leader>rr'
let g:jedi#goto_stubs_command = ''

" KILL
nnoremap <silent> <leader>c :close<cr>
nnoremap <silent> <leader>d :VimuxCloseRunner<cr>:qa<cr>
nnoremap <silent> <leader>q :update<cr>:VimuxCloseRunner<cr>:call system("tmux kill-pane")<cr>
nnoremap <silent> <leader>s <c-z>
nnoremap <silent> <leader>w :bprevious\|bdelete #<cr>

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

" MISC-MAPPINGS
nnoremap <silent> gs vip:sort u<cr>
vnoremap <silent> gs :sort u<cr>
nnoremap <c-j> 4<c-e>
nnoremap <c-k> 4<c-y>
nnoremap <cr> o<esc>
nnoremap cW ciW
nnoremap cp cip
nnoremap cw ciw
nnoremap dW daW
nnoremap dp dap
nnoremap dw daw
nnoremap Q <nop>
nmap s <nop>
xmap s <nop>

" MISC-SETTINGS
autocmd default bufenter * set formatoptions-=cro
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']
let g:lexima_enable_endwise_rules = 0
let g:rooter_silent_chdir = 1
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
set commentstring=//\ %s
set expandtab shiftwidth=4 tabstop=4
set mouse=a notimeout

" SEARCH
function! CenterSearch()
    let cmdtype = getcmdtype()
    if cmdtype ==# '/' || cmdtype ==# '?'
        retu "\<cr>zz"
    elsei getcmdline() =~# '^%s/'
        retu "\<cr>``zz"
    else
        retu "\<cr>"
    end
endfunction
cnoremap <silent> <expr> <cr> CenterSearch()
nnoremap <leader>rs :%s///gI<left><left><left><left>
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gI<left><left><left>
nnoremap <silent> <esc> :noh<cr>:ec<cr><esc>
nnoremap <silent> , *``
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
set ignorecase smartcase
set inccommand=nosplit

" NERDTREE
autocmd stdinreadpre * let s:std_in=1
autocmd vimenter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $HOME.'/.local/share/nvim/NERDTreeBookmarks'
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', '^tex', '\.aux$', '\.fdb_latexmk$', '\.fls$', '\.log$', '\.nav$', '\.out$', '\.snm$', '\.gz$', '\.toc$']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeQuitOnOpen = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = ''
nnoremap <silent> <leader>e :NERDTreeToggle<cr>

" VIMUX
let g:VimuxHeight = '35'
let g:VimuxUseNearest = 0
nnoremap <silent> <leader>l :call VimuxRunCommand("clear; lint " . bufname("%"))<cr>
nnoremap <silent> <leader>a :call VimuxRunCommand("clear; execute " . bufname("%"))<cr>:VimuxZoomRunner<cr>
autocmd default filetype tex nnoremap <silent> <leader>a :VimtexCompile<cr>
nnoremap <silent> <leader>v :call VimuxZoomRunner()<cr>
nnoremap <silent> <leader>x :VimuxCloseRunner<cr>

" VIMTEX
let g:vimtex_compiler_callback_hooks = ['FocusViewer']
let g:vimtex_compiler_latexmk = { 'continuous' : 0 }
let g:vimtex_mappings_enabled = 0
let g:vimtex_matchparen_enabled = 0
let g:vimtex_view_general_viewer = 'zathura'
function! FocusViewer(status)
    if system('pidof zathura')
       execute 'silent !wmctrl -xa zathura'
    else
       execute 'VimtexView'
    end
    execute 'ec'
endfunction

" WINDOWS
autocmd default vimresized * wincmd =
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
set splitbelow splitright

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
set breakindent linebreak
