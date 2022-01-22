" ============================================================================
" FILE: stopwatch.vim
" AUTHOR: koturn <jeak.koutan.apple@gmail.com>
" DESCRIPTION: {{{
" Simple stopwatch.
" }}}
" ============================================================================
let s:save_cpo = &cpo
set cpo&vim


let s:stopwatch_nr = 0

function! venchmark#stopwatch#new(...) abort " {{{
  let stopwatch = copy(s:StopWatch)
  if a:0 == 0
    let stopwatch.name = 'stopwatch_' . s:stopwatch_nr
    let s:stopwatch_nr += 1
  else
    let stopwatch.name = a:1
  endif
  let stopwatch.start_time = reltime()
  return stopwatch
endfunction " }}}


let s:StopWatch = {
      \ 'elapsed_time': 0.0,
      \ 'is_stopped': 0
      \}

function! s:StopWatch.start() abort " {{{
  let self.is_stopped = 0
  let self.start_time = reltime()
endfunction " }}}

function! s:StopWatch.stop() abort " {{{
  if !self.is_stopped
    let self.elapsed_time += str2float(reltimestr(reltime(self.start_time)))
    let self.is_stopped = 1
  endif
endfunction " }}}

function! s:StopWatch.reset() abort " {{{
  let self.elapsed_time = 0.0
endfunction " }}}

function! s:StopWatch.show(...) abort " {{{
  echomsg printf('[%s]: %f', self.name, (self.is_stopped ? 0.0 : str2float(reltimestr(reltime(self.start_time)))) + self.elapsed_time)
endfunction " }}}

function! s:StopWatch.get_elapsed_time() abort " {{{
  return (self.is_stopped ? 0.0 : str2float(reltimestr(reltime(self.start_time)))) + self.elapsed_time
endfunction " }}}


let &cpo = s:save_cpo
unlet s:save_cpo
