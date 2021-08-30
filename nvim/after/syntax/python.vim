" show a ruler at column 80
setlocal cc=100
" replace tab with spaces
setlocal expandtab
" indent with 4 spaces
setlocal softtabstop=4
setlocal shiftwidth=4

" Disable spell-checking for single (non-triple) quoted strings
syn region  pythonString matchgroup=pythonQuotes
      \ start=+[uU]\=\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=pythonEscape,@NoSpell
syn region  pythonRawString matchgroup=pythonQuotes
      \ start=+[uU]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
      \ contains=@NoSpell
