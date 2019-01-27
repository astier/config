" Misc
au BufEnter * se fo-=cro
au FocusGained,BufEnter * checkt
nnoremap ,r :%s//g<left><left>
nnoremap <cr> o<esc>
nnoremap <silent>,, :e $MYVIMRC<cr>
nnoremap <silent># *<s-n>
nnoremap <silent><esc> :noh<cr><esc>
se autochdir
se autowriteall
se confirm
se expandtab shiftwidth=4
se laststatus=1
se mouse=a
se noshowmode
se number relativenumber
se scrolloff=5
se splitbelow splitright
se termguicolors
se title titlestring=%t

" Brackets
inoremap { {}<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap ' ''<left>
inoremap " ""<left>

" Wrap
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap 0 g0
se breakindent linebreak

" Windows & Buffers
nnoremap <silent>,c :clo<cr>
tnoremap <silent>,c <c-\><c-n>:clo<cr>
nnoremap <silent>,q :xa<cr>
tnoremap <silent>,q <c-\><c-n>:xa<cr>

" Terminal
au BufEnter term://* star
au TermOpen * :setl nonu nornu scl=no | star
tnoremap ,<esc> <c-\><c-n>
