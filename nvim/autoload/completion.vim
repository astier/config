augroup completion
  autocmd!
  autocmd CompleteDone * call s:CompleteDone()
augroup end

let g:completion = 'omni'

function! completion#CanComplete() abort
  " Exit if cursor is at the beginning of line
  if col('.') <= 1 | return v:false | endif
  " Exit if cursor is preceded by space or tab
  let char = getline('.')[:col('.') - 2]
  let char = strcharpart(char, strchars(char) - 1)
  return char !=# ' ' && char !=# "\t"
endfunction

function! completion#Complete() abort
  if g:completion ==# 'omni'
    let g:completion = 'keyword'
    if &omnifunc !=# ''
      call feedkeys("\<c-x>\<c-o>", 'n')
    else
      call completion#Complete()
    endif
  elseif g:completion ==# 'keyword'
    let g:completion = 'omni'
    call feedkeys("\<c-x>\<c-n>", 'n')
  endif
  return ''
endfunction

function! s:CompleteDone() abort
  " Check if selection was inserted
  if empty(v:completed_item)
    " If omni-completion was just executed start a timer to check if it has
    " results or if the next completion-method should be tried
    if g:completion !=# 'omni'
      call timer_start(0, 'completion#Next', { 'repeat': 0 })
    endif
  else
    " Append parentheses if selection is a lsp-function
    try
      if v:completed_item['user_data']['nvim']['lsp']['completion_item']['kind'] == 3
        call feedkeys("()\<left>", 'nt')
      endif
    catch
    endtry
  endif
endfunction

function! completion#Next(timer) abort
  if pumvisible()
    let g:completion = 'omni'
  else
    call completion#Complete()
  endif
endfunction
