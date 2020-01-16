" FIRST THINGS FIRST
aug vimrc | au! | aug end
let mapleader = ' '
scripte utf-8

" PLUGINS
cal plug#begin('~/.local/share/nvim/plugins')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips', { 'for': ['python', 'sh', 'snippets', 'tex', 'vim'] }
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'machakann/vim-sandwich'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'yunake/vimux'
cal plug#end()

" APPEARANCE
au vimrc bufenter,focusgained * cal system("tmux rename-window " . expand("%:t"))
au vimrc vimleave * cal system("tmux setw automatic-rename")
au vimrc bufwritepost * GitGutter
au vimrc filetype gitcommit,tex setl spell
colorscheme nord
hi comment cterm=italic
hi cursorlinenr ctermfg=none
hi errormsg ctermbg=none
hi number ctermfg=none
hi pmenusel ctermfg=none
hi search ctermbg=yellow
hi statusline ctermbg=none ctermfg=16
hi statuslinenc ctermbg=none ctermfg=16
hi vertsplit ctermbg=none ctermfg=16
hi warningmsg ctermbg=none
se cul | hi clear cursorline
se fillchars+=eob:\ ,vert:\▏,fold:-,stl:_,stlnc:_
se stl=\  ls=0 noru nosc nosmd scl=yes stal=0

" BUFFERS
au vimrc bufenter,focusgained * checkt
au vimrc bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"zz" | en
au vimrc textchanged,insertleave * nested silent up
nnoremap <silent> <leader>f :cal system("tmux neww -a && tmux send ~/.config/nvim/vtf.sh Enter")<cr>
nnoremap <silent> <leader><leader> :b#<cr>
nnoremap <silent> <a-tab> :bp<cr>
nnoremap <silent> <tab> :bn<cr>
nnoremap <leader>b :ls<cr>:b<space>
se confirm noswapfile
se path+=** path-=/usr/include

" CLIPBOARD
nnoremap <c-c> "+yy
vnoremap <c-c> "+y
inoremap <c-v> <esc>"+pa
nnoremap <c-v> "+p
nnoremap <c-x> "+dd
vnoremap <c-x> "+d

" COMPLETION
cal deoplete#custom#option({
    \ 'min_pattern_length': 1,
    \ 'max_list': 8,
    \ 'num_processes': -1,
    \ 'ignore_sources': { '_': ['around', 'member'] },
\ })
cal deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])
cal deoplete#custom#var('omni', 'input_patterns', { 'tex': g:vimtex#re#deoplete })
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_typeinfo = 0
let g:deoplete#sources#jedi#ignore_private_members = 1
se completeopt=menuone,noinsert
se shortmess+=c

" FORMAT
fu! Format()
    let l:save = winsaveview()
    exe 'ret! | sil up'
    cal system('format ' . bufname('%'))
    exe 'edit'
    cal winrestview(l:save)
endf
nnoremap <silent> <leader>gf :cal Format()<cr>

" JEDI
hi function ctermbg=none ctermfg=blue
hi jedifat ctermbg=none ctermfg=red
hi jedifunction ctermbg=none ctermfg=white
hi none ctermbg=none ctermfg=white
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 1
let g:jedi#goto_assignments_command = 'ga'
let g:jedi#goto_command = 'gd'
let g:jedi#rename_command = '<leader>rr'

" KILL
nnoremap <silent> <leader>c :clo<cr>
nnoremap <silent> <leader>d :VimuxCloseRunner<cr>:qa<cr>
nnoremap <silent> <leader>q :up<cr>:VimuxCloseRunner<cr>:cal system("tmux kill-pane")<cr>
nnoremap <silent> <leader>s <c-z>
nnoremap <silent> <leader>w :bp\|bd #<cr>

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
au vimrc bufenter * se formatoptions-=cro
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']
let g:lexima_enable_endwise_rules = 0
let g:rooter_silent_chdir = 1
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
se commentstring=//\ %s
se expandtab shiftwidth=4 tabstop=4
se mouse=a
se notimeout

" SEARCH
fu! CenterSearch()
    let cmdtype = getcmdtype()
    if cmdtype ==# '/' || cmdtype ==# '?'
        retu "\<cr>zz"
    elsei getcmdline() =~# '^%s/'
        retu "\<cr>``zz"
    else
        retu "\<cr>"
    en
endf
cnoremap <silent> <expr> <cr> CenterSearch()
nnoremap <leader>rs :%s///gI<left><left><left><left>
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//gI<left><left><left>
nnoremap <silent> <esc> :noh<cr>:ec<cr><esc>
nnoremap <silent> , *``
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
se ignorecase smartcase
se inccommand=nosplit

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

" VIMUX
let g:VimuxHeight = '35'
let g:VimuxUseNearest = 0
nnoremap <silent> <leader>l :cal VimuxRunCommand("clear; lint " . bufname("%"))<cr>
nnoremap <silent> <leader>a :cal VimuxRunCommand("clear; execute " . bufname("%"))<cr>:VimuxZoomRunner<cr>
au vimrc filetype tex nnoremap <silent> <leader>a :VimtexCompile<cr>
nnoremap <silent> <leader>v :cal VimuxZoomRunner()<cr>
nnoremap <silent> <leader>x :VimuxCloseRunner<cr>

" VIMTEX
let g:vimtex_compiler_callback_hooks = ['FocusViewer']
let g:vimtex_compiler_latexmk = { 'continuous' : 0 }
let g:vimtex_mappings_enabled = 0
let g:vimtex_matchparen_enabled = 0
let g:vimtex_view_general_viewer = 'zathura'
fu! FocusViewer(status)
    if system('pidof zathura')
       exe 'silent !wmctrl -xa zathura'
    el
       exe 'VimtexView'
    en
    exe 'ec'
endf

" WINDOWS
au vimrc vimresized * winc =
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <leader>P :vs<cr>
nnoremap <silent> <leader>p :sp<cr>
se splitbelow splitright

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
se breakindent linebreak
