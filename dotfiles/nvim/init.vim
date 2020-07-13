" FIRST THINGS FIRST
aug group | au! | aug en
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  sil !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au vimenter * PlugInstall --sync | so $MYVIMRC
en

cal plug#begin('~/.local/share/nvim/plugins')

Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'kassio/neoterm'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'machakann/vim-sandwich'
Plug 'rhysd/clever-f.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips', { 'for': ['markdown', 'python', 'sh', 'snippets', 'tex', 'vim'] }
Plug 'tpope/vim-commentary'

cal plug#end()

" APPEARANCE
" echo synIDattr(synID(line("."), col("."), 1), "name")
au group bufwritepost * GitGutter
au group filetype gitcommit,markdown,tex setl spell
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
hi statusline    ctermbg=none ctermfg=0
hi statuslinenc  ctermbg=none ctermfg=0
hi tabline       ctermbg=none ctermfg=8
hi tablinefill   ctermbg=none
hi tablinesel    ctermbg=none ctermfg=none
hi vertsplit     ctermbg=none ctermfg=0
hi vimaugroup    ctermfg=none
hi vimmaprhs     ctermfg=none
hi vimnotation   ctermfg=none
hi warningmsg    ctermbg=none ctermfg=none
se cursorline | hi clear cursorline
se fillchars+=eob:\ ,fold:\ ,stl:―,stlnc:―,vert:▏
se noruler noshowcmd noshowmode
se statusline=\  showtabline=0 laststatus=0 signcolumn=yes

" BUFFERS
au group bufenter,focusgained * checkt
au group textchanged,insertleave * nested sil up
com! -nargs=+ SFZF exe 'e ' system('ffind -type f | sfzf <args> 2>/dev/null') | exe 'ec'
nn <leader>f :SFZF<space>
nn <leader>b :ls<cr>:b<space>
nn <silent> <a-e> :bp<cr>
nn <silent> <a-r> :bn<cr>
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
nn <silent> <a-c> :clo<cr>
nn <silent> <a-d> :bd!<cr>
nn <silent> <a-q> :qa<cr>
tno <silent> <a-c> <c-\><c-n>:clo<cr>
tno <silent> <a-d> <c-\><c-n>:bd!<cr>
tno <silent> <a-q> <c-\><c-n>:qa<cr>

" LOADED
let g:loaded_gzip = 1
let g:loaded_matchparen = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_node_provider = 1
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 1
let g:loaded_ruby_provider = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:python3_host_prog = '/usr/bin/python3'

" MISC-MAPPINGS
nn <silent> <a-S> :so $MYVIMRC<cr>
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
au group bufenter * se formatoptions-=cro
let g:lexima_enable_endwise_rules = 0
let g:rooter_silent_chdir = 1
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
se commentstring=//\ %s
se expandtab shiftwidth=4 tabstop=4
se mouse=a notimeout

" STATE
let state_ignore = ['gitcommit', 'gitrebase']
au group bufwinleave * if index(state_ignore, &ft) < 0 | sil! mkvie
au group bufwinenter * if index(state_ignore, &ft) < 0 | sil! lo
se viewoptions=cursor

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nn <leader>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nn <silent> <esc> :noh <bar> ec <bar> cal clever_f#reset()<cr>
nn <silent> , *``
nn <silent> n nzz
nn <silent> N Nzz
se ignorecase smartcase
se inccommand=nosplit

" SNIPPETS
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<a-tab>'
let g:UltiSnipsSnippetDirectories = [$XDG_CONFIG_HOME.'/nvim/UltiSnips']

" TERMINAL
au group bufenter,focusgained,termopen,winenter term://* star
au group termopen * nn <buffer><leftrelease> <leftrelease>i
au group termopen * setl nobuflisted hidden signcolumn=no
au group bufdelete * if len(getbufinfo({'buflisted':1})) == 2 && bufname("$") == '' | b term://* | bw# | star | en " delete empty buffer after last buffer gets deleted and switch to terminal
au group bufdelete COMMIT_EDITMSG,git* let git=1
au group bufenter * if exists('git') | unlet git | b term://* | star | en
if executable('nvr') | let $EDITOR='nvr' | let $GIT_EDITOR = 'nvr --remote-wait' | en
se shell=/bin/bash
tno <a-f> <c-\><c-n>
tno <a-:> <c-\><c-n>:

" NEOTERM
let g:neoterm_automap_keys = ''
fu! To()
    let g:blast = bufname('%') | Topen
endf
nmap <leader><leader> <Plug>(neoterm-repl-send-line)
xmap <leader><leader> <Plug>(neoterm-repl-send)
nn <silent> <leader>a :cal To() <bar> exe 'T execute' g:blast<cr>
nn <silent> <leader>l :cal To() <bar> exe 'T lint' g:blast<cr>
nn <silent> <a-s> :cal To()<cr>
tno <silent> <a-s> <c-\><c-n>:exe 'b' g:blast<cr>
tno <silent> <a-e> <c-\><c-n>:Tprevious<cr>
tno <silent> <a-r> <c-\><c-n>:Tnext<cr>

" TMUXRENAME
fu! RenameTmux()
    if !(bufname() =~# 'NERD' || bufname() =~# 'Tagbar')
        cal system('tmux renamew ' . expand('%:t'))
    en
endf
au group bufenter,focusgained * cal RenameTmux()
au group vimleave * cal system('tmux setw automatic-rename')

" VIMTEX
au group filetype tex nn <silent> <leader>a :VimtexCompile<cr>
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
au group vimresized * winc =
let g:tmux_navigator_no_mappings = 1
nn <silent> <a-h> :TmuxNavigateLeft<cr>
nn <silent> <a-j> :TmuxNavigateDown<cr>
nn <silent> <a-k> :TmuxNavigateUp<cr>
nn <silent> <a-l> :TmuxNavigateRight<cr>
ino <silent> <a-h> <esc>:TmuxNavigateLeft<cr>
ino <silent> <a-j> <esc>:TmuxNavigateDown<cr>
ino <silent> <a-k> <esc>:TmuxNavigateUp<cr>
ino <silent> <a-l> <esc>:TmuxNavigateRight<cr>
tno <silent> <a-h> <c-\><c-n>:TmuxNavigateLeft<cr>
tno <silent> <a-j> <c-\><c-n>:TmuxNavigateDown<cr>
tno <silent> <a-k> <c-\><c-n>:TmuxNavigateUp<cr>
tno <silent> <a-l> <c-\><c-n>:TmuxNavigateRight<cr>
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
