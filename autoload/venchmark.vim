" ============================================================================
" FILE: venchmark.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" DESCRIPTION: {{{
" Simple Vim script benchmarker.
" }}}
" ============================================================================
let s:save_cpo = &cpo
set cpo&vim

let s:t_func = type(function('function'))
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
  let funcs = keys(filter(copy(self), 'type(v:val) == s:t_func && v:key !=# "run"'))
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
  call map(time_dict, 'v:val / n')
  let basetime = s:maxf(values(time_dict))
  for funcname in funcs
    echomsg printf('  %*s: %f (x%.3f)', maxlen, funcname, time_dict[funcname], basetime / time_dict[funcname])
  endfor
endfunction

function! s:maxf(listf) abort
  let maxval = -1.0e100
  for val in a:listf
    let maxval = maxval < val ? val : maxval
  endfor
  return maxval
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
