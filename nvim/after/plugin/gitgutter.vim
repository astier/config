if !exists('g:vscode') && exists('#gitgutter')
    au! gitgutter CursorHold,CursorHoldI
en
