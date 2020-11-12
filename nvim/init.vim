" FIRST THINGS FIRST
augroup group | autocmd! | augroup end
let mapleader = ' '
scriptencoding utf-8

packadd! coc
packadd! commentary
packadd! flog
packadd! fugitive
packadd! gitgutter
packadd! indent-object
packadd! lexima
packadd! nord
packadd! sandwich
packadd! sleuth
packadd! subversive
packadd! tmux-navigator
packadd! vimtex
packadd! vsnip
syntax on

" APPEARANCE (echo synIDattr(synID(line("."), col("."), 1), "name"))
colorscheme nord
highlight comment cterm=italic
highlight diffadded cterm=none ctermbg=none ctermfg=green
highlight diffremoved cterm=none ctermbg=none ctermfg=red
highlight errormsg ctermbg=none
highlight function ctermfg=none
highlight matchparen cterm=none ctermbg=none ctermfg=none
highlight vimaugroup ctermfg=none
highlight vimmaprhs ctermfg=none
highlight vimnotation ctermfg=none
highlight warningmsg ctermbg=none ctermfg=none
set cursorline | highlight clear cursorline

" BUFFERS
autocmd group bufenter,focusgained * checktime
autocmd group textchanged,insertleave * nested silent! update
autocmd group vimenter * if len(getbufinfo({'buflisted':1})) > 1 | bn | b# | endif
nnoremap <a-tab> :ls<cr>:b<space>
nnoremap <silent> <a-e> :bp<cr>
nnoremap <silent> <a-r> :bn<cr>
nnoremap <silent> <space>f :FZF<cr>
nnoremap <silent> <tab> :b#<cr>
nnoremap <silent> t :tabn<cr>

" COMMENTS
autocmd group bufenter * set formatoptions-=cro
nmap gcp my vip gc `y
set commentstring=//\ %s

" COMPLETION
highlight pmenusel ctermfg=none
inoremap <expr> <c-k> pumvisible() ? "\<c-e>" : "\<c-k>"
set completeopt=menuone,noinsert
set infercase shortmess+=c
set pumheight=8 pumwidth=0

" EDITING - CHANGE
nmap cp cip
nmap cw ciw
nmap cW ciW
nnoremap c "_c
nnoremap C "_C
xnoremap c "_c

" EDITING - COPY
nnoremap Y y$
nnoremap yp my yip `y
nnoremap yw my yiw `y
nnoremap yW my yiW `y

" EDITING - CUT
nnoremap dp dap
nnoremap dw daw
nnoremap dW daW

" EDITING - PASTE
inoremap <c-v> <c-o>p
let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1
nmap s  <plug>(SubversiveSubstitute)
nmap S  <plug>(SubversiveSubstituteToEndOfLine)
nmap ss <plug>(SubversiveSubstituteLine)
xmap s  <plug>(SubversiveSubstitute)

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
highlight netrwMarkFile cterm=bold ctermfg=yellow
let g:netrw_altfile = 1
let g:netrw_banner = 0
let g:netrw_browsex_viewer= 'open'
let g:netrw_dirhistmax = 0
let g:netrw_keepdir = 0
let g:netrw_list_hide = '^\.*/$'
nnoremap <silent> <rightmouse> :Explore <bar> :silent! /<c-r>=expand("%:t")<cr><cr>:nohl<cr>
nnoremap <silent> <space>e :Explore <bar> :silent! /<c-r>=expand("%:t")<cr><cr>:nohl<cr>

" FLOG
autocmd group filetype * if index(['floggraph'], &ft) < 0 | nnoremap <buffer> gqp gqip | endif
autocmd group filetype * if index(['floggraph'], &ft) < 0 | nnoremap <buffer> gqq Vgq | endif
autocmd group filetype floggraph nmap <buffer> <rightmouse> <leftmouse><cr>
autocmd group filetype floggraph xmap <buffer> <rightmouse> <cr>
nnoremap <silent> <space>kd :Gdiff<cr>
nnoremap <silent> <space>kK :Flog -all -path=%<cr>
nnoremap <silent> <space>kk :Flog -all<cr>

" FORMAT
function! Format()
    let l:save = winsaveview()
    execute 'ret! | silent up'
    call system('format ' . bufname('%'))
    execute 'e'
    call winrestview(l:save)
endfunction
nnoremap <silent> <space>gf :call Format()<cr>

" GITGUTTER
autocmd group vimenter,bufwritepost * GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
nmap <space>i <Plug>(GitGutterPreviewHunk)
nmap <space>S <Plug>(GitGutterStageHunk)
nmap <space>u <Plug>(GitGutterUndoHunk)
nmap [c <Plug>(GitGutterPrevHunk)zz
nmap ]c <Plug>(GitGutterNextHunk)zz
set signcolumn=yes

" KILL
nnoremap <silent> <space>c :close<cr>
nnoremap <silent> <space>C :wincmd z<cr>
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

" LEXIMA
let g:lexima_ctrlh_as_backspace = 1
let g:lexima_enable_endwise_rules = 0
let g:lexima_map_escape = ''

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
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:plug_window = 'enew'
set clipboard=unnamedplus
set expandtab shiftwidth=4 tabstop=4
set nofoldenable
set nojoinspaces
set noswapfile
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
inoremap <silent> <a-h> <c-o>:TmuxNavigateLeft<cr>
inoremap <silent> <a-j> <c-o>:TmuxNavigateDown<cr>
inoremap <silent> <a-k> <c-o>:TmuxNavigateUp<cr>
inoremap <silent> <a-l> <c-o>:TmuxNavigateRight<cr>

" SEARCH
highlight incsearch cterm=none ctermbg=yellow ctermfg=black
highlight search    cterm=none ctermbg=none   ctermfg=red
nnoremap / <nop>
nnoremap ? <nop>
nnoremap f /
nnoremap F ?
nnoremap <silent> <esc> :noh <bar> echo<cr>
nnoremap <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nnoremap <silent> , :let @/= expand('<cword>') <bar> set hlsearch <cr>
xnoremap <silent> , :<c-u>let @/= getline(".")[getpos("'<")[2] - 1:getpos("'>")[2] - 1] <bar> set hlsearch <cr>
set ignorecase smartcase
set inccommand=nosplit

" SHORTCUTS
inoremap <c-l> <esc>la
nnoremap <a-d> 4<c-y>
nnoremap <a-f> 4<c-e>
nnoremap <cr> o<esc>
nnoremap <p <ap
nnoremap >p >ap
nnoremap gg gg0
nnoremap Q <c-q>
nnoremap vp vip
nnoremap { {zz
nnoremap } }zz

" SNIPPETS
let g:vsnip_snippet_dir = $XDG_CONFIG_HOME.'/nvim/snippets'
imap <silent> <expr> <tab>   vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
smap <silent> <expr> <tab>   vsnip#available(1) ? '<plug>(vsnip-expand-or-next)' : '<tab>'
imap <silent> <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)'      : '<a-tab>'
smap <silent> <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)'      : '<a-tab>'

" SORT
nmap     <silent> gsi my vii :sort i<cr> `y
nnoremap <silent> gss my vip :sort i<cr> `y
xnoremap <silent> gs  my :sort i<cr> `y

" STATE
autocmd group bufwinenter * if index(ignore_ft, &ft) < 0 | silent! loadview | endif
autocmd group bufwinleave * if index(ignore_ft, &ft) < 0 | silent! mkview | endif
let ignore_ft = ['diff', 'gitcommit', 'gitrebase']
set viewoptions=cursor

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
set showtabline=0

" TMUX
autocmd group vimenter,vimresume,focusgained * call system('tmux renamew "#{b:pane_current_path}"')
autocmd group vimleave,vimsuspend * call system('tmux setw automatic-rename')
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
