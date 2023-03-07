augroup lastpos
  autocmd!
  autocmd bufread * call s:RestoreLastPos()
augroup end

function! s:RestoreLastPos() abort
  let ignore_bt = ['acwrite', 'help', 'nofile', 'terminal']
  let ignore_ft = ['', 'git', 'gitcommit', 'gitrebase', 'man']
  if index(ignore_bt, &buftype) < 0 && index(ignore_ft, &filetype) < 0
    silent! normal! g`"zz
  endif
endfunction
