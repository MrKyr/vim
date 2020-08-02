syntax match csvHeading /\%1l\%(\%("\zs\%([^"]\|""\)*\ze"\)\|\%(\zs[^,"]*\ze\)\)/
highlight def link csvHeading Type

" kyr
syntax match csvComment "\*\*\*.*$"
hi def link csvComment Comment
let b:current_syntax = 'csv'
