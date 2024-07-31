set nocompatible
set runtimepath^=../..
set runtimepath+=../../after
filetype plugin indent on
syntax enable
set nolazyredraw

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! Scroll()
    let LINES = line('$')
    syntime on
    for s:x in range(2*LINES/winheight(0))
      norm! 
      redraw!
    endfor
endfunction

nnoremap zS :call SynStack()<CR>
color desert

nnoremap q :qall!<cr>
"set regexpengine=1

let g:vimtex_syntax_conceal_disable = 1
"let g:vimtex_syntax_conceal_disable = 0
"set conceallevel=2
let g:vimtex_syntax_match_unicode = 0
silent edit main.tex
call Scroll()
silent edit main2.tex
call Scroll()
silent edit main3.tex
call Scroll()


let lines = split(execute('syntime report'), "\n")
call writefile(lines, "out.log")

quitall
