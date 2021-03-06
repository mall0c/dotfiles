" ------------------ General
set t_Co=256
set background=dark
set laststatus=2

colorscheme deep-space

highlight SignColumn ctermbg=black
highlight CursorLineNr ctermbg=black cterm=bold

" Solid background color for YCM indicators
highlight YcmWarningSign cterm=bold ctermbg=black ctermfg=red
highlight YcmErrorSign cterm=bold ctermbg=black ctermfg=red
highlight YcmErrorSection cterm=underline ctermfg=darkred

" Search highlight color
highlight EasyMotionMoveHL ctermbg=240 ctermfg=black

" ------------------ Cursorline
set cursorline
highlight CursorLine ctermbg=Black cterm=NONE

" No underline in folds
highlight Folded cterm=bold

" Syntastic Errors
highlight SpellBad term=underline ctermfg=160 gui=undercurl guisp=Orange 

" highlight LineNr ctermfg=8
" highlight Comment ctermfg=8

highlight Normal ctermbg=none
highlight PreProc ctermfg=2

" highlight Folded ctermbg=0 ctermfg=none
" highlight Visual ctermbg=8 ctermfg=8
