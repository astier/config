augroup completion | autocmd! | augroup end
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
  if &omnifunc !=# ''
    return "\<c-x>\<c-o>"
  else
    return "\<c-n>"
  endif
endfunction

function! s:CompleteDone() abort
  try
    if v:completed_item['user_data']['nvim']['lsp']['completion_item']['kind'] == 3
      call feedkeys("()\<left>", 'nt')
    endif
  catch
  endtry
endfunction
