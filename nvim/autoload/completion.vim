function! completion#TextBeforeCursor() abort
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
    return "\<c-x>\<c-n>"
  endif
endfunction
