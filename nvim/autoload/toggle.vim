let s:chars = [
  \ [ '+', '-' ],
  \ [ '1', '0' ],
\]

let s:words = [
  \ [ 'on', 'off' ],
  \ [ 'yes', 'no' ],
  \ [ 'true', 'false' ],
  \ [ 'True', 'False' ],
  \ [ 'pick', 'fixup', 'reword' ],
\]

let s:WORDS = [
  \ [ '<=', '>' ],
  \ [ '>=', '<' ],
  \ [ '==', '!=' ],
  \ [ '||', '&&' ],
\]

function! s:Next(lists, expr)
  for list in a:lists
    let i = index(list, a:expr)
    if i >= 0
      if i + 1 < len(list)
        return list[i + 1]
      else
        return list[0]
      endif
    endif
  endfor
  return ''
endfunction

function! toggle#Next() abort
  let char = getline('.')[col('.') - 1]
  if char ==# ' '
    return
  endif
  let replacement = s:Next(s:chars, char)
  if !empty(replacement)
    execute 'normal! r' . replacement
    return
  endif
  let replacement = s:Next(s:words, expand('<cword>'))
  if !empty(replacement)
    let pos = getcurpos()
    execute 'normal! ciw' . replacement
    call setpos('.', pos)
    return
  endif
  let replacement = s:Next(s:WORDS, expand('<cWORD>'))
  if !empty(replacement)
    let pos = getcurpos()
    execute 'normal! ciW' . replacement
    call setpos('.', pos)
    return
  endif
endfunction
