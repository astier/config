autocmd compl CompleteDone * call s:CompleteDone()

inoremap <expr> <plug>(Complete) <sid>Complete()
imap <plug>(compl-complete) <plug>(Complete)<cmd>call <sid>TryNextMethod()<cr>

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
  if s:method_idx < len(b:compl_methods) - 1
    let s:method_idx += 1
  else
    let s:method_idx = 0
  endif
  let method = b:compl_methods[s:method_idx - 1]
  " Use compl-filename only for words with a certain prefix to prevent completing the relative path for all words.
  if method ==# 'filename'
    " Get cWORD left from cursor. Because in insert-mode the cursor is not directly on the word which should be completed, vim searches for the next cWORD to the right of the cursor. To circumvent this move the cursor one character to the left so it is placed on cWORD, get cWORD and move the cursor back to its original position.
    let pos = getpos('.')
    call cursor(pos[1], pos[2] - 1)
    let word = expand('<cWORD>')
    call cursor(pos)
    " If cWORD starts with a certain prefix use compl-filename. Otherwise try the next compl-method. The prefixes are: / ./ $ \$ ~
    if word =~# '^\(/\|./\|\$\|\\\$\|~\)'
      return s:keys[method]
    " Use next compl-method
    elseif s:method_idx != 0
      return s:Complete()
    else
      return ''
    endif
  endif
  return s:keys[method]
endfunction

function! s:TryNextMethod() abort
  if pumvisible()
    let s:method_idx = 0
  else
    if s:method_idx != 0
      call feedkeys("\<plug>(compl-complete)")
    endif
  endif
endfunction

function! s:CompleteDone() abort
  " Do nothing if selection is empty
  if empty(v:completed_item)
    return
  endif
  " Append parentheses if selection is a lsp-function
  try
    if v:completed_item['user_data']['nvim']['lsp']['completion_item']['kind'] == 3
      call feedkeys("()\<left>", 'nt')
    endif
  catch
  endtry
endfunction
