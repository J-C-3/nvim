" Python settings
set filetype=python
setlocal colorcolumn=88
setlocal formatoptions+=croq 
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class,with

let g:python3_host_prog = expand("~/.pyenv/shims/python")
let g:black_fast = 1
let g:black_skip_string_normalization = 1

" ale for python
:call extend(g:ale_linters, {
    \'python': ['flake8'], })


autocmd BufWritePre *.py execute ':Black'
