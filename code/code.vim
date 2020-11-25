" FIRST THINGS FIRST
aug group | au! | aug end
let mapleader = ' '
scriptencoding utf-8

pa! commentary
pa! indent-object
pa! sandwich
pa! subversive
pa! switch
pa! targets

" CODE
nn <silent> <space>i :call VSCodeNotify('git.openChange')<cr>
nn <silent> <space>u :call VSCodeNotify('git.revertSelectedRanges')<cr>
nn <silent> : :call VSCodeNotify('workbench.action.showCommands')<cr>

" EDITING - CHANGE
nm cp cip
nm cw ciw
nm cW ciW
nn c "_c
nn C "_C
xn c "_c

" EDITING - COPY
nn Y y$
nn yp my yip `y
nn yw my yiw `y
nn yW my yiW `y

" EDITING - CUT
nn dp dap
nn dw daw
nn dW daW

" EDITING - PASTE
ino <c-v> <c-o>p
let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1
nm s  <plug>(SubversiveSubstitute)
nm S  <plug>(SubversiveSubstituteToEndOfLine)
nm ss <plug>(SubversiveSubstituteLine)
xm s  <plug>(SubversiveSubstitute)

" LOADED
let g:loaded_gzip = 0
let g:loaded_matchparen = 0
let g:loaded_netrw = 0
let g:loaded_netrwFileHandlers = 0
let g:loaded_netrwPlugin = 0
let g:loaded_netrwSettings = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_spellfile_plugin = 0
let g:loaded_tar = 0
let g:loaded_tarPlugin = 0
let g:loaded_zip = 0
let g:loaded_zipPlugin = 0

" MISC
au group filetype diff se textwidth=72
au group filetype hog se ft=udevrules
au group filetype markdown se textwidth=80
se clipboard=unnamedplus
se expandtab shiftwidth=4 tabstop=4
se hidden
se laststatus=0 showtabline=0
se nofoldenable
se nojoinspaces
se noruler noshowcmd noshowmode
se noswapfile
se notimeout
se virtualedit=block

" OBJECTS
au User targets#mappings#user cal targets#mappings#extend({
    \ 'd': {'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}]},
    \ 's': {'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]},
    \ 'b': {}, 'q': {},
\ })
let g:textobj_sandwich_no_default_key_mappings = 1
nm cd cId
nm cs cIs

" SEARCH
nn <silent> n nzz
nn <silent> N Nzz
nn / <nop>
nn ? <nop>
nn f /
nn F ?
nn <silent> <esc> :noh <bar> echo<cr>
nn <silent> , :let @/= expand('<cword>') <bar> se hlsearch <cr>
xn <silent> , :<c-u>let @/= getline(".")[getpos("'<")[2] - 1:getpos("'>")[2] - 1] <bar> se hlsearch <cr>
se ignorecase smartcase

" SHORTCUTS
ino <c-l> <esc>la
nm gcp my vip gc `y
nn <a-d> 4<c-y>
nn <a-f> 4<c-e>
nn <cr> o<esc>
nn <p <ap
nn >p >ap
nn gg gg0
nn Q <c-q>
nn vp vip
nn { {zz
nn } }zz

" SORT
nm <silent> gsi my vii :sort i<cr> `y
nn <silent> gss my vip :sort i<cr> `y
xn <silent> gs  my :sort i<cr> `y

" SWITCH
au group filetype gitrebase let b:switch_custom_definitions = [['pick', 'f', 'r', 'd']]
let g:switch_custom_definitions = [['0', '1'], ['==', '!=']]
let g:switch_mapping = 't'

" WRAP & FOLD
nm $ g$
nm 0 g0
nm j gj
nm k gk
xm $ g$
xm 0 g0
xm j gj
xm k gk
