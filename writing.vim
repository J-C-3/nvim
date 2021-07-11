" vim for writing and writing alone
" Thesaurus settings
" TODO: Function to check if it exists -> create directory if not -> obtain file
" let g:tq_openoffice_en_file="/usr/share/myspell/dicts/th_en_US_new"

let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 74
let g:pencil#joinspaces = 0
let g:pencil#cursorwrap = 1
let g:pencil#conceallevel = 3
let g:pencil#concealcursor = 'c'
let g:pencil#softDetectSample = 20
let g:pencil#softDetectThreshold = 130

setlocal spell spl=en_us fdl=4 noru nonu nornu
setlocal fdo+=search

augroup Writing
  autocmd VimEnter,BufEnter * call pencil#init()
  autocmd VimEnter,BufEnter * call litecorrect#init()
  autocmd VimEnter,BufEnter * call textobj#sentence#init()
  autocmd VimEnter,BufEnter * call lexical#init()
augroup END

map <silent> <leader>wp :WritingPrompt<CR>
