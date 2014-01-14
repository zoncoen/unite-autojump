let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
\     'name': 'autojump',
\     'description': 'candidates from autojump database',
\     'default_action' : 'cd',
\ }

let s:autojump_command = 'autojump -s'

function! s:unite_source.gather_candidates(args, context)
    let l:directories = reverse(split(unite#util#system(s:autojump_command),"\n"))[7:]
    return map(directories,
    \         '{
    \             "word": split(v:val, "\t")[1],
    \             "source": "autojump",
    \             "kind": "cdable",
    \             "action__directory": split(v:val, "\t")[1],
    \         }')
endfunction

function! unite#sources#autojump#define()
    return exists('s:autojump_command') ? s:unite_source : []
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
