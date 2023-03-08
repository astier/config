" https://gist.github.com/wellle/8633440

function! yank#AndJumpBack() abort
    let g:save_cursor = getpos('.')
    set operatorfunc=yank#YankAndJumpBack
endfunction

function! yank#YankAndJumpBack(type, ...) abort
    if a:0
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'line'
        silent execute "normal! '[V']y"
    elseif a:type ==# 'block'
        silent execute "normal! `[\<C-V>`]y"
    else
        silent execute "normal! `[v`]y"
    endif
    call setpos('.', g:save_cursor)
endfunction
