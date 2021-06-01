" FIRST THINGS FIRST
aug group | au! | aug end
scriptencoding utf-8

" PLUGINS
if empty(glob($XDG_DATA_HOME.'/nvim/site/autoload/plug.vim'))
    sil !curl -fLo "$XDG_DATA_HOME"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
en
nn <silent> <space>pc :PlugClean<cr>
nn <silent> <space>pp :PlugUpgrade<bar>PlugUpdate<cr>
cal plug#begin($XDG_DATA_HOME.'/nvim/plugins')
    Plug 'airblade/vim-gitgutter'
    Plug 'AndrewRadev/switch.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'farmergreg/vim-lastplace'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'junegunn/fzf.vim', { 'on': 'Buffers' }
    Plug 'machakann/vim-sandwich'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'rbong/vim-flog', { 'on': 'Flog' }
    Plug 'stsewd/gx-extended.vim'
    Plug 'svermeulen/vim-subversive'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sleuth'
cal plug#end()

" APPEARANCE
au group filetype * se nocursorline
au group textyankpost * sil! lua vim.highlight.on_yank{}
colorscheme colors
let g:fzf_preview_window = []
nn <silent> <space>h :exe 'hi' synIDattr(synID(line('.'), col('.'), 1), "name")<cr>

" BUFFERS
au group textchanged,insertleave * nested if !&ro | sil! up | en
au group vimenter * sil! let @#=expand('#2:p')
nn <silent> <a-e> :bp<cr><c-g>
nn <silent> <a-r> :bn<cr><c-g>
nn <silent> <space>d :qa!<cr>
nn <silent> <space>q :bd!<cr>
nn <silent> F :Buffers<cr>
nn <silent> f :FZF<cr>
nn <silent> q :b#<cr>
se hidden noswapfile

" COMMENTS
au group filetype * se formatoptions-=cro
nn <silent> gcp my:norm vip<bar>gc<cr>`y
se commentstring=//\ %s

" COMPLETION
se completeopt=menuone,noinsert
se path+=** path-=/usr/include
se pumheight=8 pumwidth=0
se shortmess+=c
se wildmode=longest:full,full

" EDITING - CHANGE
nm cp cip
nm cw ciw
nm cW ciW
nn c "_c
nn C "_C
xn c "_c

" EDITING - COPY
nn Y y$
nn yp myyip`y
nn yw myyiw`y
nn yW myyiW`y

" EDITING - CUT
nn <expr> dp &diff ? 'dp' : 'dap:echo<cr>'
nn dw daw
nn dW daW

" EDITING - PASTE
ino <c-v> <c-r>+
nn p p:echo<cr>

" EDITING - REPLACE
let g:subversivePreserveCursorPosition = 1
let g:subversivePromptWithCurrent = 1
nm s <plug>(SubversiveSubstitute)
nm S <plug>(SubversiveSubstituteToEndOfLine)
nm ss <plug>(SubversiveSubstituteLine)
xm ss <plug>(SubversiveSubstitute)
nm sw siw
nm sW siW

" EDITING - UNDO
nn <c-r> <c-r>:echo<cr>
nn U <c-r>:echo<cr>
nn u u:echo<cr>

" FILETYPE
au group filetype diff se textwidth=72
au group filetype hog se ft=udevrules
au group filetype markdown se textwidth=80
let g:tex_flavor = 'latex'

" FORMATTING
nn gqp gqip
nn gqq Vgq

" GIT
au group filetype floggraph nm <buffer> <rightmouse> <leftmouse><cr>
au group filetype floggraph nm <buffer> <space>q <plug>(FlogQuit)
au group filetype floggraph xm <buffer> <rightmouse> <cr>
let g:flog_permanent_default_arguments = { 'date': 'short' }
nn <silent> <space>kd :0G diff<cr>
nn <silent> <space>kK :Flog -all -path=%<cr>
nn <silent> <space>kk :Flog -all<cr>
nn <silent> <space>kr :G reset --hard<cr>
nn <silent><expr> <space>km &diff ? ':x<cr>zz' : ':Gdiffsplit<cr>'
nn <space>kg :Flog -search=

" GITGUTTER
au group vimenter,bufwritepost * GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
nm <silent> <space>i :GitGutterPreviewHunk<cr>
nm <silent> <space>S :GitGutterStageHunk<cr>
nm <silent> <space>u :sil GitGutterUndoHunk<cr>
nm <silent> [c :sil GitGutterPrevHunk<cr>zz
nm <silent> ]c :sil GitGutterNextHunk<cr>zz
se signcolumn=yes

" INDENTATION
nn <p <ap
nn >p >ap
se expandtab
se shiftwidth=4
se tabstop=4

" LOADED
let g:loaded_gzip = 0
let g:loaded_matchparen = 0
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

" LSP
let g:coc_global_extensions = ['coc-json', 'coc-python']
ino <silent><expr> <c-space> coc#refresh()
nm <silent> gd <plug>(coc-definition)zz
nm <silent> gR <plug>(coc-references)
nm <silent> gr <plug>(coc-rename)
nn <silent> K :cal <sid>show_documentation()<cr>
fu! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        exe 'h '.expand('<cword>')
    elsei (coc#rpc#ready())
        cal CocActionAsync('doHover')
    el
        exe '!' . &keywordprg . " " . expand('<cword>')
    en
endf

" MISC
nn Q q
se clipboard=unnamedplus
se nofoldenable
se nojoinspaces
se notimeout
se virtualedit=block

" MOTIONS
ino <c-l> <right>
nn <a-d> 4<c-y>
nn <a-f> 4<c-e>
nn <c-i> <c-i>zz
nn <c-o> <c-o>zz
nn <cr> o<esc>
nn <silent> n nzz
nn <silent> N Nzz
nn G G0
nn gg gg0
nn H H0
nn L L0
nn M M0
nn { {zz
nn } }zz

" MOUSE
nm <rightmouse> <leftmouse>gx
nm <silent> <2-rightmouse> <rightmouse>
nm <silent> <3-rightmouse> <rightmouse>
nm <silent> <4-rightmouse> <rightmouse>
se mouse=a
se mousemodel=popup

" SANDWICH
nm cb cib
nm db dib
nm saw saiw
nm saW saiW
nm sb sib
nm yb myyib`y

" SEARCH
cno <silent><expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter>:noh<bar>echo<cr>zz' : '<enter>'
nn <silent> <esc> :noh<bar>echo<cr><esc>
nn <silent> <a-esc> :se hls<cr>
nn <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nn <silent> , :let @/= expand('<cword>')<bar>se hls<cr>
xn <silent> , :<c-u>let @/= getline(".")[getpos("'<")[2] - 1:getpos("'>")[2] - 1]<bar>se hls<cr>
se ignorecase smartcase
se inccommand=nosplit
se shortmess+=Ss

" SNIPPETS
let g:vsnip_snippet_dir = $XDG_CONFIG_HOME.'/nvim/snippets'
im   <silent><expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)'      : '<a-tab>'
im   <silent><expr> <tab>   vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<tab>'
smap <silent><expr> <a-tab> vsnip#available(1) ? '<plug>(vsnip-jump-prev)'      : '<a-tab>'
smap <silent><expr> <tab>   vsnip#available(1) ? '<plug>(vsnip-expand-or-next)' : '<tab>'

" SORT
nn <silent> gsi my:norm vii<cr>:sort i<cr>`y
nn <silent> gss myvip:sort i<cr>`y
xn <silent> gs  my:sort i<cr>`y

" SPELL
se spellcapcheck=
se spellfile=$XDG_DATA_HOME/nvim/spell/en.utf-8.add

" STATUSLINE
fu! StatusLine()
    if empty(expand('%'))
        retu repeat('─', winwidth(0))
    en
    let left = '[' . substitute(expand('%:t'), '^[^/]*\/', '', '') . ']'
    let right = '[' . line('.') . '/' . line('$') . ']'
    retu left . repeat('─', winwidth(0) - len(left) - len(right)) . right
endf
nn <silent><expr> <space>b &ls ? ':se stl=\  ls=0<cr>' : ':se ls=2 stl=%{StatusLine()}<cr>'
se fillchars+=diff:\ ,eob:\ ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│
se noruler noshowcmd noshowmode laststatus=0
se statusline=\  rulerformat=%=%l/%L showtabline=0

" SWITCH
let g:switch_custom_definitions = [
    \['+', '-'],
    \['0', '1'],
    \['<', '>'],
    \['==', '!='],
    \['on', 'off'],
    \['pick', 'fixup', 'reword'],
    \['yes', 'no'],
\]
let g:switch_mapping = 't'

" TMUXSEND
fu! T(...)
    if !empty(system('tmux has -t $(cat /tmp/tmuxsend)'))
        exe system('tmux neww -ac "#{pane_current_path}" -PF "#{pane_id}" > /tmp/tmuxsend')
        sil !tmux lastp
    en
    exe system('tmux send -t $(cat /tmp/tmuxsend) ' . shellescape(join(a:000)) . ' ENTER')
    if system('tmux display -p "#{window_id}"') != system('tmux display -pt $(cat /tmp/tmuxsend) "#{window_id}"')
        sil !tmux selectw -t $(cat /tmp/tmuxsend)
    en
endf
com! -complete=shellcmd -nargs=+ T cal T(expandcmd(<q-args>))
nn <silent> <space><space> :cal T(getline('.'))<cr>
xn <silent> <space><space> "vy :cal T(substitute(@v, '\n$', '', ''))<cr>
nn <silent> <space>l :T lint %<cr>
nn <silent> <space>a :T execute<cr>

" WINDOWS
au group vimresized * winc =
let g:tmux_navigator_no_mappings = 1
nn <silent> <a-h> :TmuxNavigateLeft<cr>
nn <silent> <a-j> :TmuxNavigateDown<cr>
nn <silent> <a-k> :TmuxNavigateUp<cr>
nn <silent> <a-l> :TmuxNavigateRight<cr>
nn <space>c <c-w>czz
nn <space>s <c-w>s
nn <space>v <c-w>v
nn <space>z <c-w>z
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
se breakindent
se linebreak
