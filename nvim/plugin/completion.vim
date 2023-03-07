augroup completion
  autocmd!
  autocmd BufRead * let b:completion = GetCompletion()
augroup end

function! GetCompletion()
  if &omnifunc !=# ''
    return 'omni'
  else
    return 'buffer'
  endif
endfunction
