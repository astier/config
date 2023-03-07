autocmd completion CompleteDone * call s:CompleteDone()

function! completion#CanComplete() abort
  " Exit if cursor is at the beginning of line
  if col('.') <= 1 | return v:false | endif
  " Exit if cursor is preceded by space
  let char = getline('.')[:col('.') - 2]
  let char = strcharpart(char, strchars(char) - 1)
  return char !=# ' ' && char !=# "\t"
endfunction

function! completion#Complete() abort
  if b:completion ==# 'omni'
    let b:completion = 'buffer'
    call feedkeys("\<c-x>\<c-o>", 'n')
  elseif b:completion ==# 'buffer'
    let b:completion = GetCompletion()
    call feedkeys("\<c-x>\<c-n>", 'n')
  endif
  return ''
endfunction

function! completion#Check(timer) abort
  if pumvisible()
    let b:completion = GetCompletion()
  else
    call completion#Complete()
  endif
endfunction

function! s:CompleteDone() abort
  " Do nothing if no selection inserted
  if empty(v:completed_item)
    " If omni-completion was just executed start a timer to check if it has
    " results or if the next completion-method should be tried
    if GetCompletion() != b:completion
      call timer_start(0, 'completion#Check', { 'repeat': 0 })
    endif
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
