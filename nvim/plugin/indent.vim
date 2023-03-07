augroup indent
  autocmd!
  autocmd bufread * call s:DetectIndent()
augroup end

function! s:DetectIndent() abort
  let file = expand('%')
  " tab
  call system("grep -qm1 \"$(printf '\t')\" " . file)
  if !v:shell_error
    set noexpandtab
    return
  endif
  " spaces ('wc -c' counts one char too many)
  let num_spaces = system('grep -om1 "^ \+" ' . file . ' | wc -c') - 1
  if num_spaces != -1
    set expandtab
    execute 'set shiftwidth=' . num_spaces
    execute 'set tabstop=' . num_spaces
    return
  endif
endfunction
