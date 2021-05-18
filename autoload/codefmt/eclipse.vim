" Copyright 2018 Google Inc. All rights reserved.
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"     http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.


let s:plugin = maktaba#plugin#Get('codefmt')


""
" @private
" Formatter: eclipse
function! codefmt#eclipse#GetFormatter() abort
  let l:formatter = {
        \ 'name': 'eclipse',
        \ 'setup_instructions': 'Install eclipse'
        \ }

  function l:formatter.IsAvailable() abort
    return 1
  endfunction

  function l:formatter.AppliesToBuffer() abort
    return &filetype == 'java'
  endfunction

  function l:formatter.FormatRange(startline, endline) abort
    let l:cmd = ['/home/aron/src/ss/clients/tizra/cubchicken/bin/eclipse-formatter', '--filter']
    let l:lines = getline(1, line('$'))
    let l:input = join(l:lines, "\n")
    let l:result = maktaba#syscall#Create(l:cmd).WithStdin(l:input).Call()
    let l:formatted = split(l:result.stdout, "\n")
    call maktaba#buffer#Overwrite(1, line('$'), l:formatted)
  endfunction

  return l:formatter
endfunction
