if !exists('g:vscode') && exists('#gitgutter')
  autocmd! gitgutter cursorhold,cursorholdi,cursormoved
  autocmd  gitgutter bufwritepost * GitGutter
  let g:gitgutter_floating_window_options['border'] = 'single'
endif
