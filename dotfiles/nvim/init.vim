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
    Plug 'hrsh7th/vim-vsnip', { 'for': ['markdown', 'python', 'sh', 'tex', 'vim'] }
    Plug 'junegunn/fzf.vim', { 'on': ['Buffers', 'Files', 'Tags'] }
    Plug 'lervag/vimtex', { 'for': 'tex' }
    Plug 'machakann/vim-sandwich'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'nvim-lua/completion-nvim'
    Plug 'rhysd/clever-f.vim'
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'steelsojka/completion-buffers'
    Plug 'svermeulen/vim-subversive'
    Plug 'tpope/vim-sleuth'
    Plug 'tyru/caw.vim'
cal plug#end()

" BUFFERS
au group bufenter,focusgained * checkt
au group textchanged,insertleave * nested sil! up
com! -nargs=+ FZFF exe 'e' system('ffind -type f | fzf --filter="<args>" | head -n1') | exe 'ec'
nn <silent> <a-e> :bp<cr>
nn <silent> <a-r> :bn<cr>
nn <silent> <tab> :b#<cr>
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
nm gci mm vii gcc `m
nm gcp mm vip gcc `m
se commentstring=//\ %s

" COMPLETION
au bufenter * lua require'completion'.on_attach()
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = [ 'exact', 'substring', 'fuzzy']
let g:completion_sorting = "length"
let g:completion_chain_complete_list = [
    \{'complete_items': ['path']},
    \{'complete_items': ['buffers']},
\]
se completeopt=menuone,noinsert shortmess+=c

" FORMAT
fu! Format()
    let l:save = winsaveview()
    exe 'ret! | sil up'
    cal system('format ' . bufname('%'))
    exe 'e'
    cal winrestview(l:save)
endf
nn <silent> <space>gf :cal Format()<cr>

" FZF
au group filetype fzf set laststatus=0
au group bufleave fzf set laststatus=2
let g:fzf_preview_window = ''
nn <silent> <space>b :Buffers<cr>
nn <silent> <space>F :Files<cr>
nn <silent> <space>f :FZFF<space>
nn <silent> <space>t :Tags<cr>
au group filetype tex nn <space>t :cal vimtex#fzf#run()<cr>

" GITGUTTER
au group bufwritepost * GitGutter
nm <silent> <space>i <Plug>(GitGutterPreviewHunk)
nm <silent> <space>S <Plug>(GitGutterStageHunk)
nm <silent> <space>u <Plug>(GitGutterUndoHunk)
nm <silent> [c <Plug>(GitGutterPrevHunk)zz
nm <silent> ]c <Plug>(GitGutterNextHunk)zz
se signcolumn=yes

" KILL
nn <silent> <a-tab> :bn<bar>bd#<cr>
nn <silent> <space>c :clo<cr>
nn <silent> <space>d :qa!<cr>
nn <silent> <space>s <c-z>

" LATEX
let g:tex_flavor = 'latex'
let g:tex_no_error = 1
let g:vimtex_mappings_enabled = 0
let g:vimtex_matchparen_enabled = 0
let g:vimtex_view_general_viewer = 'zathura'
let g:vimtex_compiler_latexmk = {
    \'callback' : 0,
    \'continuous' : 0,
    \'options' : [
    \  '-verbose',
    \  '-file-line-error',
    \  '-synctex=0',
    \  '-interaction=nonstopmode',
    \],
\}
au group filetype tex nn <silent> <space>a :VimtexCompile<cr>
au user VimtexEventCompileSuccess tex :cal ViewPDF()<cr>
fu! ViewPDF()
    if system('pidof zathura')
        exe 'sil !wmctrl -xa zathura'
    el
        exe 'VimtexView'
    en
    exe 'ec'
endf

" LOADED
let g:loaded_gzip = 0
let g:loaded_netrw = 0
let g:loaded_netrwPlugin = 0
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
au group vimenter,vimresume,focusgained * cal system('tmux renamew "#{b:pane_current_path}"')
au group vimleave,vimsuspend,focuslost * cal system('tmux setw automatic-rename')
au group filetype gitcommit,markdown,tex setl spell
au group filetype markdown se textwidth=80
au group vimresized * winc =
let g:lexima_enable_endwise_rules = 0
let g:plug_window = 'enew'
nn <silent> <a-S> :so $MYVIMRC<cr>
se expandtab shiftwidth=4 tabstop=4
se mouse=a
se nojoinspaces
se notimeout
se splitbelow splitright
se wildmode=longest,list

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
nn <silent> <space>e :NERDTreeToggle<cr>

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nn <silent> <esc> :noh <bar> ec <bar> cal clever_f#reset()<cr>
nn <silent> , *``
nn <silent> n nzz
nn <silent> N Nzz
se ignorecase smartcase
se inccommand=nosplit

" SHORTCUTS
nn <a-d> 4<c-y>
nn <a-f> 4<c-e>
nn <cr> o<esc>
nn <p <ap
nn >p >ap
nn cp cip
nn dp dap
nn gqp gqip
nn gqq Vgq
nn Q <c-q>
nn vp vip
nn Y y$
nn { {zz
nn } }zz

" SORT
nn <silent> gsp mm vip :sort i<cr> `m
nm <silent> gsi mm vii :sort i<cr> `m
xn <silent> gs  mm :sort i<cr> `m

" STATE
au group bufenter * if index(ignore_ft, &ft) < 0 | sil! lo
au group bufleave,vimleave * if index(ignore_ft, &ft) < 0 | sil! mkvie
let ignore_ft = ['diff', 'gitcommit', 'gitrebase']
se viewoptions=cursor

" SUBVERSIVE
let g:subversivePromptWithCurrent = 1
let g:subversivePreserveCursorPosition = 1
nm s <plug>(SubversiveSubstitute)
xm s <plug>(SubversiveSubstitute)
nm ss <plug>(SubversiveSubstituteLine)
nm S <plug>(SubversiveSubstituteToEndOfLine)
nm <leader>r <plug>(SubversiveSubstituteWordRange)ie
xm <leader>r <plug>(SubversiveSubstituteRange)ie
xn ie <esc>ggVG
ono ie :exe "norm! ggVG"<cr>

" THEME
" echo synIDattr(synID(line("."), col("."), 1), "name")
colorscheme nord
hi comment cterm=italic
hi cursorlinenr ctermfg=none
hi diffadded cterm=none ctermbg=none ctermfg=green
hi diffremoved cterm=none ctermbg=none ctermfg=red
hi errormsg ctermbg=none
hi function ctermfg=none
hi jsontrailingcommaerror ctermbg=none
hi matchparen cterm=none ctermbg=none ctermfg=none
hi number ctermfg=none
hi pmenusel ctermfg=none
hi pythonbuiltin ctermfg=none
hi search cterm=bold ctermbg=none ctermfg=red
hi vimaugroup ctermfg=none
hi vimmaprhs ctermfg=none
hi vimnotation ctermfg=none
hi warningmsg ctermbg=none ctermfg=none
se cursorline | hi clear cursorline

" SNIPPETS
let g:vsnip_snippet_dir = $XDG_CONFIG_HOME.'/nvim/snippets'
imap <expr> <tab> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
smap <expr> <tab> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
imap <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-expand-prev)' : '<a-tab>'
smap <expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-expand-prev)' : '<a-tab>'

" STATUSLINE
fu StatusLine()
    let status = expand('%')
    return repeat('―', winwidth(0) - len(status)) . status
endf
se statusline=%{StatusLine()}
se laststatus=1 noruler noshowcmd noshowmode
se fillchars+=eob:\ ,fold:\ ,stl:―,stlnc:―,vert:▏
hi statusline ctermbg=none ctermfg=8
hi statuslinenc ctermbg=none ctermfg=8
hi vertsplit ctermbg=none ctermfg=8

" TABLINE
hi tabline ctermbg=none ctermfg=8
hi tablinefill ctermbg=none
hi tablinesel ctermbg=none ctermfg=none
se showtabline=1

" VIMUX
au group vimleave * VimuxCloseRunner
let g:VimuxHeight = '30'
let g:VimuxUseNearest = 0
nn <silent> <space>x :VimuxCloseRunner<cr>
nn <silent> <space>a :VimuxRunCommand('execute ' . bufname('%'))<cr>
nn <silent> <space>l :VimuxRunCommand('lint ' . bufname('%'))<cr>
nn <silent> <space><space> :VimuxRunCommand(getline('.'))<cr>
xn <silent> <space><space> "vy :VimuxRunCommand(@v)<cr>

" WHITESPACE
hi whitespace ctermbg=red
au group bufwinenter * mat Whitespace /\s\+$\| \+\ze\t/
au group insertenter * mat Whitespace /\s\+\%#\@<!$\| \+\ze\t/
au group insertleave * mat Whitespace /\s\+$\| \+\ze\t/
au group bufwinleave * cal clearmatches()

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
