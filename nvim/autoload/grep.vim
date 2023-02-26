" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
fun! grep#Expand(...) abort
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfun

" https://www.reddit.com/r/vim/comments/11byhfd/comment/ja2skxb/?utm_source=share&utm_medium=web2x&context=3
fun! grep#Escape(args, pattern, file) abort
  return system(join([&grepprg, a:args, '-F', '--', shellescape(a:pattern), a:file], ' '))
endfun
