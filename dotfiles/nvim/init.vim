" FIRST THINGS FIRST
aug default | au! | aug en
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
cal plug#begin('~/.local/share/nvim/plugins')

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'jpalardy/vim-slime', { 'for': ['python', 'sh'] }
Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files', 'Tags'] }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'machakann/vim-sandwich'
Plug 'rhysd/clever-f.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips', { 'for': ['markdown', 'python', 'sh', 'snippets', 'tex', 'vim'] }
Plug 'tpope/vim-commentary'
Plug 'yunake/vimux'

cal plug#end()

" APPEARANCE
" echo synIDattr(synID(line("."), col("."), 1), "name")
au default bufwritepost * GitGutter
au default filetype gitcommit,markdown,tex setl spell
colorscheme nord
hi comment       cterm=italic
hi cursorlinenr  ctermfg=none
hi diffadded     cterm=none   ctermbg=none ctermfg=green
hi diffremoved   cterm=none   ctermbg=none ctermfg=red
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

" BUFFERS
au default bufenter,focusgained * checkt
au default textchanged,insertleave * nested sil up
com! -nargs=+ SFZF exe 'e '.system('ffind -type f | sfzf <args> 2>/dev/null') | exe 'ec'
nn <leader>f :SFZF<space>
nn <leader>F :FZF!<cr>
nn <leader>b :Buffers!<cr>
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
let g:deoplete#enable_at_startup = 1
cal deoplete#custom#option({
    \ 'ignore_sources': { '_': ['around', 'member'] },
    \ 'max_list': 8,
    \ 'min_pattern_length': 1,
    \ 'num_processes': 1,
    \ })
cal deoplete#custom#source('_', 'matchers', [
    \ 'matcher_fuzzy',
    \ 'matcher_length',
    \ ])
cal deoplete#custom#var('omni', 'input_patterns', { 'tex': g:vimtex#re#deoplete })
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
let g:loaded_matchparen = 1
let g:loaded_node_provider = 1
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:python3_host_prog = '/bin/python'

" MISC-MAPPINGS
nn <silent> gs vip:sort iu<cr>
xn <silent> gs :sort iu<cr>
xn . :norm.<cr>
nm <leader>i <leader>hp
nm <leader>u <leader>hu
nn <c-f> 4<c-e>
nn <c-d> 4<c-y>
nm gcp gcip
nn cp cip
nn dp dap
nn Q <nop>
nn >p >ap
nn <p <ap

" MISC-SETTINGS
au default bufenter * se formatoptions-=cro
let g:fzf_preview_window = ''
let g:lexima_enable_endwise_rules = 0
let g:rooter_silent_chdir = 1
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
se commentstring=//\ %s
se expandtab shiftwidth=4 tabstop=4
se mouse=a notimeout
se shell=/bin/bash

" NETRW
let g:netrw_banner = 0
let g:netrw_browsex_viewer = $BROWSER
let g:netrw_dirhistmax = 0
let g:netrw_liststyle = 3
nnoremap <silent> <leader>e :Explore<cr>

" STATE
let state_ignore = ['gitcommit', 'gitrebase']
au default bufwinleave * if index(state_ignore, &ft) < 0 | sil! mkvie
au default bufwinenter * if index(state_ignore, &ft) < 0 | sil! lo
se viewoptions=cursor

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nn <leader>r :%s/\<<c-r><c-w>\>//g<left><left>
nn <silent> <esc> :noh <bar> ec <bar> cal clever_f#reset()<cr>
nn <silent> , *``
nn <silent> n nzz
nn <silent> N Nzz
se ignorecase smartcase
se inccommand=nosplit

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

" TMUXRENAME
fu! RenameTmux()
    if !(bufname() =~# 'NERD' || bufname() =~# 'Tagbar')
        cal system('tmux renamew ' . expand('%:t'))
    en
endf
au default bufenter,focusgained * cal RenameTmux()
au default vimleave * cal system('tmux setw automatic-rename')

" VIMUX
let g:VimuxHeight = '35'
let g:VimuxUseNearest = 0
nn <silent> <leader>a :cal VimuxRunCommand('execute ' . bufname('%'))<cr>
nn <silent> <leader>l :cal VimuxRunCommand('lint ' . bufname('%'))<cr>
nn <silent> <leader>x :VimuxCloseRunner<cr>

" VIMTEX
au default filetype tex nn <silent> <leader>a :VimtexCompile<cr>
au default filetype tex nnoremap <leader>t :cal vimtex#fzf#run()<cr>
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
