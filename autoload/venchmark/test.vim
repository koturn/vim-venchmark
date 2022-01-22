" ============================================================================
" FILE: test.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" DESCRIPTION: {{{
" Simple Vim script benchmarker.
" }}}
" ============================================================================
let s:save_cpo = &cpo
set cpo&vim


function! venchmark#test#eval(n, expr, ...) abort " {{{
  let start = reltime()
  for i in range(1, a:n)
    let _ = eval(a:expr)
  endfor
  return str2float(reltimestr(reltime(start)))
endfunction " }}}

function! venchmark#test#equals(n, x, y) abort " {{{
  let start = reltime()
  for i in range(1, a:n)
    let _ = a:x == a:y
  endfor
  return str2float(reltimestr(reltime(start)))
endfunction " }}}

function! venchmark#test#string_equals(n, x, y) abort " {{{
  let start = reltime()
  for i in range(1, a:n)
    let _ = a:x ==# a:y
  endfor
  return str2float(reltimestr(reltime(start)))
endfunction " }}}

function! venchmark#test#regex_equals(n, text, pattern) abort " {{{
  let start = reltime()
  for i in range(1, a:n)
    let _ = a:text =~# a:pattern
  endfor
  return str2float(reltimestr(reltime(start)))
endfunction " }}}

function! venchmark#test#match(n, text, pattern) abort " {{{
  let start = reltime()
  for i in range(1, a:n)
    call match(a:text, a:pattern)
  endfor
  return str2float(reltimestr(reltime(start)))
endfunction " }}}

function! venchmark#test#call(n, function, ...) abort " {{{
  if a:0 > 0
    let start = reltime()
    for i in range(1, a:n)
      call call(a:function, a:000)
    endfor
  else
    let start = reltime()
    for i in range(1, a:n)
      call a:function()
    endfor
  endif
  return str2float(reltimestr(reltime(start)))
endfunction " }}}

function! venchmark#test#execute(n, cmd) abort " {{{
  let start = reltime()
  for i in range(1, a:n)
    execute a:cmd
  endfor
  return str2float(reltimestr(reltime(start)))
endfunction " }}}

function! venchmark#test#script(n, src) abort " {{{
  let [src, start] = [expand(a:src), reltime()]
  for i in range(1, a:n)
    source `=src`
  endfor
  return str2float(reltimestr(reltime(start)))
endfunction " }}}


let &cpo = s:save_cpo
unlet s:save_cpo
