augroup compl
  autocmd!
  autocmd CompleteDone * call s:CompleteDone()
augroup end

let g:compl = 'omni'

function! compl#CanComplete() abort
  " Exit if cursor is at the beginning of line
  if col('.') <= 1 | return v:false | endif
  " Exit if cursor is preceded by space or tab
  let char = getline('.')[:col('.') - 2]
  let char = strcharpart(char, strchars(char) - 1)
  return char !=# ' ' && char !=# "\t"
endfunction

function! compl#Complete() abort
  if g:compl ==# 'omni'
    let g:compl = 'current'
    if &omnifunc !=# ''
      call feedkeys("\<c-x>\<c-o>", 'n')
    else
      call compl#Complete()
    endif
  elseif g:compl ==# 'current'
    let g:compl = 'omni'
    call feedkeys("\<c-x>\<c-n>", 'n')
  endif
  return ''
endfunction

function! s:CompleteDone() abort
  " Check if selection was inserted
  if empty(v:completed_item)
    " If compl-omni was just executed start a timer to check if it has results
    " otherwise try the next compl-method
    if g:compl !=# 'omni'
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
    let g:compl = 'omni'
  else
    call compl#Complete()
  endif
endfunction
