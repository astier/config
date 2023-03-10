augroup compl
  autocmd!
  autocmd compl CompleteDone * call s:CompleteDone()
augroup end

inoremap <expr> <plug>(Complete) <sid>Complete()
imap <plug>(compl-complete) <plug>(Complete)<cmd>call <sid>TryNextMethod()<cr>

" omnifunc=v:lua.vim.lsp.omnifunc breaks this script
" https://github.com/neovim/neovim/issues/12390
let s:methods = [ 'filename', 'omni', 'current', ]
let s:method_idx = 0

let s:keys = {
  \ 'current':  "\<c-x>\<c-n>",
  \ 'filename': "\<c-x>\<c-f>",
  \ 'omni':     "\<c-x>\<c-o>",
\}

function! compl#CanComplete() abort
  " Check if cursor is at the beginning of line
  if col('.') <= 1 | return v:false | endif
  " Check if cursor is preceded by space or tab
  let char = getline('.')[:col('.') - 2]
  let char = strcharpart(char, strchars(char) - 1)
  return char !=# ' ' && char !=# "\t"
endfunction

function! s:Complete() abort
  " Determine next compl-method
  if s:method_idx < len(s:methods) - 1
    let s:method_idx += 1
  else
    let s:method_idx = 0
  endif
  let method = s:methods[s:method_idx - 1]
  " Skip filename if cWORD left of cursor doesn't have the correct prefix
  if method ==# 'filename'
    let pos = getpos('.')
    call cursor(pos[1], pos[2] - 1)
    let word = expand('<cWORD>')
    call cursor(pos)
    if !(word =~# '^\(/\|\./\|\$\|\\\$\|\~\)')
      return s:NextMethod()
    endif
  elseif method ==# 'omni' && &omnifunc ==# ''
    return s:NextMethod()
  endif
  return s:keys[method]
endfunction

function! s:NextMethod() abort
  if s:method_idx != 0
    return s:Complete()
  else
    return ''
  endif
endfunction

function! s:TryNextMethod() abort
  if pumvisible()
    let s:method_idx = 0
  elseif s:method_idx != 0
    call feedkeys("\<plug>(compl-complete)")
  endif
endfunction

function! s:CompleteDone() abort
  " Append parentheses if selection is a lsp-function
  if !empty(v:completed_item)
    try
      if v:completed_item['user_data']['nvim']['lsp']['completion_item']['kind'] == 3
        call feedkeys("()\<left>", 'nt')
      endif
    catch
    endtry
  endif
endfunction
