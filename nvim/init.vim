" FIRST THINGS FIRST
augroup group | autocmd! | augroup end
scriptencoding utf-8

" PLUGINS
let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(plug_path))
  execute '!curl -fLo' plug_path '--create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd group vimenter * PlugInstall --sync | source $MYVIMRC
endif
nnoremap <space>pc <cmd>PlugClean<cr>
nnoremap <space>pp <cmd>PlugUpgrade<bar>PlugUpdate<cr>
call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'airblade/vim-rooter'
  Plug 'AndrewRadev/switch.vim'
  Plug 'Darazaki/indent-o-matic'
  Plug 'dcampos/nvim-snippy'
  Plug 'farmergreg/vim-lastplace'
  Plug 'gbprod/substitute.nvim'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
  Plug 'idbrii/textobj-word-column.vim'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'kana/vim-textobj-user'
  Plug 'kevinhwang91/nvim-bqf'
  Plug 'machakann/vim-sandwich'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'nathom/tmux.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'numToStr/Comment.nvim'
  Plug 'rbong/vim-flog'
  Plug 'stevearc/qf_helper.nvim'
  Plug 'stevearc/stickybuf.nvim'
  Plug 'stsewd/gx-extended.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'wellle/targets.vim'
  Plug 'windwp/nvim-autopairs'
call plug#end()

" APPEARANCE
autocmd group filetype * set nocursorline
autocmd group textyankpost * silent! lua vim.highlight.on_yank{}
colorscheme colors
nnoremap <space>H <cmd>execute 'highlight' synIDattr(synID(line('.'), col('.'), 1), "name")<cr>

" AUTOPAIR
lua << EOF
require('nvim-autopairs').setup{}
local npairs = require('nvim-autopairs')
local Rule   = require('nvim-autopairs.rule')
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
          return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}
EOF

" BUFFERS
autocmd group textchanged,insertleave * nested if !&ro | silent! update | endif
autocmd group vimenter * silent! let @#=expand('#2:p')
nnoremap <space>d <cmd>qa!<cr>
nnoremap q <cmd>b#<cr>
set noswapfile

" COMMENTS
autocmd group filetype * set formatoptions-=cro
lua require('Comment').setup()
nmap gcj gco
nmap gck gcO
nmap gcl gcA
nmap gcp gcip
unmap gbc
lua << EOF
---Textobject for adjacent commented lines
---https://github.com/numToStr/Comment.nvim/issues/22#issuecomment-1272569139
local function commented_lines_textobject()
	local U = require('Comment.utils')
	local cl = vim.api.nvim_win_get_cursor(0)[1] -- current line
	local range = { srow = cl, scol = 0, erow = cl, ecol = 0 }
	local ctx = {
		ctype = U.ctype.linewise,
		range = range,
	}
	local cstr = require('Comment.ft').calculate(ctx) or vim.bo.commentstring
	local ll, rr = U.unwrap_cstr(cstr)
	local padding = true
	local is_commented = U.is_commented(ll, rr, padding)
	local line = vim.api.nvim_buf_get_lines(0, cl - 1, cl, false)
	if next(line) == nil or not is_commented(line[1]) then
		return
	end
	local rs, re = cl, cl -- range start and end
	repeat
		rs = rs - 1
		line = vim.api.nvim_buf_get_lines(0, rs - 1, rs, false)
	until next(line) == nil or not is_commented(line[1])
	rs = rs + 1
	repeat
		re = re + 1
		line = vim.api.nvim_buf_get_lines(0, re - 1, re, false)
	until next(line) == nil or not is_commented(line[1])
	re = re - 1

	vim.fn.execute("normal! " .. rs .. "GV" .. re .. "G")
end
vim.keymap.set("o", "u", commented_lines_textobject,
	{ silent = true, desc = "Textobject for adjacent commented lines" })
EOF

" COMPLETION
set completeopt=menuone,noinsert
set pumheight=8 pumwidth=0
set shortmess+=c
lua << EOF
local cmp = require('cmp')
cmp.setup {
  completion = {
    completeopt = table.concat(vim.opt.completeopt:get(), ","),
  },
  snippet = {
    expand = function(args)
      require('snippy').expand_snippet(args.body)
    end,
  },
  window = {
    documentation = cmp.config.disable,
  },
  mapping = {
    ['<c-n>'] = function()
      if cmp.visible() then
        cmp.select_next_item({ behavior = "select" })
      else
        cmp.complete()
      end
    end,
    ['<c-p>'] = cmp.mapping.select_prev_item({ behavior = "select" }),
    ['<cr>']  = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
    { name = 'buffer' },
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = ({})[vim_item.kind]
      vim_item.menu = ({})[entry.source.name]
      return vim_item
    end
  },
}
EOF

" EDITING - CHANGE
nmap cp cip
nmap cw ciw
nmap cW ciW
nnoremap c "_c
nnoremap C "_C
xnoremap c "_c

" EDITING - COPY
nnoremap yp <cmd>silent normal myyap`y<cr>
nnoremap yw myyiw`y
nnoremap yW myyiW`y
xnoremap y <cmd>silent normal! myy`y<cr>

" EDITING - CUT
nnoremap <expr> dp &diff ? 'dp' : '<cmd>silent normal dap<cr>'
nnoremap dw daw
nnoremap dW daW
xnoremap d <cmd>silent normal! d<cr>

" EDITING - PASTE
inoremap <c-v> <c-r>+
nnoremap cP yap}p
nnoremap p <cmd>silent normal! p<cr>
nnoremap P <cmd>silent normal! P<cr>

" EDITING - REPLACE
lua require('substitute').setup()
nnoremap s <cmd>lua require('substitute').operator()<cr>
nnoremap sp <cmd>lua require('substitute').operator({ motion='ip' })<cr>
nnoremap sw <cmd>lua require('substitute').operator({ motion='iw' })<cr>
nnoremap sW <cmd>lua require('substitute').operator({ motion='iW' })<cr>
nnoremap S <cmd>lua require('substitute').eol()<cr>
nnoremap ss <cmd>lua require('substitute').line()<cr>
xnoremap ss <cmd>lua require('substitute').visual()<cr>

" EDITING - EXCHANGE
nnoremap sx <cmd>lua require('substitute.exchange').operator()<cr>
nnoremap sxw <cmd>lua require('substitute.exchange').operator({ motion='iw' })<cr>
nnoremap sxW <cmd>lua require('substitute.exchange').operator({ motion='iW' })<cr>
nnoremap sxx <cmd>lua require('substitute.exchange').line()<cr>
xnoremap sx <cmd>lua require('substitute.exchange').visual()<cr>

" EDITING - UNDO
nnoremap <c-r> <cmd>call ExeCmdAndRecenter('redo')<cr>
nnoremap U <cmd>call ExeCmdAndRecenter('redo')<cr>
nnoremap u <cmd>call ExeCmdAndRecenter('undo')<cr>

" FUNCTIONS
fun! ExeCmdAndRecenter(cmd)
  let old_lines = [line('w0'), line('w$')]
  silent execute a:cmd
  if !(line('w0') >= old_lines[0] && line('w$') <= old_lines[1])
    normal! zz
  endif
endfun

" https://stackoverflow.com/a/47051271
fun! GetVisualSelection()
  if mode()=="v"
    let [line_start, column_start] = getpos("v")[1:2]
    let [line_end, column_end] = getpos(".")[1:2]
  else
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
  end
  if (line2byte(line_start)+column_start) > (line2byte(line_end)+column_end)
    let [line_start, column_start, line_end, column_end] =
    \   [line_end, column_end, line_start, column_start]
  end
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - 1]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfun


" FILETYPE
autocmd group filetype diff set textwidth=72
autocmd group filetype hog set ft=udevrules
autocmd group filetype markdown set textwidth=80
let g:tex_flavor = 'latex'

" FORMATTING
nnoremap gqp gqip
nnoremap gqq Vgq

" FUZZY - CONFIG
lua << EOF
require('fzf-lua').setup {
  winopts = {
    border = 'single',
    preview = { hidden = 'hidden' },
    hl = { border = 'FloatBorder' },
  },
  files = {
    git_icons = false,
    file_icons = false,
  },
  git = {
    files = { git_icons = false, file_icons = false },
    status = { git_icons = false, file_icons = false },
  },
  oldfiles = {
    cwd_only = true,
    git_icons = false,
    file_icons = false,
  },
  grep = { git_icons = false, file_icons = false },
  helptags = { previewer = { _ctor = false } },
  lines = { git_icons = false, file_icons = false },
  lsp = { git_icons = false, file_icons = false },
  quickfix = { git_icons = false, file_icons = false },
}
EOF

" FUZZY - MAPPINGS (MISC)
nnoremap fb <cmd>lua require('fzf-lua').buffers()<cr>
nnoremap fB <cmd>lua require('fzf-lua').builtin()<cr>
nnoremap fc <cmd>lua require('fzf-lua').commands()<cr>
nnoremap ff <cmd>lua require('fzf-lua').files({ cmd = vim.env.FZF_DEFAULT_COMMAND })<cr>
nnoremap fh <cmd>lua require('fzf-lua').help_tags()<cr>
nnoremap fl <cmd>lua require('fzf-lua').blines()<cr>
nnoremap fo <cmd>lua require('fzf-lua').oldfiles()<cr>
nnoremap fQ <cmd>lua require('fzf-lua').loclist()<cr>
nnoremap fq <cmd>lua require('fzf-lua').quickfix()<cr>
nnoremap fR <cmd>lua require('fzf-lua').registers()<cr>

" FUZZY - MAPPINGS (GREP)
nnoremap fg <cmd>lua require('fzf-lua').grep()<cr>
nnoremap fG <cmd>lua require('fzf-lua').live_grep()<cr>
nnoremap fw <cmd>lua require('fzf-lua').grep_cword()<cr>
nnoremap fW <cmd>lua require('fzf-lua').grep_cWORD()<cr>
xnoremap fw <cmd>lua require('fzf-lua').grep_visual()<cr>

" FUZZY - MAPPINGS (LSP)
nnoremap fd <cmd>lua require('fzf-lua').lsp_definitions()<cr>
nnoremap fi <cmd>lua require('fzf-lua').lsp_implementations()<cr>
nnoremap fr <cmd>lua require('fzf-lua').lsp_references()<cr>
nnoremap fs <cmd>lua require('fzf-lua').lsp_document_symbols()<cr>
nnoremap fS <cmd>lua require('fzf-lua').lsp_workspace_symbols()<cr>

" GIT
autocmd group filetype floggraph nmap <buffer> <rightmouse> <leftmouse><cr>
autocmd group filetype floggraph nmap <buffer> <space>q <plug>(FlogQuit)
autocmd group filetype floggraph xmap <buffer> <rightmouse> <cr>
let g:flog_permanent_default_opts = { 'date': 'short' }
nnoremap <expr> <space>km &diff ? '<cmd>x<cr>zz' : '<cmd>Gdiffsplit<cr>'
nnoremap <space>kd <cmd>0G diff<cr>
nnoremap <space>kg :Flog -search=
nnoremap <space>kK <cmd>Flog -all -path=%<cr>
nnoremap <space>kk <cmd>Flog -all<cr>
nnoremap <space>kr <cmd>G reset --hard<bar>e<cr>

" GITGUTTER
autocmd group vimenter,bufwritepost * GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_show_msg_on_hunk_jumping = 0
nmap <space>i <cmd>GitGutterPreviewHunk<cr>
nmap <space>S <cmd>GitGutterStageHunk<cr>
nmap <space>u <cmd>silent GitGutterUndoHunk<cr>
nmap [c <cmd>silent GitGutterPrevHunk<cr>zz
nmap ]c <cmd>silent GitGutterNextHunk<cr>zz
set signcolumn=yes

" GREP
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m
command! -nargs=+ -complete=file_in_path Grep  silent grep!  <args>
command! -nargs=+ -complete=file_in_path LGrep silent lgrep! <args>
nnoremap <space>g :Grep<space>
nnoremap gw <cmd>Grep -w <cword><cr>
nnoremap gW <cmd>execute 'Grep -wF -- ' . GrepEscape(expand('<cWORD>'))<cr>
xnoremap gw <cmd>execute 'Grep -F -- '  . GrepEscape(GetVisualSelection())<cr>
fun! GrepEscape(pattern)
  return escape(a:pattern, '`%#"\|')
  \ ->substitute('\C<cword>',  '\\<cword>',  'g')
  \ ->substitute('\C<cWORD>',  '\\<cWORD>',  'g')
  \ ->substitute('\C<cexpr>',  '\\<cexpr>',  'g')
  \ ->substitute('\C<cfile>',  '\\<cfile>',  'g')
  \ ->substitute('\C<afile>',  '\\<afile>',  'g')
  \ ->substitute('\C<abuf>',   '\\<abuf>',   'g')
  \ ->substitute('\C<amatch>', '\\<amatch>', 'g')
  \ ->substitute('\C<sfile>',  '\\<sfile>',  'g')
  \ ->substitute('\C<stack>',  '\\<stack>',  'g')
  \ ->substitute('\C<script>', '\\<script>', 'g')
  \ ->substitute('\C<slnum>',  '\\<slnum>',  'g')
  \ ->substitute('\C<sflnum>', '\\<sflnum>', 'g')
  \ ->substitute('^\|$', '"', 'g')
endfun

" INCREMENT
nnoremap + <c-a>
nnoremap - <c-x>
set nrformats=
xnoremap + g<c-a>
xnoremap - g<c-x>

" INDENTATION
nnoremap <p <ap
nnoremap >p >ap
set expandtab
set shiftwidth=4
set tabstop=4

" LOADED
let g:loaded_2html_plugin = 0
let g:loaded_gzip = 0
let g:loaded_matchit = 0
let g:loaded_matchparen = 0
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
vim.diagnostic.disable()
vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
local border = 'single'
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K',  vim.lsp.buf.hover, bufopts)
end
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.ccls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    diagnostics = { onOpen = -1, onChange = -1, onSave = -1 },
  },
}
local servers = { 'jedi_language_server', 'marksman' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end
EOF

" MAKE
set makeprg=lint
set errorformat=%f:%l:%c:%m
set errorformat+=%f:%l:%c\ %m
set errorformat+=%f:%l:%m
set errorformat+=%f:%l\ %m
nnoremap <space>l <cmd>silent make! %<cr>

" MISC - MAPPINGS
inoremap <c-space> <space>
nnoremap <expr> <cr> &ft == 'qf' ? '<cr>' : 'o<esc>'
nnoremap guw myguiw`y
nnoremap guW myguiW`y
nnoremap gUw mygUiw`y
nnoremap gUW mygUiW`y
nnoremap J myJ`y
nnoremap Q q
xnoremap . :normal .<cr>
xnoremap q :'<,'>:normal @q<cr>

" MISC - SETTINGS
set clipboard=unnamedplus
set nofoldenable
set notimeout
set virtualedit=block

" MOTIONS
inoremap <c-l> <right>
nnoremap <c-i> <c-i>zz
nnoremap <c-o> <c-o>zz
noremap <silent> n nzz
noremap <silent> N Nzz
nnoremap A g$a
nnoremap I g0i
noremap $ g$
noremap 0 g0
noremap ^ g^
noremap gl g$
noremap gh g0
noremap gH g^
noremap gg gg0
noremap G G0
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

" QUICKFIX
autocmd group filetype qf set nonu | setl wrap
autocmd group quickfixcmdpost [^l]* cwindow
autocmd group quickfixcmdpost l* lwindow
nnoremap <space>q <cmd>QFToggle!<cr>
nnoremap [q <cmd>QPrev<cr>
nnoremap ]q <cmd>QNext<cr>
lua << EOF
require('qf_helper').setup({
  quickfix = {
    max_height = 10,
    min_height = 10,
  },
  loclist = {
    max_height = 10,
    min_height = 10,
  },
})
require('bqf').setup{
  preview = {
    auto_preview = false,
    border_chars = { '│', '│', '─', '─', '┌', '┐', '└', '┘', '█' },
    show_title = false,
  },
  func_map = { split = '<c-s>', },
  filter = { fzf = { action_for = { ['ctrl-s'] = 'split' } } },
}
EOF
highlight! link bqfpreviewrange none
highlight bqfsign ctermfg=yellow

" ROOTER
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_resolve_links = 1
let g:rooter_silent_chdir = 1

" SANDWICH
let g:textobj_sandwich_no_default_key_mappings = 1
nmap saw saiw
nmap saW saiW

" SCROLLING
nnoremap <a-d> 4<c-y>
nnoremap <a-f> 4<c-e>

" SEARCH
cno <expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter><cmd>echo<bar>noh<cr>zz' : '<enter>'
nnoremap <esc> <cmd>echo<bar>noh<cr><esc>
nnoremap <a-esc> <cmd>set hls<cr>
nnoremap <space>r :%s/\<<c-r><c-w>\>//gI<left><left><left>
nnoremap ,w <cmd>let @/= expand('<cword>')<bar>set hls<cr>
xnoremap ,w <cmd>let @/= GetVisualSelection()<bar>set hls<cr><esc>
set ignorecase smartcase
set shortmess+=Ss

" SNIPPETS
lua << EOF
require('snippy').setup({
  mappings = {
    is = {
      ['<tab>'] = 'expand_or_advance',
      ['<a-Tab>'] = 'previous',
    },
    nx = {
      ['<leader>x'] = 'cut_text',
    },
  },
})
EOF

" SORT
nmap <silent> gs myvii:sort i<cr>`y
xnoremap <silent> gs my:sort i<cr>`y

" SPELL
set spellcapcheck=
set spellfile=$XDG_DATA_HOME/nvim/spell/en.utf-8.add

" STATUS (CMDLINE/RULER/STATUSLINE)
nnoremap <expr> ,s &ls ? '<cmd>se stl=%= ls=0<cr>' : '<cmd>se ls=3 stl=\[%f\]%=\[%l/%L\]<cr>'
set fillchars+=diff:\ ,eob:\ ,fold:─,foldsep:│,stl:─,stlnc:─,vert:│
set noshowcmd noshowmode
set rulerformat=%=\[%l/%L\] noruler
set statusline=%= laststatus=0

" TABLINE
set showtabline=1
set tabline=%!TabLine()
fun! TabLine()
  let tabline = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let tabline .= '%#TabLineSel#'
    else
      let tabline .= '%#TabLine#'
    endif
    let tabline .= '%' . (i + 1) . 'T' . '[' . (i + 1) . '] '
  endfor
  let tabline .= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let tabline .= '%=%#TabLineSel'
  endif
  return tabline
endfun

" TEXTOBJ - Variable-Segment
nmap cv civ
nmap dv dav
nmap yv myyiv`y

" TEXTOBJ - Word-Column
let g:textobj_wordcolumn_no_default_key_mappings = 1
call textobj#user#map('wordcolumn', {
            \ 'word' : {
            \   'select-i' : 'iq',
            \   'select-a' : 'aq',
            \   },
            \ 'WORD' : {
            \   'select-i' : 'iQ',
            \   'select-a' : 'aQ',
            \   },
            \ })
nmap cq 0ciq
nmap dq my0diq`y

" SWITCH
let g:switch_custom_definitions = [
\ ['+', '-'],
\ ['0', '1'],
\ ['<', '>'],
\ ['==', '!='],
\ ['on', 'off'],
\ ['pick', 'fixup', 'reword'],
\ ['yes', 'no'],
\]
let g:switch_mapping = 't'

" TABS
nnoremap <a-e> <cmd>tabp<cr>
nnoremap <a-r> <cmd>tabn<cr>
nnoremap <space>n <cmd>tab sp<cr>
tnoremap <silent> <a-e> <c-\><c-n><cmd>tabp<cr>
tnoremap <silent> <a-r> <c-\><c-n><cmd>tabn<cr>

" TARGETS
autocmd group user targets#mappings#user call targets#mappings#extend({
\ 'q': {}, 'b': {
\   'pair': [{'o':'(', 'c':')'}, {'o':'[', 'c':']'}, {'o':'{', 'c':'}'}, {'o':'<', 'c':'>'}],
\   'quote': [{'d':"'"}, {'d':'"'}, {'d':'`'}]
\ },
\})
nmap cb cIb
nmap db dIb
nmap sb sIb
nmap yb myyIb`y
nmap cnb cInb
nmap dnb dInb
nmap snb sInb
nmap ynb myyInb`y

" TERMINAL
autocmd group bufenter,focusgained,termopen term://* startinsert
autocmd group termopen * nnoremap <buffer><leftrelease> <leftrelease>i
autocmd group termopen * setlocal signcolumn=no

" WILDMENU
set path-=/usr/include path+=**
set wildcharm=<c-z>
set wildignore+=*.o
set wildignore+=*.pdf
set wildignore+=*.zip
set wildignore+=*/.ccls_cache/*
set wildignore+=*/.git/*
set wildignore+=*/.idea/*
set wildignore+=*/.vscode/*
set wildignore+=*/__pycache__/*
set wildignore+=*/build/*
set wildmode=longest:list,full

" WINDOWS
autocmd group vimresized * wincmd =
nnoremap <a-h> <cmd>lua require('tmux').move_left()<cr>
nnoremap <a-j> <cmd>lua require('tmux').move_down()<cr>
nnoremap <a-k> <cmd>lua require('tmux').move_up()<cr>
nnoremap <a-l> <cmd>lua require('tmux').move_right()<cr>
nnoremap <space>c <c-w>czz
nnoremap <space>s <c-w>s
nnoremap <space>v <c-w>v
nnoremap <space>z <c-w>z
set splitbelow splitright
tnoremap <silent> <a-h> <c-\><c-n><cmd>lua require('tmux').move_left()<cr>
tnoremap <silent> <a-j> <c-\><c-n><cmd>lua require('tmux').move_down()<cr>
tnoremap <silent> <a-k> <c-\><c-n><cmd>lua require('tmux').move_up()<cr>
tnoremap <silent> <a-l> <c-\><c-n><cmd>lua require('tmux').move_right()<cr>

" WRAP
autocmd group filetype * set formatoptions-=t
set breakindent
set breakindentopt=shift:2
set linebreak

if $TERM ==# 'linux' || $TERM ==# 'screen'
  set showbreak=¬\ 
else
  set showbreak=↳\ 
endif
