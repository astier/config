hi clear
syntax reset

" *
hi comment ctermbg=none ctermfg=8 cterm=italic
hi constant ctermbg=none ctermfg=green cterm=none
hi identifier ctermbg=none ctermfg=cyan cterm=none
hi preproc ctermbg=none ctermfg=blue cterm=none
hi special ctermbg=none ctermfg=cyan cterm=none
hi statement ctermbg=none ctermfg=blue cterm=none
hi type ctermbg=none ctermfg=blue cterm=none
hi! link todo comment
hi! link underlined none

" C
hi! link cconstant none " constant
hi! link cincluded none " cstring->string
hi! link coperator none " operator->statement

" CURSORLINE
hi cursorlinenr ctermbg=none ctermfg=none cterm=none " none
hi linenr ctermbg=none ctermfg=8 cterm=none " none
hi! link cursorline visual " none

" DIFF
hi diffadd ctermbg=red ctermfg=black cterm=none " none
hi diffchange ctermbg=yellow ctermfg=black cterm=none " none
hi diffdelete ctermbg=green ctermfg=black cterm=none " none
hi difftext ctermbg=red ctermfg=black cterm=none " none

" ERROR
hi! link error none " none
hi! link errormsg none " none
hi! link warningmsg none " none

" FOLD
hi foldcolumn ctermbg=none ctermfg=8 cterm=none " none
hi folded ctermbg=none ctermfg=8 cterm=none " none

" GIT
hi diffadded ctermbg=none ctermfg=green cterm=none " identifier
hi diffremoved ctermbg=none ctermfg=red cterm=none " special
hi! link difffile comment " type
hi! link diffindexline comment " preproc
hi! link gitdate none " number
hi! link gitemail none " special
hi! link gitemaildelimiter none " delimiter
hi! link gitidentity none " string
hi! link gitrebasesummary none " string

" MARKDOWN
hi! link markdownHeadingDelimiter comment " delimiter->special
hi! link markdownurl special " float

" MISC
hi directory ctermbg=none ctermfg=blue cterm=none " none
hi healthsuccess ctermbg=none ctermfg=green cterm=none " none
hi netrwMarkFile ctermbg=none ctermfg=yellow cterm=none " tablinesel
hi visual ctermbg=black ctermfg=none cterm=none " none
hi wildmenu ctermbg=none ctermfg=none cterm=none " none
hi! link boolean none " constant
hi! link function none " identifier
hi! link number none " constant
hi! link plugdeleted none " ignore
hi! link question none " none
hi! link signcolumn none " none
hi! link title comment " none

" PMENU
hi pmenu ctermbg=0 ctermfg=none cterm=none " none
hi pmenusbar ctermbg=black ctermfg=none cterm=none " none
hi pmenusel ctermbg=8 ctermfg=none cterm=none " none
hi pmenuthumb ctermbg=8 ctermfg=none cterm=none " none

" SEARCH
hi incsearch ctermbg=yellow ctermfg=black cterm=none " none
hi search ctermbg=none ctermfg=red cterm=none " none

" STATUSLINE
hi statusline ctermbg=none ctermfg=8 cterm=none " none
hi statuslinenc ctermbg=none ctermfg=8 cterm=none " none
hi vertsplit ctermbg=none ctermfg=8 cterm=none " none

" VIM
hi! link vimautocmdmod none " special
hi! link vimenvvar none " preproc
hi! link vimfuncvar none " identifier
hi! link vimgroup none " type
hi! link vimhiattrib none " preproc
hi! link vimoption none " preproc
hi! link vimparensep none " delimiter->special
hi! link vimsep none " delimiter->special
hi! link vimspecial none " type
hi! link vimvar none " identifier

" SH
hi! link shalias none " identifier
hi! link shcommandsub none " special
hi! link shquote none " operator->statement
hi! link shrange none " shoperator->operator->statement
hi! link shset none " statement
hi! link shsetlist none " identifier
hi! link shshellvariables none " preproc
hi! link shstatement none " statement
hi! link shtestpattern none " shstring->string->constant
hi! link shvarassign statement " none

" SPELL
hi spellbad ctermbg=none ctermfg=red cterm=none " none
hi! link spellrare none " none

" TABLINE
hi tabline ctermbg=none ctermfg=8 cterm=none " none
hi tablinefill ctermbg=none ctermfg=none cterm=none " none
hi tablinesel ctermbg=none ctermfg=none cterm=none " none
