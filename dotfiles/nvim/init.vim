" FIRST THINGS FIRST
aug group | au! | aug en
let mapleader = ' '
scriptencoding utf-8

" PLUGINS
pa! chadtree
pa! clever-f
pa! commentary
pa! deoplete
pa! deoplete-jedi
pa! easy-align
pa! gitgutter
pa! indent-object
pa! lexima
pa! neopairs
pa! nord
pa! nvim-lsp
pa! nvim-treesitter
pa! sandwich
pa! sleuth
pa! subversive
pa! tmux-navigator
pa! ultisnips
pa! vimtex
pa! visual-star-search
syntax on

" BUFFERS
au group bufenter,focusgained * checkt
au group textchanged,insertleave * nested sil! up
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
nm gcp my vip gc `y
se commentstring=//\ %s

" COMPLETION
ino <expr> <a-c> pumvisible() ? "\<c-e>" : "\<a-c>"
se completeopt=menuone,noinsert
se infercase shortmess+=c
se pumheight=8 pumwidth=0

" DEOPLETE
let g:deoplete#enable_at_startup = 1
cal deoplete#custom#option({
    \'ignore_sources': { '_': ['around', 'member'] },
    \'min_pattern_length': 1,
    \'num_processes': 1,
\})
cal deoplete#custom#source('_', 'matchers', [
    \'matcher_fuzzy',
    \'matcher_length',
\])
cal deoplete#custom#source('_', 'converters', [
    \'converter_word_abbr',
    \'converter_auto_paren',
\])

" DEOPLETE-JEDI
cal deoplete#custom#source('jedi', 'mark', '[J]')
let g:deoplete#sources#jedi#enable_short_types = 1
let g:deoplete#sources#jedi#short_types_map = {
    \'class':      ' c ',
    \'function':   ' f ',
    \'globalstmt': ' v ',
    \'instance':   ' v ',
    \'keyword':    ' k ',
    \'module':     ' m ',
    \'statement':  ' v ',
\}

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
au group filetype fzf,help se laststatus=0
au group bufleave fzf,help se laststatus=1
com! -nargs=+ FZFF exe 'e' system('ffind -type f | fzf --filter="<args>" | head -n1') | exe 'ec'
nn <space>f :FZFF<space>
nn <silent> <space>F :FZF<cr>

" GITGUTTER
au group bufwritepost * GitGutter
let g:gitgutter_map_keys = 0
nm <space>i <Plug>(GitGutterPreviewHunk)
nm <space>S <Plug>(GitGutterStageHunk)
nm <space>u <Plug>(GitGutterUndoHunk)
nm [c <Plug>(GitGutterPrevHunk)zz
nm ]c <Plug>(GitGutterNextHunk)zz
se signcolumn=yes

" KILL
nn <silent> <space>c :clo<cr>
nn <silent> <space>d :qa!<cr>
nn <silent> <space>q :bn<bar>bd!#<cr>
nn <silent> <space>s <c-z>

" LATEX
let g:tex_flavor = 'latex'
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
au group filetype tex cal deoplete#custom#var('omni', 'input_patterns', { 'tex': g:vimtex#re#deoplete })
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

" LSP
au group filetype python cal SetupLSP()
fu! SetupLSP()
    nn <silent> gd :lua vim.lsp.buf.definition()<cr>
    nn <silent> gp :lua vim.lsp.buf.signature_help()<cr>
    nn <silent> gR :lua vim.lsp.buf.references()<cr>
    nn <silent> gr :lua vim.lsp.buf.rename()<cr>
    nn <silent> K  :lua vim.lsp.buf.hover()<cr>
endf
lua require 'nvim_lsp'.pyls.setup{}
lua vim.lsp.callbacks["textDocument/publishDiagnostics"] = function() end

" MISC
au group filetype gitcommit,markdown,tex setl spell
au group filetype markdown se textwidth=80
au group vimresized * winc =
let g:plug_window = 'enew'
nn <silent> <a-S> :so $MYVIMRC<cr>
nn <silent> <space>e :CHADopen<cr>
nm ga <plug>(EasyAlign)
xm ga <plug>(EasyAlign)
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

" PLUG
nn <silent> <space>pc :PlugClean<cr>
nn <silent> <space>pi :PlugInstall<cr>
nn <silent> <space>pp :PlugUpgrade <bar> PlugUpdate<cr>

" SEARCH & REPLACE
let g:clever_f_across_no_line = 1
let g:clever_f_smart_case = 1
nn <silent> <esc> :noh <bar> ec <bar> cal clever_f#reset()<cr>
nn <silent> , *``
xm <silent> , *``
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
nn cw ciw
nn cW ciW
nn dp dap
nn dw daw
nn dW daW
nn gg gg0
nn gqp gqip
nn gqq Vgq
nn Q <c-q>
nn vp vip
nn Y y$
nn yw my yiw `y
nn yW my yiW `y
nn { {zz
nn } }zz

" SNIPPETS
let g:UltiSnipsJumpBackwardTrigger = '<a-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsSnippetDirectories = [$XDG_CONFIG_HOME.'/nvim/UltiSnips']

" SORT
nn <silent> gsp my vip :sort i<cr> `y
nm <silent> gsi my vii :sort i<cr> `y
xn <silent> gs  my :sort i<cr> `y

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
nm <space>r <plug>(SubversiveSubstituteWordRange)ie
xm <space>r <plug>(SubversiveSubstituteRange)ie
xn ie <esc>ggVG
ono ie :exe "norm! ggVG"<cr>

" THEME
" echo synIDattr(synID(line("."), col("."), 1), "name")
colorscheme nord
hi comment cterm=italic
hi diffadded cterm=none ctermbg=none ctermfg=green
hi diffremoved cterm=none ctermbg=none ctermfg=red
hi errormsg ctermbg=none
hi matchparen cterm=none ctermbg=none ctermfg=none
hi pmenusel ctermfg=none
hi search cterm=bold ctermbg=none ctermfg=red
hi vimaugroup ctermfg=none
hi vimmaprhs ctermfg=none
hi vimnotation ctermfg=none
hi warningmsg ctermbg=none ctermfg=none
se cursorline | hi clear cursorline

" TREESITTER
hi tserror ctermfg=15
lua << END
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {"bash", "c", "cpp", "json", "markdown", "python"},
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gn",
            node_decremental = "gnp",
            node_incremental = "gnn",
            scope_incremental = "gns",
        },
    },
    textobjects = {
        enable = true,
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["aF"] = "@class.outer",
            ["iF"] = "@class.inner",
            ["aC"] = "@conditional.outer",
            ["iC"] = "@conditional.inner",
            ["ak"] = "@block.outer",
            ["ik"] = "@block.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ac"] = "@comment.outer",
        },
    },
}
END

" STATUSLINE
hi statusline ctermbg=none ctermfg=8
hi statuslinenc ctermbg=none ctermfg=8
hi vertsplit ctermbg=none ctermfg=8
se fillchars+=eob:\ ,fold:\ ,stl:―,stlnc:―,vert:▏
se noruler noshowcmd noshowmode laststatus=1
fu StatusLine()
    let status = expand('%')
    return repeat('―', winwidth(0) - len(status)) . status
endf
se statusline=%{StatusLine()}

" TABLINE
hi tabline ctermbg=none ctermfg=8
hi tablinefill ctermbg=none
hi tablinesel ctermbg=none ctermfg=none
se showtabline=1

" TMUXRENAME
au group vimenter,vimresume,focusgained * cal system('tmux renamew "#{b:pane_current_path}"')
au group vimleave,vimsuspend * cal system('tmux setw automatic-rename')
au group vimenter,vimresume,focusgained notes cal system('tmux renamew notes')

" TMUXSEND
com! -nargs=+ T silent exe '!tmux send -t $(cat /tmp/vim_tmux_pane) ' shellescape(<q-args>) ' ENTER'
nn <silent> <space><space> :exe 'T' getline('.')<cr>
xn <silent> <space><space> "vy :exe 'T' @v<cr>
nn <silent> <space>l :T lint %<cr>
nn <silent> <space>a :T execute<cr>

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
