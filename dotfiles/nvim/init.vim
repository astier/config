" FIRST THINGS FIRST
aug default | au! | aug en
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
cal plug#begin('~/.local/share/nvim/plugins')

" GENERAL EDITING
Plug 'airblade/vim-gitgutter'
Plug 'andrewradev/sideways.vim'
Plug 'andrewradev/switch.vim'
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'machakann/vim-sandwich'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-visual-star-search'
Plug 'rhysd/clever-f.vim'
Plug 'svermeulen/vim-subversive'
Plug 'tpope/vim-commentary'

" LANGUAGE SPECIFIC
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neopairs.vim', { 'for': 'python' }
Plug 'SirVer/ultisnips', { 'for': ['python', 'sh', 'snippets', 'tex', 'vim'] }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }
Plug 'jeetsukumaran/vim-pythonsense', { 'for': 'python' }
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'lervag/vimtex', { 'for': 'tex' }

" USER INTERFACE
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files', 'Tags'] }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'ryanoasis/vim-devicons', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }

" MISC
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'christoomey/vim-tmux-navigator'
Plug 'moll/vim-bbye', { 'on': ['Bd', 'Bw'] }
Plug 'tpope/vim-sleuth'
Plug 'yunake/vimux'
Plug 'yuttie/comfortable-motion.vim'
Plug 'zhimsel/vim-stay'

cal plug#end()

" APPEARANCE
au default bufwritepost * GitGutter
au default filetype gitcommit,markdown,tex setl spell
colorscheme nord
hi comment       cterm=italic
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

" BUFFERS
au default bufenter,focusgained * checkt
au default textchanged,insertleave * nested sil up
nn <silent> <leader>b :Buffers<cr>
nn <silent> <leader>f :Files<cr>
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
au insertenter * cal deoplete#enable()
cal deoplete#custom#option({
    \ 'ignore_sources': { '_': ['around', 'member'] },
    \ 'max_list': 8,
    \ 'min_pattern_length': 1,
    \ 'num_processes': 1,
    \ })
cal deoplete#custom#source('_', 'converters', [
    \ 'converter_auto_paren',
    \ ])
cal deoplete#custom#source('_', 'matchers', [
    \ 'matcher_fuzzy',
    \ 'matcher_head',
    \ 'matcher_length',
    \ ])
cal deoplete#custom#var('omni', 'input_patterns', { 'tex': g:vimtex#re#deoplete })
let g:deoplete#sources#jedi#ignore_private_members = 1
se completeopt=menuone,noinsert
se shortmess+=c

" FORMAT
fu! Format()
    let l:save = winsaveview()
    exe 'ret! | sil up'
    cal system('format ' . bufname('%'))
    exe 'e'
    cal winrestview(l:save)
endf
nn <silent> <leader>gf :cal Format()<cr>

" JEDI
hi function     ctermbg=none ctermfg=blue
hi jedifat      ctermbg=none ctermfg=red
hi jedifunction ctermbg=none ctermfg=white
hi none         ctermbg=none ctermfg=white
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#goto_assignments_command = ''
let g:jedi#goto_command = 'gd'
let g:jedi#goto_stubs_command = ''
let g:jedi#rename_command = '<leader>jr'
let g:jedi#show_call_signatures = 2
let g:jedi#smart_auto_mappings = 1

" KILL
nn <silent> <leader>c :clo<cr>
nn <silent> <leader>d :cal VimuxCloseRunner() <bar> qa<cr>
nn <silent> <leader>k :DeleteHiddenBuffers<cr>
nn <silent> <leader>q :up <bar> :au! tmuxrename<cr> :cal VimuxCloseRunner() <bar> :cal system('tmux killp \; selectl -E')<cr>
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
nn <silent> gs vip:sort u<cr>
xn <silent> gs :sort u<cr>
nm ga <plug>(EasyAlign)
xm ga <plug>(EasyAlign)
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
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']
let g:lexima_enable_endwise_rules = 0
let g:rooter_silent_chdir = 1
let g:switch_mapping = '<leader>gs'
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
se commentstring=//\ %s
se expandtab shiftwidth=4 tabstop=4
se foldmethod=manual
se mouse=a notimeout
se scrolloff=4
se viewoptions=cursor,folds

" COMFORTABLE-MOTION
nn <silent> <C-d> :call comfortable_motion#flick(100)<cr>
nn <silent> <C-u> :call comfortable_motion#flick(-100)<cr>
nn <silent> <C-f> :call comfortable_motion#flick(200)<cr>
nn <silent> <C-b> :call comfortable_motion#flick(-200)<cr>

" NERDTREE
au default stdinreadpre * let s:std_in=1
au default vimenter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | winc p | ene | exe 'cd '.argv()[0] | en
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $HOME.'/.local/share/nvim/NERDTreeBookmarks'
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', '^tex', '\.aux$', '\.fdb_latexmk$', '\.fls$', '\.log$', '\.nav$', '\.out$', '\.snm$', '\.gz$', '\.toc$']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 2
let g:NERDTreeQuitOnOpen = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = ''
nn <silent> <leader>e :NERDTreeToggle<cr>

" RENAME TMUX
fu! RenameTmux()
    if !(bufname() =~# 'NERD' || bufname() =~# 'Tagbar')
        cal system('tmux renamew ' . expand('%:t'))
    en
endf
aug tmuxrename | au! | aug en
au tmuxrename bufenter,focusgained * cal RenameTmux()
au tmuxrename vimleave * cal system('tmux setw automatic-rename')

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
let g:slime_default_config = {"socket_name": "default", "target_pane": "{bottom}"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
let g:slime_paste_file = "/tmp/slime"
let g:slime_target = "tmux"
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

" TAGBAR
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_indent = 1
let g:tagbar_map_showproto = 'd'
let g:tagbar_silent = 1
let g:tagbar_sort = 0
hi tagbarhighlight cterm=none ctermbg=none ctermfg=8
hi tagbarkind      cterm=none ctermbg=none ctermfg=green
nn <silent> <leader>T :TagbarToggle<cr>
nn <silent> <leader>t :Tags<cr>

" VIMUX
let g:VimuxHeight = '35'
let g:VimuxUseNearest = 0
nn <silent> <leader>l :cal VimuxRunCommand('clear; lint ' . bufname('%'))<cr>
nn <silent> <leader>a :cal VimuxRunCommand('clear; execute ' . bufname('%'))<cr>
au default filetype tex nn <silent> <leader>a :VimtexCompile<cr>
nn <silent> <leader>v :cal VimuxZoomRunner()<cr>
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
       exe 'sil !wmctrl -xa zathura'
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
