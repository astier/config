augroup compl
  autocmd!
  autocmd VimEnter,BufNewFile,BufRead * call s:ComplSetup()
augroup end

function! s:ComplSetup()
  if !exists('b:compl_methods')
    let b:compl_methods = [ 'filename', 'omni', 'current', ]
    if &omnifunc ==# ''
      let omni_idx = index(b:compl_methods, 'omni')
      if omni_idx >= 0
        call remove(b:compl_methods, omni_idx)
      endif
    endif
  endif
endfunction
