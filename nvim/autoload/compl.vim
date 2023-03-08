augroup compl
  autocmd!
  autocmd CompleteDone * call s:CompleteDone()
augroup end

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

function! compl#Complete() abort
  call feedkeys(s:keys[s:methods[g:method]], 'n')
  if g:method < len(s:methods) - 1
    let g:method += 1
  else
    let g:method = 0
  endif
  return '' " Prevent outputting 0 in <expr>-mappings
endfunction

function! s:CompleteDone() abort
  " Check if selection was inserted
  if empty(v:completed_item)
    " Try the next compl-method if more methods are left to try
    if g:method != 0
      call timer_start(0, 'compl#Next', { 'repeat': 0 })
    endif
  else
    " Append parentheses if selection is a lsp-function
    try
      if v:completed_item['user_data']['nvim']['lsp']['completion_item']['kind'] == 3
        call feedkeys("()\<left>", 'nt')
      endif
    catch
    endtry
  endif
endfunction

function! compl#Next(timer) abort
  if pumvisible()
    let g:method = 0
  else
    call compl#Complete()
  endif
endfunction
