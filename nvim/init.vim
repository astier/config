" FIRST THINGS FIRST
augroup group | autocmd! | augroup end
let mapleader = ' '
scriptencoding utf-8

packadd! clever-f
packadd! coc
packadd! commentary
packadd! easy-align
packadd! flog
packadd! fugitive
packadd! gitgutter
packadd! indent-object
packadd! lexima
packadd! nord
packadd! rooter
packadd! sandwich
packadd! sleuth
packadd! subversive
packadd! tabulous
packadd! tmux-navigator
packadd! vimtex
packadd! visual-star-search
packadd! vsnip
syntax on

" BUFFERS
autocmd group vimenter * if len(getbufinfo({'buflisted':1})) > 1 | bn | b# | endif
autocmd group bufenter,focusgained * checktime
autocmd group textchanged,insertleave * nested silent! update
nnoremap <silent> <a-e> :bp<cr>
nnoremap <silent> <a-r> :bn<cr>
tnoremap <silent> <a-e> <c-\><c-n>:bp<cr>
tnoremap <silent> <a-r> <c-\><c-n>:bn<cr>
nnoremap <silent> <tab> :b#<cr>
set noswapfile

" CLIPBOARD
inoremap <c-v> <esc>"+p
nnoremap <c-c> "+yy
nnoremap <c-v> "+p
xnoremap <c-c> "+y

" COMMENTS
autocmd group bufenter * set formatoptions-=cro
nmap gcp my vip gc `y
set commentstring=//\ %s

" COMPLETION
inoremap <expr> <a-c> pumvisible() ? "\<c-e>" : "\<a-c>"
set completeopt=menuone,noinsert
set infercase shortmess+=c
set pumheight=8 pumwidth=0

" EASY-ALIGN
nmap ga  <plug>(EasyAlign)
xmap ga  <plug>(EasyAlign)
xmap gaa <plug>(EasyAlign)*<space>

" EXPLORER
function! Open()
    let path = expand('%:p')
    if !isdirectory(path)
        " Fixes bug where the current directory is added two times
        " to the end of the path-variable
        let path = fnamemodify(path, ':h') . '/'
    endif
    let file = fnameescape(path . getline('.'))
    let mime = system('file -bL --mime-type ' . file)
    if isdirectory(file) || empty(glob(file)) || mime =~# '\(text/.*\|.*/json\|.*csv\)'
        execute "normal \<Plug>NetrwLocalBrowseCheck"
    else
        execute 'silent !open' file
    endif
endfunction
autocmd group filetype netrw nmap <buffer> <c-rightmouse> <Plug>NetrwSLeftmouse
autocmd group filetype netrw nmap <buffer> <cr> mf
autocmd group filetype netrw nnoremap <buffer><silent> <leftmouse> <leftmouse>:call Open()<cr>
autocmd group filetype netrw nnoremap <buffer><silent> <rightmouse> :silent! norm -<cr>
autocmd group filetype netrw nnoremap <buffer><silent> <space>e :Rexplore<cr>
autocmd group filetype netrw nnoremap <buffer><silent> h :silent! norm -<cr>
autocmd group filetype netrw nnoremap <buffer><silent> l :call Open()<cr>
let g:netrw_altfile = 1
let g:netrw_banner = 0
let g:netrw_browsex_viewer= 'open'
let g:netrw_dirhistmax = 0
let g:netrw_keepdir = 0
let g:netrw_list_hide = '^\.*/$'
nnoremap <silent> <rightmouse> :Explore <bar> :silent! /<c-r>=expand("%:t")<cr><cr>:nohl<cr>
nnoremap <silent> <space>e :Explore <bar> :silent! /<c-r>=expand("%:t")<cr><cr>:nohl<cr>

" FLOG
autocmd group filetype floggraph nmap <buffer> <rightmouse> <leftmouse><cr>
autocmd group filetype floggraph xmap <buffer> <rightmouse> <cr>
nnoremap <silent> <space>kk :Flog -all<cr>
nnoremap <silent> <space>kK :Flog -all -path=%<cr>

" FORMAT
function! Format()
    let l:save = winsaveview()
    execute 'ret! | silent up'
    call system('format ' . bufname('%'))
    execute 'e'
    call winrestview(l:save)
endfunction
nnoremap <silent> <space>gf :call Format()<cr>

" FZF
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
nnoremap <silent> <space>f :FZF<cr>

" GITGUTTER
autocmd group vimenter,bufwritepost * GitGutter
let g:gitgutter_map_keys = 0
nmap <space>i <Plug>(GitGutterPreviewHunk)
nmap <space>S <Plug>(GitGutterStageHunk)
nmap <space>u <Plug>(GitGutterUndoHunk)
nmap [c <Plug>(GitGutterPrevHunk)zz
nmap ]c <Plug>(GitGutterNextHunk)zz
set signcolumn=yes

" KILL
nnoremap <silent> <space>c :close<cr>
nnoremap <silent> <space>d :qa!<cr>
nnoremap <silent> <space>q :bn<bar>bd!#<cr>
nnoremap <silent> <space>s <c-z>

" LATEX
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
    \'callback' : 0,
    \'continuous' : 0,
    \'options' : [
        \'-verbose',
        \'-file-line-error',
        \'-synctex=0',
        \'-interaction=nonstopmode',
    \],
\}
autocmd group filetype tex nnoremap <silent> <space>a :VimtexCompile<cr>
autocmd user VimtexEventCompileSuccess call ViewPDF()
function! ViewPDF()
    if system('pidof zathura')
        execute 'silent !wmctrl -xa zathura'
    else
        execute 'VimtexView'
    endif
    execute 'ec'
endfunction

" LOADED
let g:loaded_gzip = 0
let g:loaded_matchparen = 0
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

" LSP
let g:coc_global_extensions = ['coc-json', 'coc-python', 'coc-vimtex']
nmap <silent> gd <plug>(coc-definition)zz
nmap <silent> gR <plug>(coc-references)
nmap <silent> gr <plug>(coc-rename)
nnoremap <silent> K :cal <sid>show_documentation()<cr>
function! s:show_documentation()
    if index(['vim','help'], &filetype) >= 0
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" MISC
autocmd group filetype diff set textwidth=72
autocmd group filetype gitcommit,markdown,tex setlocal spell
autocmd group filetype hog set ft=udevrules
autocmd group filetype markdown set textwidth=80
autocmd group vimresized * wincmd =
let g:lexima_enable_endwise_rules = 0
let g:plug_window = 'enew'
set expandtab shiftwidth=4 tabstop=4
set nofoldenable
set nojoinspaces
set notimeout
set splitbelow splitright
set virtualedit=block
set wildmode=longest,list

" MOUSE
nmap <silent> <2-rightmouse> <rightmouse>
nmap <silent> <3-rightmouse> <rightmouse>
nmap <silent> <4-rightmouse> <rightmouse>
set mouse=a
set mousemodel=popup

" NAVIGATION
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
inoremap <silent> <a-h> <esc>:TmuxNavigateLeft<cr>
inoremap <silent> <a-j> <esc>:TmuxNavigateDown<cr>
inoremap <silent> <a-k> <esc>:TmuxNavigateUp<cr>
inoremap <silent> <a-l> <esc>:TmuxNavigateRight<cr>
tnoremap <silent> <a-h> <c-\><c-n>:TmuxNavigateLeft<cr>
tnoremap <silent> <a-j> <c-\><c-n>:TmuxNavigateDown<cr>
tnoremap <silent> <a-k> <c-\><c-n>:TmuxNavigateUp<cr>
tnoremap <silent> <a-l> <c-\><c-n>:TmuxNavigateRight<cr>

" ROOTER
autocmd group vimenter * Rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_manual_only = 1
let g:rooter_patterns = ['.git']
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nnoremap <silent> <esc> :noh <bar> ec <bar> call clever_f#reset()<cr>
nnoremap <silent> , *``
xmap     <silent> , *``
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
set ignorecase smartcase
set inccommand=nosplit

" SHORTCUTS
autocmd group filetype * if index(['floggraph'], &ft) < 0 | nnoremap <buffer> gqp gqip | endif
autocmd group filetype * if index(['floggraph'], &ft) < 0 | nnoremap <buffer> gqq Vgq | endif
nnoremap <a-d> 4<c-y>
nnoremap <a-f> 4<c-e>
nnoremap <p <ap
nnoremap >p >ap
nnoremap cp cip
nnoremap cw ciw
nnoremap cW ciW
nnoremap dp dap
nnoremap dw daw
nnoremap dW daW
nnoremap gg gg0
nnoremap Q <c-q>
nnoremap vp vip
nnoremap Y y$
nnoremap yp my yip `y
nnoremap yw my yiw `y
nnoremap yW my yiW `y
nnoremap { {zz
nnoremap } }zz
nnoremap ; `

" SNIPPETS
let g:vsnip_snippet_dir = $XDG_CONFIG_HOME.'/nvim/snippets'
imap <silent> <expr> <tab> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
smap <silent> <expr> <tab> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
imap <silent> <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-expand-prev)' : '<a-tab>'
smap <silent> <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-expand-prev)' : '<a-tab>'

" SORT
nmap     <silent> gsi my vii :sort i<cr> `y
nnoremap <silent> gss my vip :sort i<cr> `y
xnoremap <silent> gs  my :sort i<cr> `y

" STATE
autocmd group bufwinenter * if index(ignore_ft, &ft) < 0 | silent! loadview | endif
autocmd group bufwinleave * if index(ignore_ft, &ft) < 0 | silent! mkview | endif
let ignore_ft = ['diff', 'gitcommit', 'gitrebase']
set viewoptions=cursor

" SUBVERSIVE
let g:subversivePromptWithCurrent = 1
let g:subversivePreserveCursorPosition = 1
nmap s  <plug>(SubversiveSubstitute)
xmap s  <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S  <plug>(SubversiveSubstituteToEndOfLine)
nmap <space>r <plug>(SubversiveSubstituteWordRange)ie
xmap <space>r <plug>(SubversiveSubstituteRange)ie
xnoremap ie <esc>ggVG
onoremap ie :execute "norm! ggVG"<cr>

" THEME
" echo synIDattr(synID(line("."), col("."), 1), "name")
colorscheme nord
highlight comment cterm=italic
highlight diffadded cterm=none ctermbg=none ctermfg=green
highlight diffremoved cterm=none ctermbg=none ctermfg=red
highlight errormsg ctermbg=none
highlight function ctermfg=none
highlight matchparen cterm=none ctermbg=none ctermfg=none
highlight netrwMarkFile cterm=bold ctermfg=yellow
highlight pmenusel ctermfg=none
highlight search cterm=bold ctermbg=none ctermfg=red
highlight vimaugroup ctermfg=none
highlight vimmaprhs ctermfg=none
highlight vimnotation ctermfg=none
highlight warningmsg ctermbg=none ctermfg=none
set cursorline | highlight clear cursorline

" STATUSLINE
highlight statusline ctermbg=none ctermfg=8
highlight statuslinenc ctermbg=none ctermfg=8
highlight vertsplit ctermbg=none ctermfg=8
set fillchars+=eob:\ ,fold:\ ,stl:―,stlnc:―,vert:▏
set noruler noshowcmd noshowmode laststatus=0
set rulerformat=%=%l/%L
function! StatusLine()
    if empty(expand('%'))
        return repeat('―', winwidth(0))
    endif
    let left = '―[' . substitute(expand('%'), '^[^/]*\/', '', '') . ']'
    let right = '[' . line('.') . '/' . line('$') . ']'
    return left . repeat('―', winwidth(0) - len(left) - len(right)) . right
endfunction
set statusline=\ 

" TABLINE
highlight tabline ctermbg=none ctermfg=8
highlight tablinefill ctermbg=none
highlight tablinesel ctermbg=none ctermfg=none
let g:tabulousCloseStr = ''
let g:tabulousLabelLeftStr = '['
let g:tabulousLabelNameDefault = 'Empty'
let g:tabulousLabelNameOptions = ':t'
let g:tabulousLabelRightStr = '] '
set showtabline=1

" TERMINAL
autocmd group bufenter,focusgained,termopen,winenter term://* star
autocmd group termopen * nnoremap <buffer><leftrelease> <leftrelease>i
autocmd group termopen * setl hidden signcolumn=no
nnoremap <silent> <a-tab> :terminal<cr>
tnoremap <silent> <a-tab> <c-\><c-n> :b#<cr>
tnoremap <a-F> <c-\><c-n>
set shell=/usr/bin/bash
if executable('nvr')
    let $EDITOR='nvr'
    let $GIT_EDITOR = 'nvr --remote-wait-silent'
    let $MANPAGER='nvr +"se ft=man" -'
endif

" TMUXRENAME
function! TmuxRename()
    call system('tmux renamew ' . expand('%:t'))
endfunction
autocmd group bufenter,focusgained * call TmuxRename()
autocmd group vimleave,vimsuspend * call system('tmux setw automatic-rename')

" TMUXSEND
function! T(...)
    if !empty(system('tmux has -t $(cat /tmp/tmuxsend)'))
        execute system('tmux neww -ac "#{pane_current_path}" -PF "#{pane_id}" > /tmp/tmuxsend')
        silent !tmux lastp
    endif
    execute system('tmux send -t $(cat /tmp/tmuxsend) ' . shellescape(join(a:000)) . ' ENTER')
    if system('tmux display -p "#{window_id}"') != system('tmux display -pt $(cat /tmp/tmuxsend) "#{window_id}"')
        silent !tmux selectw -t $(cat /tmp/tmuxsend)
    endif
endfunction
command! -complete=shellcmd -nargs=+ T call T(expandcmd(<q-args>))
nnoremap <silent> <space><space> :call T(getline('.'))<cr>
xnoremap <silent> <space><space> "vy :call T(substitute(@v, '\n$', '', ''))<cr>
nnoremap <silent> <space>l :T lint %<cr>
nnoremap <silent> <space>a :T execute<cr>

" WRAP
nnoremap $ g$
nnoremap 0 g0
nnoremap j gj
nnoremap k gk
xnoremap $ g$
xnoremap 0 g0
xnoremap j gj
xnoremap k gk
set breakindent linebreak
