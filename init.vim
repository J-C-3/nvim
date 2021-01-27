" Let F1 fuck off
map <F1> <nop>
" Bootstrap Plug
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

" Install vim-plug if it is not installed
if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Ensure undodir exists and has been created
let undodir=expand('~/.cache/nvim/undodir')
if !isdirectory(undodir)
  echo "Making undodir"
  echo ""
  silent exec "!\mkdir -p " . undodir
endif

" Defaults
filetype plugin on
syntax on
set autoread
set autowrite
set clipboard^=unnamed,unnamedplus
set cmdheight=3
set expandtab
set hidden
set incsearch
set inccommand=nosplit
set mouse=a
set mousemodel=popup_setpos
set nobackup
set noerrorbells
set nohlsearch
set noshowmatch
set noswapfile
set nowrap
set nu rnu
set pumblend=30
set ruler
set scrolloff=8
set shiftwidth=4
set shortmess=aFc
set smartcase
set smartindent
set tabstop=4 softtabstop=4
set termguicolors
set undodir=~/.cache/nvim/undodir
set undofile
set updatetime=50
set winblend=30

" Set default filetype to text
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

" Adjust commentary for kickscripts
autocmd FileType kscript setlocal commentstring=#\ %s

" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

" File types that utilize the writing.vim
let writingFileTypes = ['text', 'markdown', 'html', 'mail', 'note']

call plug#begin(expand('~/.config/nvim/plugged'))

" Autocompletion/syntax tools
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Automatic closing of quotes, parens, etc.
Plug 'Raimondi/delimitMate'
Plug 'w0rp/ale'
" Shows trailing dots/lines to align indents
Plug 'Yggdroot/indentLine'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Function/class/object browser
Plug 'majutsushi/tagbar'

" Commenting toolkit
Plug 'tpope/vim-commentary'

" Git integration stuff
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
Plug 'airblade/vim-gitgutter'

" Man page integration
Plug 'vim-utils/vim-man'

" Visualize undo history
Plug 'mbbill/undotree'

" Language pack
Plug 'sheerun/vim-polyglot'

" Theming
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'Rigellute/rigel'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

" File browsing and icons
Plug 'ms-jpq/chadtree'
Plug 'ryanoasis/vim-devicons'

" AnsiEsc character coloring support
Plug 'powerman/vim-plugin-AnsiEsc'

" cURL in nvim!
Plug 'diepm/vim-rest-console'

"" Writing tools
Plug 'reedes/vim-pencil', { 'for': writingFileTypes, 'on': '<Plug>pencil#init()'}
""" Fancy abbreviation replacements
Plug 'tpope/vim-abolish', { 'for': writingFileTypes}
""" Highlights active paragraph
Plug 'junegunn/limelight.vim', { 'for': writingFileTypes}
""" Full screen writing mode
Plug 'junegunn/goyo.vim', { 'for': writingFileTypes}
""" Better spellcheck mappings
Plug 'reedes/vim-lexical', { 'for': writingFileTypes}
""" Better autocorrect
Plug 'reedes/vim-litecorrect', { 'for': writingFileTypes}
""" Thesaurus
Plug 'ron89/thesaurus_query.vim', { 'for': writingFileTypes}
""" Treat sentences as text objects plus dependency
Plug 'kana/vim-textobj-user', { 'for': writingFileTypes}
Plug 'reedes/vim-textobj-sentence', { 'for': writingFileTypes}
""" Weasel words and passive voice
Plug 'reedes/vim-wordy', { 'for': writingFileTypes}

"" Python
""" Black for formatting
Plug 'psf/black', { 'tag': '19.10b0', 'for': 'python' }
""" Requirements.txt syntax
Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }

"" Markdown TODO: Choose between plugins
Plug 'JamshedVesuna/vim-markdown-preview', { 'for': 'markdown' }
Plug 'tobanw/vim-preview', { 'for': 'markdown' }

"" Rust
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

"" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }

"" Racket
Plug 'wlangstroth/vim-racket', { 'for': 'racket' }

" Fuzzy find
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"" theming
let g:colorscheme = 'gruvbox'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_material_transparent_background = 1
let g:airline_theme = 'gruvbox'
" set background=dark
" colorscheme rigel
" let g:rigel_airline = 1

" highlighting settings
let g:currentHighlight = 'Normal ctermbg=none guibg=none'
" highlight Normal guibg=0
" highlight NormalFloat guifg=Gray guibg=DarkGray
" highlight Pmenu guifg=Gray guibg=DarkGray
" highlight Float guifg=Gray guibg=DarkGray

" Set appearance
function! SetBG()
  execute 'colorscheme ' . g:colorscheme
  execute 'highlight ' . g:currentHighlight
  redrawstatus
endfunction
call SetBG()

" RIPgrep
if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1
let mapleader = " "

" netrw
let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

" Source nvim config file
nnoremap <leader><CR> :source ~/.config/nvim/init.vim<CR>

" Navigation
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Show undotree
nnoremap <leader>u :UndotreeToggle<CR>
""nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>

" RipGrep
nnoremap <leader>ps :Rg<SPACE>

" RipGrep fuzzy find files
nnoremap <leader>pf :Files<CR>
nnoremap <leader>pv :wincmd v <bar> :Files <CR>
nnoremap <leader>ph :wincmd s <bar> :Files <CR>
nmap <leader>y :History:<CR>

"git related
nnoremap <leader>gfi :GFiles<CR>
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gsh :Gpush<CR>
nnoremap <leader>gll :Gpull<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gr :Gremove<CR>
nnoremap <leader>o :.Gbrowse<CR> ""Open current line fuGITive
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

"commentary
noremap <leader>cm :Commentary<CR>

" Buffer navigation
nnoremap <Leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
" nnoremap <leader>bd :bdelete<CR>
nnoremap <silent> <Tab> :bnext <CR>
nnoremap <silent> <S-Tab> :bprev <CR>
nnoremap <silent> <leader>b :Buffers<CR>

nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

vnoremap X "_d
inoremap <C-c> <esc>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <C-space> coc#refresh()

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

"" Use modeline overrides
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>
tnoremap <silent> <C-p> <C-\><C-n>


" fzf settings
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"

" set ripgrep for fzf
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" snippets
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger="<C-Tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" ale initialization
let g:ale_linters = {}

" Tagbar
nmap <silent> <leader>tb :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Copy paste cut
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Coc
let g:coc_global_extensions = [
  \'coc-css',
  \'coc-docker',
  \'coc-html',
  \'coc-json',
  \'coc-markdownlint',
  \'coc-marketplace',
  \'coc-markmap',
  \'coc-python',
  \'coc-sh',
  \'coc-spell-checker',
  \'coc-ultisnips',
  \'coc-vimlsp',
  \'coc-yaml',
  \'coc-zi',
  \]

"" More consistent check for pyenv
let pyenvdir = expand("~/.pyenv")
if isdirectory(pyenvdir)
    let g:python3_host_prog = pyenvdir . "/shims/python"
let g:coc_user_config = {
    \'python.pythonPath': g:python3_host_prog,
    \'python.venvFolders': [pyenvdir],
    \'python.autoComplete.extraPaths':['$PYENV_VIRTUAL_ENV'],
  \}
endif

nnoremap <silent> <leader>sd :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    silent call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent! call CocAction('highlight')
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev-error)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next-error)
nnoremap <leader>cr :CocRestart <CR>


augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
" Default highlight is better than polyglot
let g:python_highlight_all = 1

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline#extensions#branch#prefix     = '➥' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = ''
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

