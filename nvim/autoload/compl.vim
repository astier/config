augroup compl
  autocmd!
  autocmd CompleteDone * call s:CompleteDone()
augroup end

inoremap <expr> <plug>(Complete) <sid>Complete()
imap <plug>(compl-complete) <plug>(Complete)<cmd>call <sid>TryNextMethod()<cr>

let s:methods = [ 'omni', 'filename', 'current' ]
let g:method = 0

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
  if g:method < len(s:methods) - 1
    let g:method += 1
  else
    let g:method = 0
  endif
  return s:keys[s:methods[g:method - 1]]
endfunction

function! s:TryNextMethod() abort
  if pumvisible()
    let g:method = 0
  else
    if g:method != 0
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
