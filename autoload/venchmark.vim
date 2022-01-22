" ============================================================================
" FILE: venchmark.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" DESCRIPTION: {{{
" Simple Vim script benchmarker.
" }}}
" ============================================================================
let s:save_cpo = &cpo
set cpo&vim

let s:TYPE_FUNCREF = type(function('function'))
let s:venchmarker_nr = 0

function! venchmark#new(...) abort
  let venchmarker = copy(s:Venchmarker)
  if a:0 == 0
    let venchmarker.__name = 'Venchmarker_' . s:venchmarker_nr
    let s:venchmarker_nr += 1
  else
    let venchmarker.__name = a:1
  endif
  return venchmarker
endfunction


let s:Venchmarker = {}

function! s:Venchmarker.run(...) abort dict
  let n = a:0 > 0 ? a:1 : 1
  let funcs = filter(keys(filter(copy(self), 'type(v:val) == s:TYPE_FUNCREF')), 'v:val !=# "run"')
  let maxlen = max(map(copy(funcs), 'strlen(v:val)'))
  let time_dict = {}
  for funcname in funcs
    let time_dict[funcname] = 0.0
  endfor
  echomsg 'Profile:' self.__name
  for i in range(1, n)
    echomsg 'Test: #' . i
    for funcname in funcs
      let start = reltime()
      call self[funcname]()
      let time = str2float(reltimestr(reltime(start)))
      let time_dict[funcname] += time
      echomsg printf('  %*s: %f', maxlen, funcname, time)
    endfor
  endfor
  echomsg 'Average:'
  for funcname in funcs
    echomsg printf('  %*s: %f', maxlen, funcname, time_dict[funcname] / n)
  endfor
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
