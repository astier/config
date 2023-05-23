" FIRST THINGS FIRST
augroup vimrc | autocmd! | augroup end
scriptencoding utf-8

" PLUGINS
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
  execute '!curl -fLo' plug_path '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd vimrc vimenter * PlugInstall --sync | source $MYVIMRC
endif
nnoremap <space>pc <cmd>PlugClean<cr>
nnoremap <space>pp <cmd>PlugUpgrade<bar>PlugUpdate<cr>
call plug#begin()
  " Plug 'chrisgrieser/nvim-spider'
  " Plug 'chrishrb/gx.nvim'
  " Plug 'mrjones2014/smart-splits.nvim'
  " Plug 'Wansmer/treesj'
  Plug 'airblade/vim-gitgutter'
  Plug 'airblade/vim-rooter'
  Plug 'aserowy/tmux.nvim'
  Plug 'astier/gx-extended.vim'
  Plug 'dcampos/nvim-snippy'
  Plug 'gbprod/substitute.nvim'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'ibhagwan/fzf-lua', { 'branch': 'main' }
  Plug 'idbrii/textobj-word-column.vim'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'kana/vim-textobj-indent'
  Plug 'kana/vim-textobj-user'
  Plug 'kevinhwang91/nvim-bqf'
  Plug 'machakann/vim-sandwich'
  Plug 'neovim/nvim-lspconfig'
  Plug 'numToStr/Comment.nvim'
  Plug 'rbong/vim-flog'
  Plug 'romainl/vim-qf'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'wellle/targets.vim'
  Plug 'windwp/nvim-autopairs'
call plug#end()

" APPEARANCE
autocmd vimrc filetype * setl nocursorline
autocmd vimrc textyankpost * lua vim.highlight.on_yank()
colorscheme custom
nnoremap <space>H <cmd>execute 'highlight' synIDattr(synID(line('.'), col('.'), 1), "name")<cr>

" AUTOPAIRS
lua << EOF
require('nvim-autopairs').setup()
local npairs = require('nvim-autopairs')
local rule   = require('nvim-autopairs.rule')
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  npairs.add_rules {
    rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end
EOF

" BUFFERS
autocmd vimrc textchanged,insertleave * nested if !&ro | silent! update | endif
nnoremap <space>d <cmd>qa!<cr>
nnoremap q <cmd>silent! b#<cr>
set noswapfile

" CHANGE
nnoremap c "_c
nnoremap C "_C
xnoremap c "_c
nmap cp cip
nmap cw ciw
nmap cW ciW

" CMDLINE
autocmd vimrc cmdlineleave * echo ''
set path=.,,**

" COMMENTS
autocmd vimrc filetype * set formatoptions-=cro
lua require('Comment').setup()
nmap gcj gco
nmap gck gcO
nmap gcl gcA
nmap gcp gcip
onoremap u <cmd>lua require('uncomment').uncomment()<cr>

" COMPLETION
highlight! link CmpSelection lspsignatureactiveparameter
set completeopt=menuone,noinsert
set pumheight=8 pumwidth=0
set shortmess+=c
lua << EOF
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require('cmp')
local snippy = require('snippy')
cmp.setup({
  completion = {
    completeopt = table.concat(vim.opt.completeopt:get(), ","),
  },
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  window = {
    completion = {
      border = 'single',
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal,CursorLine:CmpSelection',
    },
    documentation = {
      border = 'single',
      winhighlight = 'FloatBorder:FloatBorder,Normal:Normal,CursorLine:CmpSelection',
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<a-d>'] = cmp.mapping.scroll_docs(-4),
    ['<a-f>'] = cmp.mapping.scroll_docs(4),
    ['<a-j>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
    ['<a-k>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
    ['<a-space>'] = cmp.mapping.complete(),
    ['<cr>']  = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources(
    {{ name = 'path' }},
    {{ name = 'nvim_lsp' }},
    {{ name = 'buffer' }}
  ),
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = ({})[vim_item.kind]
      vim_item.menu = ({})[entry.source.name]
      return vim_item
    end
  },
})
EOF

" DELETE
nnoremap <expr> dp &diff ? 'dp' : '<cmd>silent normal! dap<cr>'
nnoremap dw daw
nnoremap dW daW
xnoremap d <cmd>silent normal! d<cr>

" FORMATTING
nnoremap gqp gqip
nnoremap gqq Vgq

" FUZZY - CONFIG
lua << EOF
require('fzf-lua').setup({
  'max-perf',
  fzf_args = vim.env.FZF_DEFAULT_OPTS,
  winopts = {
    border = 'single',
    preview = { hidden = 'hidden' },
    hl = { border = 'FloatBorder' },
  },
  files = { cmd = vim.env.FZF_DEFAULT_COMMAND },
  oldfiles = { cwd_only = true },
})
EOF

" FUZZY - MAPPINGS (MISC)
nnoremap fb <cmd>FzfLua builtin<cr>
nnoremap fc <cmd>FzfLua commands<cr>
nnoremap ff <cmd>FzfLua files<cr>
nnoremap fh <cmd>FzfLua help_tags<cr>
nnoremap fj <cmd>FzfLua buffers<cr>
nnoremap fl <cmd>FzfLua blines<cr>
nnoremap fo <cmd>FzfLua oldfiles<cr>
nnoremap fQ <cmd>FzfLua loclist<cr>
nnoremap fq <cmd>FzfLua quickfix<cr>
nnoremap fR <cmd>FzfLua registers<cr>

" FUZZY - MAPPINGS (GREP)
nnoremap fg <cmd>FzfLua grep<cr>
nnoremap fG <cmd>FzfLua live_grep<cr>
nnoremap fw <cmd>FzfLua grep_cword<cr>
nnoremap fW <cmd>FzfLua grep_cWORD<cr>
xnoremap fw <cmd>FzfLua grep_visual<cr>

" FUZZY - MAPPINGS (LSP)
nnoremap fd <cmd>FzfLua lsp_definitions<cr>
nnoremap fi <cmd>FzfLua lsp_implementations<cr>
nnoremap fr <cmd>FzfLua lsp_references<cr>
nnoremap fs <cmd>FzfLua lsp_document_symbols<cr>
nnoremap fS <cmd>FzfLua lsp_workspace_symbols<cr>

" GIT
autocmd vimrc filetype floggraph nmap <buffer> <rightmouse> <leftmouse><cr>
autocmd vimrc filetype floggraph nmap <buffer> <space>q <plug>(FlogQuit)
autocmd vimrc filetype floggraph xmap <buffer> <rightmouse> <cr>
let g:flog_permanent_default_opts = { 'date': 'short' }
nnoremap <expr> <space>km &diff ? '<cmd>x<cr>zz' : '<cmd>Gdiffsplit<cr>'
nnoremap <space>kd <cmd>0G diff<cr>
nnoremap <space>kg :Flog -search=
nnoremap <space>kK <cmd>Flog -all -path=%<cr>
nnoremap <space>kk <cmd>Flog -all<cr>
nnoremap <space>kr <cmd>G reset --hard<bar>e<cr>

" GITGUTTER
let g:gitgutter_map_keys = 0
nnoremap <space>i <cmd>silent GitGutterPreviewHunk<cr>
nnoremap <space>S <cmd>silent GitGutterStageHunk<cr>
nnoremap <space>u <cmd>silent GitGutterUndoHunk<cr>
nnoremap [c <cmd>silent GitGutterPrevHunk<cr>zz
nnoremap ]c <cmd>silent GitGutterNextHunk<cr>zz
set signcolumn=yes

" GREP
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m
command! -nargs=+ -complete=file_in_path Grep silent grep! <args><bar>echo
nnoremap <space>g :Grep<space>

" INDENTATION
nnoremap <p <ap
nnoremap >p >ap
set expandtab
set shiftwidth=2
set tabstop=2

" LOADED
" Two function-calls are needed to open lsp-float-windows in insert-mode if disabled
" let g:loaded_matchparen = 0
let g:loaded_2html_plugin = 0
let g:loaded_gzip = 0
let g:loaded_matchit = 0
let g:loaded_netrwPlugin = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python3_provider = 0
let g:loaded_remote_plugins = 0
let g:loaded_ruby_provider = 0
let g:loaded_spellfile_plugin = 0
let g:loaded_tarPlugin = 0
let g:loaded_tutor_mode_plugin = 0
let g:loaded_vimball = 0
let g:loaded_vimballPlugin = 0
let g:loaded_zipPlugin = 0

" LSP
lua << EOF
-- Diagnostics
vim.diagnostic.disable()
vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
-- Border
local border = 'single'
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
-- LspAttach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('v', '<c-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
  end,
})
-- Servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.ccls.setup({
  capabilities = capabilities,
  init_options = { diagnostics = { onOpen = -1, onChange = -1, onSave = -1 } },
})
lspconfig.jedi_language_server.setup({
  capabilities = capabilities,
  init_options = { diagnostics = { enable = false } },
})
lspconfig.marksman.setup({ capabilities = capabilities })
EOF

" MAKE
set makeprg=lint
set errorformat=%f:%l:%c:%m
set errorformat+=%f:%l:%c\ %m
set errorformat+=%f:%l:%m
set errorformat+=%f:%l\ %m
nnoremap <space>l <cmd>silent make! %<cr>

" MAPPINGS
inoremap <c-space> <space>
nnoremap <expr> <cr> &ft == 'qf' ? '<cr>' : 'o<esc>'
nnoremap guw myguiw`y
nnoremap guW myguiW`y
nnoremap gUw mygUiw`y
nnoremap gUW mygUiW`y
nnoremap J myJ`y
nnoremap Q q
nnoremap t <cmd>call toggle#Next()<cr>
xnoremap <silent> . :normal! .<cr>
xnoremap q :'<,'>:normal! @q<cr>

" MOTIONS
inoremap <c-l> <right>
nnoremap <c-i> <c-i>zz
nnoremap <c-o> <c-o>zz
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap A g$a
nnoremap I g0i
noremap $ g$
noremap F g$
noremap 0 g0
noremap ^ g^
noremap j gj
noremap k gk
noremap H H0
noremap L L0
noremap M M0
noremap { {zz
noremap } }zz

" MOUSE
nmap <2-rightmouse> <rightmouse>
nmap <3-rightmouse> <rightmouse>
nmap <4-rightmouse> <rightmouse>
set mousemodel=extend
set mousescroll=ver:4

" PASTE
inoremap <c-v> <c-r>+
nnoremap cP <cmd>silent normal! yap}p<cr>
nnoremap p <cmd>silent! normal! p<cr>
nnoremap P <cmd>silent! normal! P<cr>

" QUICKFIX
autocmd vimrc filetype qf setl nonu scl=no
nmap <space>q <plug>(qf_qf_toggle_stay)
nmap [q <plug>(qf_qf_previous)zz
nmap ]q <plug>(qf_qf_next)zz
lua << EOF
require('bqf').setup({
  preview = {
    border_chars = { '│', '│', '─', '─', '┌', '┐', '└', '┘', '█' },
    show_title = false,
  },
  func_map = { split = '<c-s>', },
  filter = { fzf = { action_for = { ['ctrl-s'] = 'split' } } },
})
EOF
highlight bqfsign ctermfg=yellow
highlight! link bqfpreviewborder comment
highlight! link bqfpreviewrange none

" ROOTER
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1

" SANDWICH
" Combine with targets.vim (https://github.com/machakann/vim-sandwich/issues/92)
let g:sandwich_no_default_key_mappings = 1
let g:textobj_sandwich_no_default_key_mappings = 1
nmap sd <plug>(operator-sandwich-delete)a
nmap sr <plug>(operator-sandwich-replace)a
nmap sdf <plug>(sandwich-delete)f
nmap srf <plug>(sandwich-replace)f
nmap sa <plug>(operator-sandwich-add)
xmap sa <plug>(operator-sandwich-add)
nmap sab saib
nmap saB saab
nmap saw saiw
nmap saW saiW

" SCROLLING
nnoremap <a-d> 4<c-y>
nnoremap <a-f> 4<c-e>

" SEARCH
cnoremap <expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter><cmd>echo<bar>noh<cr>zz' : '<enter>'
nnoremap <esc> <cmd>echo<bar>noh<cr><esc>
nnoremap <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nnoremap <space>w <cmd>let @/='\<'.expand('<cword>').'\>'<bar>set hls<cr>
nnoremap <space>W <cmd>let @/='\<'.expand('<cWORD>').'\>'<bar>set hls<cr>
xnoremap <space>w <cmd>let @/=visual#GetSelection()<bar>set hls<cr><esc>
nnoremap <c <cmd>set ignorecase!<cr>
nnoremap <h <cmd>set hlsearch!<cr>
set ignorecase smartcase
set shortmess+=Ss

" SETTINGS
set clipboard=unnamedplus
set nofoldenable
set notimeout
set virtualedit=block

" SNIPPETS
lua << EOF
require('snippy').setup({
  mappings = {
    is = {
      ['<tab>'] = 'expand_or_advance',
      ['<s-tab>'] = 'previous',
    },
    x = { ['<tab>'] = 'cut_text' },
  },
})
EOF

" SORT
nmap <silent> gs myvii:sort i<cr>`y
xnoremap <silent> gs my:sort i<cr>`y

" SPELL
set spellcapcheck=
set spellfile=$XDG_STATE_HOME/nvim/spell/en.utf-8.add

" STATUS (RULER/STATUSLINE)
nnoremap <expr> <s &ls ? '<cmd>se stl=%= ls=0<cr>' : '<cmd>se ls=3 stl=\[%f\]%=\[%l/%L\]<cr>'
set fillchars+=diff:\ ,eob:\ ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│
set noshowcmd noshowmode
set rulerformat=%=\[%l/%L\] noruler
set statusline=%= laststatus=0

" SUBSTITUTE
lua require('substitute').setup()
nnoremap s <cmd>lua require('substitute').operator()<cr>
nnoremap sA <cmd>lua require('substitute').operator({ motion='a' })<cr>
nnoremap sp <cmd>lua require('substitute').operator({ motion='ip' })<cr>
nnoremap sb <cmd>lua require('substitute').operator({ motion='Ib' })<cr>
nnoremap sB <cmd>lua require('substitute').operator({ motion='ab' })<cr>
nnoremap sw <cmd>lua require('substitute').operator({ motion='iw' })<cr>
nnoremap sW <cmd>lua require('substitute').operator({ motion='iW' })<cr>
nnoremap S <cmd>lua require('substitute').eol()<cr>
nnoremap ss <cmd>lua require('substitute').line()<cr>
xnoremap ss <cmd>lua require('substitute').visual()<cr>
nnoremap sx <cmd>lua require('substitute.exchange').operator()<cr>
nnoremap sxb <cmd>lua require('substitute.exchange').operator({ motion='Ib' })<cr>
nnoremap sxB <cmd>lua require('substitute.exchange').operator({ motion='ab' })<cr>
nnoremap sxw <cmd>lua require('substitute.exchange').operator({ motion='iw' })<cr>
nnoremap sxW <cmd>lua require('substitute.exchange').operator({ motion='iW' })<cr>
nnoremap sxx <cmd>lua require('substitute.exchange').line()<cr>
xnoremap sx <cmd>lua require('substitute.exchange').visual()<cr>

" TABLINE
set showtabline=1
set tabline=%!tabline#Show()

" TABS
nnoremap <a-e> <cmd>tabp<cr>
nnoremap <a-r> <cmd>tabn<cr>
nnoremap <space>n <cmd>tab split<cr>
tnoremap <silent> <a-e> <c-\><c-n><cmd>tabp<cr>
tnoremap <silent> <a-r> <c-\><c-n><cmd>tabn<cr>

" TARGETS
autocmd vimrc user targets#mappings#user call targets#mappings#extend({
\ 'b': {
\   'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}],
\   'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]
\ },
\})
nmap cb cIb
nmap cq cIq
nmap db dIb
nmap dq dIq
nmap yb <cmd>silent! normal myyIb`y<cr> " Call as cmd to fix flog-error

" TEXTOBJ
nmap cv civ
nmap dc my^dic`y
nmap dv dav

" TMUX
command! -complete=shellcmd -nargs=* T call system('iwltm --send '.shellescape(expandcmd(<q-args>)))
nnoremap <space><space> <cmd>call T(getline('.'))<cr>
xnoremap <space><space> "vy <cmd>call T(substitute(@v, '\n$', '', ''))<cr>
nnoremap <space>a <cmd>T execute<cr>

" UNDO
nnoremap <c-r> <cmd>call center#ExeCmdAndCenter('redo')<cr>
nnoremap U <cmd>call center#ExeCmdAndCenter('redo')<cr>
nnoremap u <cmd>call center#ExeCmdAndCenter('undo')<cr>

" WINDOWS
nnoremap <space>c <c-w>c
nnoremap <space>s <c-w>s
nnoremap <space>v <c-w>v
nnoremap <space>z <c-w>z
set splitbelow splitright

" WINDOWS - NAVIGATION
lua << EOF
return require("tmux").setup({
  copy_sync = { enable = false },
  navigation = {
    cycle_navigation = false,
    enable_default_keybindings = false,
  },
  resize = {
    enable_default_keybindings = false,
    resize_step_x = 2,
    resize_step_y = 2,
  },
})
EOF
nnoremap <a-h> <cmd>lua require('tmux').move_left()<cr>
nnoremap <a-j> <cmd>lua require('tmux').move_bottom()<cr>
nnoremap <a-k> <cmd>lua require('tmux').move_top()<cr>
nnoremap <a-l> <cmd>lua require('tmux').move_right()<cr>
tnoremap <a-h> <c-\><c-n><cmd>lua require('tmux').move_left()<cr>
tnoremap <a-j> <c-\><c-n><cmd>lua require('tmux').move_bottom()<cr>
tnoremap <a-k> <c-\><c-n><cmd>lua require('tmux').move_top()<cr>
tnoremap <a-l> <c-\><c-n><cmd>lua require('tmux').move_right()<cr>

" WINDOWS - RESIZE
autocmd vimrc vimresized * wincmd =
nnoremap <a-H> <cmd>lua require('tmux').resize_left()<cr>
nnoremap <a-J> <cmd>lua require('tmux').resize_bottom()<cr>
nnoremap <a-K> <cmd>lua require('tmux').resize_top()<cr>
nnoremap <a-L> <cmd>lua require('tmux').resize_right()<cr>
tnoremap <a-H> <c-\><c-n><cmd>lua require('tmux').resize_left()<cr>
tnoremap <a-J> <c-\><c-n><cmd>lua require('tmux').resize_bottom()<cr>
tnoremap <a-K> <c-\><c-n><cmd>lua require('tmux').resize_top()<cr>
tnoremap <a-L> <c-\><c-n><cmd>lua require('tmux').resize_right()<cr>

" WRAP
autocmd vimrc filetype * set formatoptions-=t wrap
set breakindent
set breakindentopt=shift:2
set linebreak
if $TERM ==# 'linux' || $TERM ==# 'screen'
  set showbreak=¬\ 
else
  set showbreak=↳\ 
endif

" YANK
nnoremap <silent> y :<c-u>call yank#AndJumpBack()<cr>g@
nnoremap yp <cmd>silent normal! myyap`y<cr>
nnoremap yw myyiw`y
nnoremap yW myyiW`y
nnoremap yy myyy`y
xnoremap y <cmd>silent normal! myy`y<cr>
