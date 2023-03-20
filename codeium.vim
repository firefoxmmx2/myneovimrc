" codeium settings
"
" codeium airline#SetStatus setting
function! GetCodeiumStatus()
  return '{…}' . codeium#GetStatusString()
endfunction
call airline#parts#define_function('codeium','GetCodeiumStatus')
call airline#parts#define_condition('codeium', "exists('*codeium#GetStatusString')")
let g:airline_section_x = airline#section#create_right(['codeium','filetype'])
" global enable codeium
let g:codeium_enabled = v:true

