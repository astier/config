function! tabline#Show() abort
  let tabline = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let tabline .= '%#TabLineSel#'
    else
      let tabline .= '%#TabLine#'
    endif
    let tabline .= '%' . (i + 1) . 'T' . '[' . (i + 1) . '] '
  endfor
  let tabline .= '%#TabLineFill#%T'
  if tabpagenr('$') > 1
    let tabline .= '%=%#TabLineSel'
  endif
  return tabline
endfunction
