"=============================================================================
" FILE: autoload/unite/sources/autojump.vim
" AUTHOR: zoncoen <zoncoen@gmail.com>
" Last Modified: 2014-01-14
" Requirement: autojump
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

let s:save_cpo = &cpo
set cpo&vim

" Define custom unite action. "{{{
let s:autojump_add_command = 'autojump -a %s'

let s:action = {
\     'description': 'change current working directory with adding path to autojump database',
\     'is_selectable': 0,
\ }

function! s:action.func(candidate) "{{{
    if a:candidate.action__directory != ''
        execute g:unite_kind_cdable_cd_command a:candidate.action__directory
        echo a:candidate.action__directory
        call unite#util#system(printf('autojump -a %s', a:candidate.action__directory))
    endif
endfunction "}}}

call unite#custom#action('cdable', 'cd_autojump', s:action)
"}}}

" Define unite source. "{{{
let s:autojump_command = 'autojump -s'

let s:unite_source = {
\     'name': 'autojump',
\     'description': 'candidates from autojump database',
\     'default_action' : 'cd_autojump',
\ }

function! s:unite_source.gather_candidates(args, context) "{{{
    let l:directories = reverse(split(unite#util#system(s:autojump_command),"\n"))[7:]
    return map(directories,
    \         '{
    \             "word": split(v:val, "\t")[1],
    \             "source": "autojump",
    \             "kind": "cdable",
    \             "action__directory": split(v:val, "\t")[1],
    \         }')
endfunction "}}}

function! unite#sources#autojump#define()
    return exists('s:autojump_command') ? s:unite_source : []
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker
