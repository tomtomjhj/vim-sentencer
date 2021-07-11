if exists('g:loaded_sentencer')
  finish
endif
let g:loaded_sentencer = 1

function! s:setopt(opt, val) abort
  let g:[a:opt] = get(g:, a:opt, a:val)
endfunction

call s:setopt('sentencer_punctuation', '.!?')
call s:setopt('sentencer_ignore',
  \ ['\<i.e', '\<e.g', '\<vs', '\<Dr', '\<Mr', '\<Mrs', '\<Ms'])
call s:setopt('sentencer_textwidth', 0)
call s:setopt('sentencer_overflow', 0.1)
call s:setopt('sentencer_filetypes', ['markdown', 'tex', 'text'])

augroup sentencer
  autocmd! *
  for s:ft in g:sentencer_filetypes
    execute printf('autocmd FileType %s setlocal formatexpr=sentencer#Format()', s:ft)
  endfor
augroup END

command! -range Sentencer call sentencer#Format(<line1>, <line2>)
command! -nargs=* SentencerBind call sentencer#bind(<f-args>)
