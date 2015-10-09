vim-venchmark
=============

Simple Vim script benchmarker


## Usage

#### Example 1

```vim
let s:vm = venchmark#new('String search')

let s:N = 100000
let s:str = 'Hello World!'

function! s:vm.stridx() abort
  for i in range(1, s:N)
    let _ = stridx(s:str, 'W')
  endfor
endfunction

function! s:vm.regex() abort
  for i in range(1, s:N)
    let _ = s:str =~# 'W'
  endfor
endfunction

call s:vm.run(5)
```

#### Example 2

```vim
echo venchmark#test#eval(100000, "'aAbB' ==# 'aAbB'")
echo venchmark#test#eval(100000, "'aAbB' == 'aAbB'")
```


#### Example 3

```vim
let s:N = 500000
let s:LIST = []

let s:stopwatch01 = venchmark#stopwatch#new('s:LIST == []')
call s:stopwatch01.start()
for s:i in range(1, s:N)
  let _ = s:LIST == []
endfor
call s:stopwatch01.stop()
call s:stopwatch01.show()

let s:stopwatch02 = venchmark#stopwatch#new('empty(s:LIST)')
call s:stopwatch02.start()
for s:i in range(1, s:N)
  let _ = empty(s:LIST)
endfor
call s:stopwatch02.stop()
call s:stopwatch02.show()
```


## Installation

With [NeoBundle](https://github.com/Shougo/neobundle.vim).

```vim
NeoBundle 'koturn/vim-venchmark'
```

If you want to use ```:NeoBundleLazy```, write following code in your .vimrc.

```vim
NeoBundleLazy 'koturn/vim-venchmark'
if neobundle#tap('vim-venchmark')
  call neobundle#config({
        \ 'autoload': {
        \   'function_prefix': 'venchmark'
        \ }
        \})
  call neobundle#untap()
endif
```

With [Vundle](https://github.com/VundleVim/Vundle.vim).

```vim
Plugin 'koturn/vim-venchmark'
```

With [vim-plug](https://github.com/junegunn/vim-plug).

```vim
Plug 'koturn/vim-venchmark'
```

If you don't want to use plugin manager, put files and directories on
```~/.vim/```, or ```%HOME%/vimfiles/``` on Windows.


## LICENSE

This software is released under the MIT License, see [LICENSE](LICENSE).
