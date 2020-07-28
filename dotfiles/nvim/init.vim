" FIRST THINGS FIRST
aug group | au! | aug en
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
    sil !curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    au vimenter * PlugInstall --sync | so $MYVIMRC
en

cal plug#begin($XDG_DATA_HOME.'/nvim/plugins')

Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'astier/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cohama/lexima.vim'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'machakann/vim-sandwich'
Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips', { 'for': ['markdown', 'python', 'sh', 'snippets', 'tex', 'vim'] }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'

cal plug#end()

" BUFFERS
au group bufenter,focusgained * checkt
au group textchanged,insertleave * nested sil! up
com! -nargs=+ SFZF exe 'e' system('ffind -type f | sfzf <args> 2>/dev/null') | exe 'ec'
nn <silent> <a-e> :bp<cr>
nn <silent> <a-r> :bn<cr>
nn <silent> <tab> :b#<cr>
nn <space>F :ls<cr>:b<space>
nn <space>f :SFZF<space>
se noswapfile

" CLIPBOARD
ino <c-v> <esc>"+pa
nn <c-c> "+yy
nn <c-v> "+p
nn <c-x> "+dd
xn <c-c> "+y
xn <c-x> "+d

" COMMENTS
au group bufenter * se formatoptions-=cro
nm gcp gcip
se commentstring=//\ %s

" COMPLETION
let g:deoplete#enable_at_startup = 1
cal deoplete#custom#option({
    \ 'ignore_sources': { '_': ['around', 'member'] },
    \ 'max_list': 4,
    \ 'min_pattern_length': 1,
    \ 'num_processes': 1,
    \ })
cal deoplete#custom#source('_', 'matchers', [
    \ 'matcher_fuzzy',
    \ 'matcher_length',
    \ ])
cal deoplete#custom#var('omni', 'input_patterns', { 'tex': g:vimtex#re#deoplete })
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
nn <silent> <space>gf :cal Format()<cr>

" GITGUTTER
au group bufwritepost * GitGutter
nm <silent> <space>i :GitGutterPreviewHunk<cr>
nm <silent> <space>u :GitGutterUndoHunk<cr>

" KILL
nn <silent> <a-tab> :bd!<cr>
nn <silent> <space>c :clo<cr>
nn <silent> <space>d :qa!<cr>
nn <silent> <space>s <c-z>

" LATEX
au group filetype tex nn <silent> <space>a :VimtexCompile<cr>
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
let g:vimtex_compiler_callback_hooks = ['FocusViewer']
let g:vimtex_mappings_enabled = 0
let g:vimtex_matchparen_enabled = 0
let g:vimtex_view_general_viewer = 'zathura'
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

" LOADED
let g:loaded_gzip = 0
let g:loaded_matchparen = 0
let g:loaded_netrw = 0
let g:loaded_netrwPlugin = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_spellfile_plugin = 0
let g:loaded_tar = 0
let g:loaded_tarPlugin = 0
let g:loaded_zip = 0
let g:loaded_zipPlugin = 0
let g:python3_host_prog = '/usr/bin/python3'

" MISC
au group bufenter,focusgained * cal system('tmux renamew '.expand('%:t'))
au group vimleave * cal system('tmux setw automatic-rename')
au group filetype markdown se textwidth=80
let g:lexima_enable_endwise_rules = 0
let g:plug_window = 'enew'
nn <cr> o<esc>
nn <silent> <a-S> :so $MYVIMRC<cr>
nn <silent> gs vip:sort i<cr>
xn <silent> gs :sort i<cr>
se expandtab shiftwidth=4 tabstop=4
se mouse=a
se nojoinspaces
se notimeout

" NAVIGATION
let g:tmux_navigator_no_mappings = 1
nn <silent> <a-h> :TmuxNavigateLeft<cr>
nn <silent> <a-j> :TmuxNavigateDown<cr>
nn <silent> <a-k> :TmuxNavigateUp<cr>
nn <silent> <a-l> :TmuxNavigateRight<cr>
ino <silent> <a-h> <esc>:TmuxNavigateLeft<cr>
ino <silent> <a-j> <esc>:TmuxNavigateDown<cr>
ino <silent> <a-k> <esc>:TmuxNavigateUp<cr>
ino <silent> <a-l> <esc>:TmuxNavigateRight<cr>

" NERDTREE
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $XDG_DATA_HOME.'/nvim/NERDTreeBookmarks'
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', '^tex', '\.aux$', '\.fdb_latexmk$', '\.fls$', '\.log$', '\.nav$', '\.out$', '\.snm$', '\.gz$', '\.toc$']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 3
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = ''
nn <silent> <leader>e :NERDTreeToggle<cr>

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nn <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nn <silent> <esc> :noh <bar> ec <bar> cal clever_f#reset()<cr>
nn <silent> , *``
nn <silent> n nzz
nn <silent> N Nzz
se ignorecase smartcase
se inccommand=nosplit

" SHORTCUTS
nn <p <ap
nn >p >ap
nn cp cip
nn dp dap
nn Q <c-q>
nn vp vip
nn Y y$

" SNIPPETS
let g:UltiSnipsJumpBackwardTrigger = '<a-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories = [$XDG_CONFIG_HOME.'/nvim/UltiSnips']

" STATE
au group bufenter * if index(ignore_ft, &ft) < 0 | sil! lo
au group bufleave,vimleave * if index(ignore_ft, &ft) < 0 | sil! mkvie
let ignore_ft = ['diff', 'gitcommit', 'gitrebase']
se viewoptions=cursor

" THEME
" echo synIDattr(synID(line("."), col("."), 1), "name")
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

" UI
au group filetype gitcommit,markdown,tex setl spell
se fillchars+=eob:\ ,fold:\ ,stl:―,stlnc:―,vert:▏
se noruler noshowcmd noshowmode
se statusline=\  showtabline=0 laststatus=0 signcolumn=yes

" VIMUX
au group vimleave * VimuxCloseRunner
let g:VimuxHeight = '30'
let g:VimuxUseNearest = 0
nn <silent> <space>x :VimuxCloseRunner<cr>
nn <silent> <space>a :VimuxRunCommand('execute ' . bufname('%'))<cr>
nn <silent> <space>l :VimuxRunCommand('lint ' . bufname('%'))<cr>
nn <silent> <space><space> :VimuxRunCommand(getline('.'))<cr>
xn <silent> <space><space> "vy :VimuxRunCommand(@v)<cr>

" WINDOWS
au group vimresized * winc =
nn <a-f> 4<c-e>
nn <a-d> 4<c-y>
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
