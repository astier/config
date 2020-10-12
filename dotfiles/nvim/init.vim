" FIRST THINGS FIRST
augroup group | autocmd! | augroup end
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
    silent !curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd vimenter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin($XDG_DATA_HOME.'/nvim/plugins')
    Plug 'airblade/vim-gitgutter'
    Plug 'airblade/vim-rooter'
    Plug 'arcticicestudio/nord-vim'
    Plug 'astier/tabulous'
    Plug 'bronson/vim-visual-star-search'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'cohama/lexima.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'lervag/vimtex', { 'for': 'tex' }
    Plug 'machakann/vim-sandwich'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'neovim/nvim-lspconfig'
    Plug 'rbong/vim-flog'
    Plug 'rhysd/clever-f.vim'
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Shougo/deoplete-lsp'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neopairs.vim', { 'for': 'python' }
    Plug 'SirVer/ultisnips', { 'for': ['c', 'cpp', 'markdown', 'sh', 'snippets', 'tex', 'vim'] }
    Plug 'svermeulen/vim-subversive'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sleuth'
call plug#end()

" BUFFERS
autocmd group vimenter * if len(getbufinfo({'buflisted':1})) > 1 | bn | b# | endif
autocmd group bufenter,focusgained * checktime
autocmd group textchanged,insertleave * nested silent! update
nnoremap <silent> <a-e> :bp<cr>
nnoremap <silent> <a-r> :bn<cr>
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

" DEOPLETE
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
    \'ignore_sources': { '_': ['around', 'member'] },
    \'min_pattern_length': 1,
    \'num_processes': 2,
\})
call deoplete#custom#source('_', 'matchers', [
    \'matcher_fuzzy',
    \'matcher_length',
\])
call deoplete#custom#source('_', 'converters', [
    \'converter_word_abbr',
    \'converter_auto_paren',
\])

" EASY-ALIGN
nmap ga  <plug>(EasyAlign)
xmap ga  <plug>(EasyAlign)
xmap gaa <plug>(EasyAlign)*<space>

" EXPLORER
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeBookmarksFile = $XDG_DATA_HOME.'/nvim/NERDTreeBookmarks'
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeIgnore = ['.git', '__pycache__', 'tags', '^tex', '\.aux$', '\.fdb_latexmk$', '\.fls$', '\.log$', '\.nav$', '\.out$', '\.snm$', '\.gz$', '\.toc$']
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 3
let g:NERDTreeShowHidden = 1
let g:NERDTreeStatusline = ''
let g:NERDTreeWinPos = "right"
nnoremap <silent> <rightmouse> :NERDTreeToggle<cr>
nnoremap <silent> <space>e :NERDTreeToggle<cr>

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
autocmd group filetype tex call deoplete#custom#var('omni', 'input_patterns', { 'tex': g:vimtex#re#deoplete })
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
let g:loaded_netrw = 0
let g:loaded_netrwPlugin = 0
let g:loaded_netrwSettings = 0
let g:loaded_netrwFileHandlers = 0
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

" LSP
autocmd group filetype python call SetupLSP()
function! SetupLSP()
    nnoremap <silent> gd :lua vim.lsp.buf.definition()<cr>
    nnoremap <silent> gp :lua vim.lsp.buf.signature_help()<cr>
    nnoremap <silent> gR :lua vim.lsp.buf.references()<cr>
    nnoremap <silent> gr :lua vim.lsp.buf.rename()<cr>
    nnoremap <silent> K  :lua vim.lsp.buf.hover()<cr>
endfunction
lua require 'nvim_lsp'.jedi_language_server.setup{}
lua vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end

" MISC
autocmd group filetype diff set textwidth=72
autocmd group filetype gitcommit,markdown,tex setlocal spell
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

" PLUG
nnoremap <silent> <space>pc :PlugClean<cr>
nnoremap <silent> <space>pi :PlugInstall<cr>
nnoremap <silent> <space>pp :PlugUpgrade <bar> PlugUpdate<cr>

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
let g:UltiSnipsJumpBackwardTrigger = '<a-tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsSnippetDirectories  = [$XDG_CONFIG_HOME.'/nvim/UltiSnips']

" SORT
nmap     <silent> gsi my vii :sort i<cr> `y
nnoremap <silent> gss my vip :sort i<cr> `y
xnoremap <silent> gs  my :sort i<cr> `y

" STATE
autocmd group bufread * if index(ignore_ft, &ft) < 0 | silent! loadview | endif
autocmd group bufunload * if index(ignore_ft, &ft) < 0 | silent! mkview | endif
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
function StatusLine()
    if bufname() =~# 'NERD' || empty(expand('%'))
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

" TMUXRENAME
function! TmuxRename()
    if !(bufname() =~# 'NERD' || bufname() =~# 'Tagbar')
        call system('tmux renamew ' . expand('%:t'))
    endif
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
