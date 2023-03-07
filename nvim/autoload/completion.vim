augroup completion
  autocmd!
  autocmd CompleteDone * call s:CompleteDone()
augroup end

function! s:GetMainMethod() abort
  if &omnifunc !=# ''
    return 'omni'
  else
    return 'buffer'
  endif
endfunction

function! completion#SetMethod() abort
  let b:next_method = s:GetMainMethod()
endfunction

function! completion#CanComplete() abort
  " Exit if cursor is at the beginning of line
  if col('.') <= 1 | return v:false | endif
  " Exit if cursor is preceded by space
  let char = getline('.')[:col('.') - 2]
  let char = strcharpart(char, strchars(char) - 1)
  return char !=# ' ' && char !=# "\t"
endfunction

function! completion#Check(timer) abort
  if pumvisible()
    let b:next_method = s:GetMainMethod()
  else
    call completion#Complete()
  endif
endfunction

function! completion#Complete() abort
  if b:next_method ==# 'omni'
    let b:next_method = 'buffer'
    call feedkeys("\<c-x>\<c-o>", 'n')
    call timer_start(64, 'completion#Check', { 'repeat': 0 })
  elseif b:next_method ==# 'buffer'
    let b:next_method = s:GetMainMethod()
    call feedkeys("\<c-x>\<c-n>", 'n')
  endif
  return ''
endfunction

function! s:CompleteDone() abort
  try
    if v:completed_item['user_data']['nvim']['lsp']['completion_item']['kind'] == 3
      call feedkeys("()\<left>", 'nt')
    endif
  catch
  endtry
endfunction
