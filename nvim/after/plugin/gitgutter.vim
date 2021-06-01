if !exists('g:vscode') && exists('#gitgutter')
    au! gitgutter cursorhold,cursorholdi
en
