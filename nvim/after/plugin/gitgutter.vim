if !exists('g:vscode') && exists('#gitgutter')
  autocmd! gitgutter cursorhold,cursorholdi
  autocmd  gitgutter bufwritepost * GitGutter
endif
