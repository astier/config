" FIRST THINGS FIRST
aug default | au! | aug en
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
cal plug#begin('~/.local/share/nvim/plugins')

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'andrewradev/sideways.vim', { 'for': 'python' }
Plug 'andrewradev/switch.vim', { 'for': 'python' }
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }
Plug 'jpalardy/vim-slime', { 'for': ['python', 'sh'] }
Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files', 'Tags'] }
Plug 'junegunn/vim-easy-align'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'machakann/vim-sandwich'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'SirVer/ultisnips', { 'for': ['markdown', 'python', 'sh', 'snippets', 'tex', 'vim'] }
Plug 'svermeulen/vim-subversive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'yunake/vimux'

cal plug#end()

" APPEARANCE
" echo synIDattr(synID(line("."), col("."), 1), "name")
au default bufwritepost * GitGutter
au default filetype gitcommit,markdown,tex setl spell
colorscheme nord
hi comment       cterm=italic
hi cursorlinenr  ctermfg=none
hi diffadded     cterm=bold   ctermbg=none ctermfg=green
hi diffremoved   cterm=bold   ctermbg=none ctermfg=red
hi errormsg      ctermbg=none
hi function      ctermfg=none
hi number        ctermfg=none
hi pmenusel      ctermfg=none
hi pythonbuiltin ctermfg=none
hi search        cterm=bold   ctermbg=none ctermfg=red
hi statusline    ctermbg=none ctermfg=16
hi statuslinenc  ctermbg=none ctermfg=16
hi tabline       ctermbg=none ctermfg=8
hi tablinefill   ctermbg=none
hi tablinesel    ctermbg=none ctermfg=none
hi vertsplit     ctermbg=none ctermfg=16
hi vimaugroup    ctermfg=none
hi vimmaprhs     ctermfg=none
hi vimnotation   ctermfg=none
hi warningmsg    ctermbg=none ctermfg=none
se cursorline | hi clear cursorline
se fillchars+=eob:\ ,fold:\ ,stl:―,stlnc:―,vert:▏
se noruler noshowcmd noshowmode
se statusline=\  showtabline=0 laststatus=0 signcolumn=yes
let g:fzf_colors = {
    \ 'hl':      ['fg', 'search'],
    \ 'hl+':     ['fg', 'search'],
    \ 'info':    ['fg', 'comment'],
    \ 'marker':  ['fg', 'pythonEscape'],
    \ 'pointer': ['fg', 'string'],
    \ 'prompt':  ['fg', 'exception'],
    \ }

" BUFFERS
au default bufenter,focusgained * checkt
au default textchanged,insertleave * nested sil up
nn <silent> <leader>b :Buffers!<cr>
nn <silent> <leader>f :Files!<cr>
nn <silent> <a-tab> :bp<cr>
nn <silent> <tab> :bn<cr>
se confirm noswapfile
se path+=** path-=/usr/include

" CLIPBOARD
ino <c-v> <esc>"+pa
nn <c-c> "+yy
nn <c-v> "+p
nn <c-x> "+dd
xn <c-c> "+y
xn <c-x> "+d

" COMPLETION
let g:coc_global_extensions = ['coc-json', 'coc-python', 'coc-vimtex']
nm <leader>rn <plug>(coc-rename)
nm <silent> gd <plug>(coc-definition)zz
nm <silent> gr <plug>(coc-references)
nn <silent> K :cal <sid>show_documentation()<cr>
fu! s:show_documentation()
    if index(['vim','help'], &filetype) >= 0
        exe 'h '.expand('<cword>')
    el | cal CocAction('doHover') | en
endf
se completeopt=menuone,noinsert
se infercase shortmess+=c

" FORMAT
fu! Format()
    let l:save = winsaveview()
    exe 'ret! | sil up'
    cal system('format ' . bufname('%'))
    exe 'e'
    cal winrestview(l:save)
endf
nn <silent> <leader>gf :cal Format()<cr>

" KILL
nn <silent> <leader>c :clo<cr>
nn <silent> <leader>d :cal VimuxCloseRunner() <bar> qa<cr>
nn <silent> <leader>q :bw<cr>
nn <silent> <leader>s <c-z>
nn <silent> <leader>w :bn<bar>bd#<cr>

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
nn <silent> gs vip:sort iu<cr>
xn <silent> gs :sort iu<cr>
nm ga <plug>(EasyAlign)
xm ga <plug>(EasyAlign)
xn . :norm.<cr>
nm <leader>i <leader>hp
nm <leader>u <leader>hu
nn <c-f> 4<c-e>
nn <c-d> 4<c-y>
nm gcp gcip
nn cp cip
nn dp dap
nn Q <nop>

" MISC-SETTINGS
au default bufenter * se formatoptions-=cro
let g:fzf_preview_window = ''
let g:lexima_enable_endwise_rules = 0
let g:rooter_silent_chdir = 1
let g:switch_mapping = '<leader>gs'
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
se commentstring=//\ %s
se expandtab shiftwidth=4 tabstop=4
se mouse=a notimeout

" NERDTREE
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $HOME.'/.local/share/nvim/NERDTreeBookmarks'
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', '^tex', '\.aux$', '\.fdb_latexmk$', '\.fls$', '\.log$', '\.nav$', '\.out$', '\.snm$', '\.gz$', '\.toc$']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeMouseMode = 3
let g:NERDTreeQuitOnOpen = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = ''
nn <silent> <leader>e :NERDTreeToggle<cr>

" STATE
se viewoptions=cursor
au default bufwinleave * if index(['gitcommit'], &ft) < 0 | sil! mkvie
au default bufwinenter * if index(['gitcommit'], &ft) < 0 | sil! lo

" SEARCH
nn <silent> <esc> :noh <bar> ec<cr>
nn <silent> , *``
nn <silent> n nzz
nn <silent> N Nzz
se ignorecase
se inccommand=nosplit

" SIDEWAYS
nn <silent> <c-h> :SidewaysLeft<cr>
nn <silent> <c-l> :SidewaysRight<cr>
om aa <plug>SidewaysArgumentTextobjA
om ia <plug>SidewaysArgumentTextobjI
xm aa <plug>SidewaysArgumentTextobjA
xm ia <plug>SidewaysArgumentTextobjI

" SLIME
let g:slime_default_config = {'socket_name': 'default', 'target_pane': '{bottom}'}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
let g:slime_paste_file = '/tmp/slime'
let g:slime_target = 'tmux'
nmap <leader><leader> <Plug>SlimeParagraphSend
xmap <leader><leader> <Plug>SlimeRegionSend

" SNIPPETS
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<a-tab>'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']

" SUBVERSIVE
nm s <plug>(SubversiveSubstitute)
xm s <plug>(SubversiveSubstitute)
nm ss <plug>(SubversiveSubstituteLine)
nm S <plug>(SubversiveSubstituteToEndOfLine)
nm <leader>r <plug>(SubversiveSubstituteRange)
xm <leader>r <plug>(SubversiveSubstituteRange)
nm <leader>rr <plug>(SubversiveSubstituteWordRange)
nm <leader>rc <plug>(SubversiveSubstituteRangeConfirm)
xm <leader>rc <plug>(SubversiveSubstituteRangeConfirm)
nm <leader>rcc <plug>(SubversiveSubstituteWordRangeConfirm)
let g:subversivePromptWithCurrent = 1
let g:subversivePreserveCursorPosition = 1
xn ie <esc>ggVG
xn iv <esc>HVL
ono ie :exe "norm! ggVG"<cr>
ono iv :exe "norm! HVL"<cr>

" TMUXRENAME
fu! RenameTmux()
    if !(bufname() =~# 'NERD' || bufname() =~# 'Tagbar')
        cal system('tmux renamew ' . expand('%:t'))
    en
endf
aug tmuxrename | au! | aug en
au tmuxrename bufenter,focusgained * cal RenameTmux()
au tmuxrename vimleave * cal system('tmux setw automatic-rename')

" VIMUX
let g:VimuxHeight = '35'
let g:VimuxUseNearest = 0
nn <silent> <leader>l :cal VimuxRunCommand('clear; lint ' . bufname('%'))<cr>
nn <silent> <leader>a :cal VimuxRunCommand('clear; execute ' . bufname('%'))<cr>
au default filetype tex nn <silent> <leader>a :VimtexCompile<cr>
nn <silent> <leader>x :VimuxCloseRunner<cr>

" VIMTEX
au filetype tex nnoremap <leader>t :cal vimtex#fzf#run()<cr>
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_mappings_enabled = 0
let g:vimtex_matchparen_enabled = 0
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_callback_hooks = ['FocusViewer']
fu! FocusViewer(status)
    if system('pidof zathura')
       exe 'sil !xdotool search --desktop 0 --class Zathura windowactivate'
    el
       exe 'VimtexView'
    en
    exe 'ec'
endf
let g:vimtex_compiler_latexmk = {
    \ 'callback' : 0,
    \ 'continuous' : 0,
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=0',
    \   '-interaction=nonstopmode',
    \ ],
    \ }

" WINDOWS
au default vimresized * winc =
let g:tmux_navigator_no_mappings = 1
nn <silent> <a-h> :TmuxNavigateLeft<cr>
nn <silent> <a-j> :TmuxNavigateDown<cr>
nn <silent> <a-k> :TmuxNavigateUp<cr>
nn <silent> <a-l> :TmuxNavigateRight<cr>
se splitbelow splitright

" WRAP
nn $ g$
nn 0 g0
nn j gj
nn k gk
xn $ g$
xn 0 g0
xn j gj
xn k gk
se breakindent linebreak
