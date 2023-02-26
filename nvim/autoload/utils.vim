fun! utils#ExeCmdAndRecenter(cmd) abort
  let old_lines = [line('w0'), line('w$')]
  silent execute a:cmd
  if !(line('w0') >= old_lines[0] && line('w$') <= old_lines[1])
    normal! zz
  endif
endfun
