" Rust settings
call plug#begin(expand('~/.config/nvim/plugged'))
call plug#end()

nmap <buffer> gd <Plug>(rust-def)
nmap <buffer> gs <Plug>(rust-def-split)
nmap <buffer> gx <Plug>(rust-def-vertical)
nmap <buffer> <leader>gd <Plug>(rust-doc)
