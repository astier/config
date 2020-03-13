" FIRST THINGS FIRST
aug default | au! | aug en
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
cal plug#begin('~/.local/share/nvim/plugins')

" GENERAL EDITING
Plug 'airblade/vim-gitgutter'
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-sandwich'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'svermeulen/vim-subversive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'

" LANGUAGE SPECIFIC
Plug 'andrewradev/sideways.vim', { 'for': 'python' }
Plug 'andrewradev/switch.vim', { 'for': 'python' }
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }
Plug 'jpalardy/vim-slime', { 'for': ['python', 'sh'] }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'SirVer/ultisnips', { 'for': ['python', 'sh', 'snippets', 'tex', 'vim'] }

" MISC
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files', 'Tags'] }
Plug 'moll/vim-bbye', { 'on': ['Bd', 'Bw'] }
Plug 'nelstrom/vim-visual-star-search'
Plug 'rhysd/clever-f.vim'
Plug 'yunake/vimux'
Plug 'yuttie/comfortable-motion.vim'
Plug 'zhimsel/vim-stay'

cal plug#end()

" APPEARANCE
au default bufwritepost * GitGutter
au default filetype gitcommit,markdown,tex setl spell
colorscheme nord
hi cursorlinenr  ctermfg=none
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
hi warningmsg    ctermbg=none ctermfg=none
se cursorline | hi clear cursorline
se fillchars+=eob:\ ,vert:\▏,fold:-,stl:_,stlnc:_
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
nn <silent> <leader>s <c-z>
nn <silent> <leader>w :Bw<cr>

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
nn <c-j> 4<c-e>
nn <c-k> 4<c-y>
nn <cr> o<esc>
nm gcp gcip
nn cp cip
nn dp dap
nn Q <nop>

" MISC-SETTINGS
au default bufenter * se formatoptions-=cro
let g:lexima_enable_endwise_rules = 0
let g:rooter_silent_chdir = 1
let g:switch_mapping = '<leader>gs'
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']
se commentstring=//\ %s
se expandtab shiftwidth=4 tabstop=4
se foldmethod=manual
se mouse=a notimeout
se scrolloff=4
se viewoptions=cursor,folds

" COMFORTABLE-MOTION
nn <silent> <c-d> :cal comfortable_motion#flick(100)<cr>
nn <silent> <c-u> :cal comfortable_motion#flick(-100)<cr>
nn <silent> <c-f> :cal comfortable_motion#flick(200)<cr>
nn <silent> <c-b> :cal comfortable_motion#flick(-200)<cr>

" SEARCH
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nn <silent> <esc> :noh <bar> ec <bar> cal clever_f#reset()<cr>
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
au default bufenter,focusgained * cal system('tmux renamew ' . expand('%:t'))
au default vimleave * cal system('tmux setw automatic-rename')
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
