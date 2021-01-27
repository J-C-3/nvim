" vim for writing and writing alone
" Thesaurus settings
" TODO: Function to check if it exists -> create directory if not -> obtain file
" let g:tq_openoffice_en_file="/usr/share/myspell/dicts/th_en_US_new"

if !exists('g:writing_vim_loaded')
  let g:writing_vim_loaded = 1
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

  " let g:limelight_conceal_ctermfg = 'gray'
  let g:limelight_conceal_guifg = 'gray'

  function! FocusEnter()
      Goyo
      Limelight
      augroup Focus
        let s:currentScrolloff = trim(execute('set scrolloff'))
        let s:currentSignColumn = trim(execute('setglobal signcolumn'))
        autocmd CursorMovedI * if (winline() * 3 >= (winheight(0) * 2))
        \ | norm! zz
        \ | endif
        execute('set scrolloff=' . (winheight(0) / 2))
        execute('ALEDisable')
        execute('sign unplace *')
        set signcolumn=no
        set noshowmode 
        set noshowcmd
        set cmdheight=1
        set laststatus=0
      augroup END
  endfunction

  function! FocusLeave()
    if exists('#Focus')
      if executable('tmux') && strlen($TMUX)
        silent !tmux set status on
        silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
      endif
      autocmd! Focus
      execute('set ' . s:currentSignColumn)
      execute('set ' . s:currentScrolloff)
      execute('ALEEnable')
      Limelight!
      Goyo!
      call SetBG()
    endif
  endfunction

  nnoremap <buffer> <silent> <leader>fe :call FocusEnter()<CR>
  nnoremap <buffer> <silent> <leader>fl :call FocusLeave()<CR>

endif
