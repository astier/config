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
  " Determine next compl-method
  if s:method_idx < len(b:compl_methods) - 1
    let s:method_idx += 1
  else
    let s:method_idx = 0
  endif
  " Prevent compl-filename from completing based on the relative path
  let method = b:compl_methods[s:method_idx - 1]
  if method ==# 'filename'
    " Get cWORD left from cursor
    let pos = getpos('.')
    call cursor(pos[1], pos[2] - 1)
    let word = expand('<cWORD>')
    call cursor(pos)
    " Use compl-filename only for words with certain prefixes
    if word =~# '^\(/\|./\|\$\|\\\$\|~\)'
      return s:keys[method]
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
