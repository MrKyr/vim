" first thing is entering vim mode, not plain vi
set nocompatible

" How can I make the backspace key delete characters as usual?
" Disabled for linux
" set backspace=indent,eol,start

" set default encoding
set fileencodings=utf-8
set encoding=utf-8

" force 256 colors on the terminal
if !has('gui_running')
  set t_Co=256
endif

" vim randomly breaks syntax highlighting FIX
" autocmd BufEnter * syntax sync fromstart " DOES NOT WORK:
" Manual Refresh Syntax Color With: <Ctrl+l>
nnoremap <silent> <C-l> :syntax sync fromstart<CR>

" Display a visual line at 80th column
set colorcolumn=81

" Visual wrapping
set linebreak

" for macVIm
" set guifont=Monaco:h14

" Theme
color gruvbox
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_guisp_fallback = "bg" " Fixing highlight misspelling words for  gruvbox theme

" Showing spaces at end of line as dots
" Also tabs
set listchars=tab:>~,nbsp:_,trail:.
set list

" Vim Airline plugin (the status bar)
let g:airline#extensions#keymap#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_theme='molokai'

" Leave it here don't move !!
syntax on

" Highlight line
set cursorline
set nocursorcolumn

" Disable bell
set visualbell t_vb=

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
" set makeprg=jekyll\ build
" Now type :make to build the site

" Run the bash script and the output in new buid in vims terminal
autocmd filetype sh nnoremap <Leader>' :terminal sh % <CR>

" Restore folds
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
set tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,c,cpp setlocal ts=4 sts=4 sw=4

" set line wrap and visual line to fit the printer POS58
autocmd BufRead,BufNewFile print.pos setlocal textwidth=32 colorcolumn=32

" Custom commands to print to Natum POS58 bleutooth printer
command! -range=% PosRaw :<line1>,<line2> w ! lp -o raw
command! -range=% Pos :<line1>,<line2> w !lp

" Automatic pair {} [] () /**/ 
inoremap {<cr> {<cr>}<c-o><s-o>
" inoremap [<cr> [<cr>]<c-o><s-o>
inoremap [ []<ESC>i
inoremap (<cr> (<cr>)<c-o><s-o>
inoremap /*<cr> /*<cr>*/<c-o><s-o>

" Set to auto read when a file is changed from the outside
set autoread

" Searching highliting and clear with 'ctrl+l'
set incsearch     " show search matches as you type
" set hlsearch      " highlight search terms DISSABLED SLOW DOWN
" <Ctrl-l> redraws the screen and removes any search highlighting.
" nnoremap <silent> <C-l> :nohl<CR><C-l>

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
                       \{'path': '~/vimwiki/Work', 'syntax': 'markdown', 'ext': '.md'},
                       \{'path': '~/vimwiki/Travel', 'syntax': 'markdown', 'ext': '.md'},
                       \{'path': '~/vimwiki/Cooking', 'syntax': 'markdown', 'ext': '.md'},
                       \{'path': '~/vimwiki/Invoices', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

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

" copy and paste and from system clipboard
set clipboard=unnamed
" Copy to system clipboard shortcut (leader key "\" and "y") \y
" the "*yy also copy the current line or selected text
noremap <Leader>y "*yy
" Paste from system clipboard shortvut (leader key "\" and "p") \p
noremap <Leader>p "*p

" Set `.php` files as `html` but with color and indend like php
nnoremap <leader>pp :set ft=php<cr>
nnoremap <leader>hh :set ft=html syn=php<cr>

" display always the status line
set laststatus=2

" Fugitive Fix for :GcLog
nnoremap <leader>gl :silent! GcLog<CR> :redraw!<CR> :copen<CR>

" for csv plugin in ~/.vim/ftplugin/csv.vim
" au! BufNewFile,BufRead *.csv setf csv
" let g:csv_delimiter = ";"
au! BufNewFile,BufRead *.dat,*.csv setf csv
let g:csv_delimiter = ","

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
    " autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
    autocmd BufNewFile *.sh call BashTemplate("~/.vim/templates/skeleton.sh")
    autocmd BufNewFile *.markdown call JekyllPost("~/.vim/templates/skeleton.markdown")
    autocmd BufNewFile *.md,*.markdown call DonkeyTravel("~/.vim/templates/irene.markdown")
    " autocmd BufNewFile *.md,*.markdown call DonkeyTravelPage("~/.vim/templates/irene-page.markdown")
    autocmd BufNewFile *.c,*.cpp,*.h call AddTemplate("~/.vim/templates/skeleton.cpp")
    autocmd BufNewFile *.py call AddTemplate("~/.vim/templates/skeleton.py")
  augroup END
endif

" for vim-checkbox plugin
let g:checkbox_states = [' ', 'X']

" Python settings
au BufNewFile,BufRead *.py
\ set tabstop=4
\  | set softtabstop=4
\  | set shiftwidth=4
\  | set expandtab
\  | set autoindent
\  | set fileformat=unix

" XWAX
" ex. of creating playlists
" ~/libexec/xwax-scan ~/music/Old\ School\ Misc/ |sed 's/.*mp3\t//g' |nl -s' ' -n'ln' -w3 > Old\ School\ Misc.csv
"
function Xwax(deck)
    :execute ":!xwax-client localhost load " . a:deck . " \"$(find ~/music -name \"*$(sed -n " . line('.') . "p \"%\" | cut -f1,2 |sed 's/\t/\*/g')*.mp3\")\""
endfunction

function XwaxC(deck)
    :let conn = system("xwax-client localhost get_status " . a:deck . " |grep timecode_control |awk '{printf $2}'")
    if conn == '1'
        :execute ":!xwax-client localhost disconnect " . a:deck
    else
        :execute ":!xwax-client localhost reconnect " . a:deck
    endif
endfunction

nnoremap <Leader>1 :call Xwax(0)<CR><CR>
nnoremap <Leader>2 :execute ":!xwax-client localhost recue 0"<CR><CR>
nnoremap <Leader>3 :call XwaxC(0)<CR><CR>
nnoremap <Leader>5 :call Xwax(1)<CR><CR>
nnoremap <Leader>6 :execute ":!xwax-client localhost recue 1"<CR><CR>
nnoremap <Leader>7 :call XwaxC(1)<CR><CR>

" VIM Disable Automatic Newline At End Of File
set nofixendofline

" markdownpreview.neovim plugin
" FIX:
" [vim-node-rpc] pre build and node not found!
" run :call mkdp#util#install()
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'firefox'

" Bypass deprecation message for Snipmate
let g:snipMate = { 'snippet_version' : 1 }

" Open url under cursor by pressing ENTER
function! OpenURLUnderCursor()
    let s:uri = expand('<cWORD>')
    let s:uri = substitute(s:uri, '?', '\\?', '')
    let s:uri = shellescape(s:uri, 1)
    if s:uri != ''
        silent exec "!firefox -new-tab '".s:uri."'"
        :redraw!
    endif
endfunction
nnoremap <Leader><enter> :call OpenURLUnderCursor()<CR>

" LARAVEL (requires vim-blade plugin)
" blade files syntax highlighting
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['datetime', 'javascript']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
      \   'markdown': 'endmarkdown',
      \   'cache': 'endcache',
      \ }

" Insert current date
nnoremap <leader>d :r !date '+\%Y-\%m-\%d \%a  \%H:\%M'<cr>

" Create PDF
nnoremap <leader>rr :!pandoc % --pdf-engine=wkhtmltopdf --metadata pagetitle="Corali Designs Co." -t  html5  -V margin-top=10 -V margin-left=10 -V margin-right=10 -V margin-bottom=10 --css ~/src/css/github.css -o ~/Spools/'%:t'.pdf

" Create HTML with auto TOC
nnoremap <leader>rh :!pandoc -s --toc % --pdf-engine=wkhtmltopdf --metadata pagetitle="Corali Designs Co." -t  html5  -V margin-top=10 -V margin-left=10 -V margin-right=10 -V margin-bottom=10 --css ~/src/css/github.css -o ~/Spools/'%:t'.html

command Tim2pdf execute "!pandoc % --pdf-engine=wkhtmltopdf --metadata pagetitle='Corali Designs Co.' -t html5 --css ~/src/css/invoice.css -o ~/Spools/'%:t'.pdf"
