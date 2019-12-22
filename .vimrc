" first thing is entering vim mode, not plain vi
set nocompatible

" set default encoding
set fileencodings=utf-8
set encoding=utf-8

" force 256 colors on the terminal
if !has('gui_running')
  set t_Co=256
endif

" Theme
color gruvbox
set background=dark
" for macVIm
set guifont=Monaco:h14

" Vim Airline plugin (the status bar)
let g:airline#extensions#keymap#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
" let g:airline_theme='powerlineish'
let g:airline_theme='molokai'

" Leave it here don't move !!
syntax on

" Highlight line
set nocursorline " don't use highlight
set cursorline
set nocursorcolumn

" Disable bell
set visualbell t_vb=

" Include headers*
set path=./,/usr/local/Cellar/avr-gcc/8.2.0/avr/include,/Applications/Arduino.app/Contents/Java/hardware/arduino/avr/cores/arduino

" Search down into subfolders
" source: https://www.youtube.com/watch?v=XA2WjJbmmoM&feature=youtu.be
" Provides tab-completion for all file-related tasks
" Use the :find command
set path+=**
" Display all matching files when we tab complete
set wildmenu
" FILE BROWSING:
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for mor mappings

" BUILD INTEGRATION
" Build jekyll current site
set makeprg=jekyll\ build
" Now type :make to build the site


" Restore folded code and splits
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup end
set viewoptions=folds,cursor
" Restore size of splits
set sessionoptions=folds,winsize,resize
" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright

" Enable code line numbers and more 
set number
set relativenumber

" Tabs and indetnt
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

autocmd FileType html setlocal ts=2 sts=2 sw=2

inoremap {<cr> {<cr>}<c-o><s-o> 
inoremap [<cr> [<cr>]<c-o><s-o> 
inoremap (<cr> (<cr>)<c-o><s-o>
inoremap /*<cr> /*<cr>*/<c-o><s-o>

" Set to auto read when a file is changed from the outside
set autoread

" Searching highliting and clear with 'ctrl+l'
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" It hides buffers instead of closing them. This means that you can have unwritten 
" changes to a file and open a new file using :e, without being forced to write 
" or undo your changes first. Also, undo buffers and marks are preserved while 
" the buffer is open.
set hidden

"enable filetype for command below
filetype on
" Setting to define default comments as // in c,cpp,h files for plugin
autocmd FileType c,cpp,h setlocal commentstring=//\ %s
" Change the default comment string to comment aout line for github pages
autocmd FileType md,markdown setlocal commentstring=[//]\:\ %s

"Ignore case when searching
set ignorecase
set smartcase

" vimwiki/vimwiki
let g:vimwiki_list = [
                       \{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'},
                       \{'path': '~/vimwiki/Travel', 'syntax': 'markdown', 'ext': '.md'},
                       \{'path': '~/src/git/jekyll/donkeytravel.github.io/_posts', 'syntax': 'markdown', 'ext': '.md'}]
                       " \{'path': '~/src/git/jekyll/donkeytravel.github.io/_pages', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" Un-vimwiki
nnoremap <Leader>' :e ~/src/git/jekyll/Jekyll-Paper/index.md<cr>

" Use markdown syntax highlighting instead vimwiki's
" autocmd FileType vimwiki set ft=markdown

filetype plugin indent on

" Using Vim with the Greek language & Spell Checker
" https://stackoverflow.com/questions/3776728/using-vim-with-the-greek-language
" Set spell checker
set spelllang=el-en
" Enable/Disable
set spell " enable spell checker
set nospell " disable spell checker 

" enable UTF-8 Greek keymap permanently
set keymap=greek_utf-8
" Do not enabled by default in Insert mode
set iminsert=0

" Set working directory to the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" use 'j' & 'k' for up and down in autocomplete list 
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" copy and paste and from system clipboard MAC
set clipboard=unnamed
"
" Copy to system clipboard shortcut (leader key "\" and "y") \y
" the "*yy also copy the current line or selected text
noremap <Leader>y "*yy
" Paste from system clipboard shortvut (leader key "\" and "p") \p
noremap <Leader>p "*p

" Set `.php` files as `html` but with color and indend like php
au BufEnter,BufNew *.php :set filetype=html syn=php

nnoremap <leader>pp :set ft=php<cr>
nnoremap <leader>hh :set ft=html syn=php<cr>

" display always the status line
set laststatus=2

" Visual wrapping
set linebreak

" Fugitive Fix for :Glog
nnoremap <leader>gl :silent! Glog<CR> :redraw!<CR> :copen<CR>

" for csv plugin in ~/.vim/ftplugin/csv.vim
au! BufNewFile,BufRead *.csv setf csv
let g:csv_delimiter = ";"

" Sort selected column in visual block
vnoremap <leader>s :sort /\ze\%V/<CR>

" Convert yanked text form memory in block and paste it
" Copy the text into a register x with "xy
" https://stackoverflow.com/questions/31893732/vim-how-do-i-paste-a-column-of-text-from-clipboard-after-a-different-column-o
nnoremap <leader>B :call setreg('x', @x, 'b')<CR>"xP
nnoremap <leader>b :call setreg('x', @x, 'b')<CR>"xp

" Custom templates
"https://stackoverflow.com/questions/54268047/how-to-auto-insert-a-template-code-into-a-new-file-of-particular-extension-that
function BashTemplate(tmpl_file)
    exe "0read " . a:tmpl_file
    let substDict = {}
    let substDict["date"] = strftime("%Y")
    exe '%s/<<\([^>]*\)>>/\=substDict[submatch(1)]/g'
    set nomodified
    normal G
endfunction

function AddTemplate(tmpl_file)
    exe "0read " . a:tmpl_file
    let substDict = {}
    let substDict["name"] = $USER
    let substDict["date"] = strftime("%Y %b %d %X")
    exe '%s/<<\([^>]*\)>>/\=substDict[submatch(1)]/g'
    set nomodified
    normal G
endfunction

function JekyllPost(tmpl_file)
    let fully_qualified_file = expand('%:p')
    if 0 != match(fully_qualified_file, $HOME . '/Public/github/MrKyr.github.io/.*')
        return
    endif
    exe "0read " . a:tmpl_file
    let substDict = {}
    let substDict["name"] = $USER
    let substDict["date"] = strftime("%Y-%m-%d %X %z")
    exe '%s/<<\([^>]*\)>>/\=substDict[submatch(1)]/g'
    set nomodified
    normal G
endfunction

function DonkeyTravel(tmpl_file)
    let fully_qualified_file = expand('%:p')
    if 0 != match(fully_qualified_file, $HOME . '/src/git/jekyll/donkeytravel.github.io/_posts/.*')
        return
    endif
    exe "0read " . a:tmpl_file
    let substDict = {}
    let substDict["name"] = $USER
    let substDict["date"] = strftime("%Y-%m-%d %X %z")
    exe '%s/<<\([^>]*\)>>/\=substDict[submatch(1)]/g'
    set nomodified
    normal G
endfunction

if has("autocmd")
  augroup templates
    " autocmd BufNewFile *.sh 0r ~/.vim/pack/kyr/start/kyr/templates/skeleton.sh
    autocmd BufNewFile *.sh call BashTemplate("~/.vim/pack/kyr/start/kyr/templates/skeleton.sh")
    autocmd BufNewFile *.markdown call JekyllPost("~/.vim/pack/kyr/start/kyr/templates/skeleton.markdown")
    autocmd BufNewFile *.md,*.markdown call DonkeyTravel("~/.vim/pack/kyr/start/kyr/templates/irene.markdown")
    " autocmd BufNewFile *.md,*.markdown call DonkeyTravelPage("~/.vim/pack/kyr/start/kyr/templates/irene-page.markdown")
    autocmd BufNewFile *.c,*.cpp,*.h call AddTemplate("~/.vim/pack/kyr/start/kyr/templates/skeleton.cpp")
  augroup END
endif

" Reload Safari page on save for Irene
" https://stackoverflow.com/questions/12733519/vim-make-chrome-refresh-anytime-i-write
function! ReloadBrowser()
    silent exe "!osascript -e 'tell app \"Safari\" to activate\<cr>
                \tell app \"System events\"\<cr> keystroke \"r\" using command down\<cr>
                \end tell'"
    silent exe "!osascript -e 'tell app \"Iterm\" to activate'"
endfunction
nnoremap <Leader>r :call ReloadBrowser()<CR>

" markdown to pdf
nnoremap <leader>rr :!pandoc % --metadata pagetitle="Corali Designs Co." -t html5  -V margin-top=10 -V margin-left=10 -V margin-right=10 -V margin-bottom=10 --css ~/src/css/github.css -o ~/Spool/%.pdf

" for vim-checkbox plugin
let g:checkbox_states = [' ', 'X']

" lEDGER ACCOUNTING
" First install the plugin: https://github.com/ledger/vim-ledger
" https://justyn.io/blog/automatically-sort-and-align-ledger-transactions-in-vim/
filetype plugin indent on
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
let g:ledger_maxwidth = 120
let g:ledger_fold_blanks = 1
let g:ledger_decimal_set = ','

function LedgerSort()
    :%! ledger -f - print --sort 'date, amount'
    :%LedgerAlign
endfunction
command LedgerSort call LedgerSort()
" Autocompletion
au FileType ledger imap <silent> : :<c-x><c-o>