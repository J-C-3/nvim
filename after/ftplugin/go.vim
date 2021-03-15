" Go bindings and settings
setlocal noexpandtab

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

call extend(g:ale_linters, {
    \"go": ['golint', 'go vet'], })

" vim go (polyglot) settings.
let g:go_template_use_pkg = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_auto_sameids = 1
let g:go_def_mapping_enabled = 0
let g:go_list_type = "quickfix"
let g:go_fmt_autosave = 1
let g:go_imports_autosave = 1
if executable('goimports-ordered')
  let g:go_imports_commad ="goimports-ordered"
  let g:go_fmt_command = "goimports-ordered"
else
  let g:go_fmt_command = "goimports"
endif
let g:go_fmt_fail_silently = 0
let g:go_highlight_types = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1
let g:go_rename_command = "gopls"

command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

nmap <buffer> <leader>gdd <Plug>(go-def-vertical)
nmap <buffer> <leader>gdv <Plug>(go-doc-vertical)
nmap <buffer> leader>gdb <Plug>(go-doc-browser)
nmap <buffer> leader>r  <Plug>(go-run)
nmap <buffer> leader>t  <Plug>(go-test)
nmap <buffer> leader>gt <Plug>(go-coverage-toggle)
nmap <buffer> leader>i <Plug>(go-info)
nmap <buffer> silent> <leader>ml <Plug>(go-metalinter)
nmap <buffer> C-g> :GoDecls<cr>
nmap <buffer> leader>dr :GoDeclsDir<cr>
nmap <buffer> leader>rb :<C-u>call <SID>build_go_files()<CR>

" Set Tagbar to use gotags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
