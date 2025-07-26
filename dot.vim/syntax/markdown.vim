" kyr
" Highlight text inside [[some text]]
" I use it for markdown file to navigate to with 'gf'
" ex. [[notes.md]]
syntax match MyFilename /\[\[\zs\f\+\ze\]\]/
highlight link MyFilename Keyword
