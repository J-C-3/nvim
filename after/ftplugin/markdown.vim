" Markdown settings
let vim_markdown_preview_github=1
" Convert markdown to HTML
nmap <buffer> <leader>md :%!~/.local/bin/Markdown.pl --html4tags <cr>

source ~/.config/nvim/writing.vim
