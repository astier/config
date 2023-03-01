function! view#FileIsIgnored()
  let ignore_bt = ['acwrite', 'help', 'nofile', 'terminal']
  let ignore_ft = ['', 'git', 'gitcommit', 'gitrebase', 'man']
  return index(ignore_bt, &buftype) >= 0 || index(ignore_ft, &filetype) >= 0
endfunction
