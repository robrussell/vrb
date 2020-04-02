set nocompatible

" TODO - ycm

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-speeddating'
Plugin 'junegunn/fzf'
Plugin 'mhinz/vim-signify'
" Snippets and a bundle of them.
" Requires Vim compiled with Python 3 support which is not available on Mac yet.
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
" Allows accessing and swapping function arguments.
Plugin 'PeterRincker/vim-argumentative'
" Accesses targets like things in () that are to the right of the cursor. See
" https://github.com/wellle/targets.vim.
Plugin 'wellle/targets.vim'
" Plugin 'sudar/vim-arduino-syntax'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" L9 must be installed for FuzzyFinder
Plugin 'vim-scripts/FuzzyFinder'
" Better session management. vim-session depends on vim-misc.
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
"Plugin 'vim-scripts/Conque-GDB'
" Easier tab renaming. TabooRename <tabname>.
Plugin 'gcmt/taboo.vim'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
" All of your Plugins must be added before the following line
call vundle#end()            " required

" Default mapping conflicts with YCM.
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

filetype plugin indent on
syntax on
" Make Y yank to eol, like D and C do.
nnoremap Y y$
" Remap the escape key to the sequence jk
imap jk <Esc>

" Preferred dark colourscheme
colorscheme elflord
" Set up for the solarized colour scheme, which can be dark or light.
"colorscheme solarized
"let g:solarized_termcolors=256
syntax enable
"set background=dark
" Toggles solarized between light & dark.
" call togglebg#map("<F11>")

" Turn on line numbers
set number

" Return to the same line when reopening a file.
augroup return_to_same_line
  au!
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
augroup END

" Use K to split lines like J joins them
nnoremap K a<CR><Esc>
" Delete the comment character when joining lines.
set formatoptions+=j

" Search case-insensitive unless the input has mixed case.
set smartcase

" Automatically re-read changed files and reload.
set autoread
" Trigger on every cursor move.
autocmd CursorMoved * checktime | silent! update

" Highlight lines that are too long based on the textwidth variable.
function! HighlightTooLongLines()
  highlight def link RightMargin Error
  if &textwidth != 0
    call matchadd('ErrorMsg', '\%>' . &l:textwidth . 'v.\+', -1)
  endif
endfunction

" This is getting annoying, disabled for now, rjr 2017-12-07
" augroup highlight_too_long
"  au!
"  au FileType,BufEnter * call HighlightTooLongLines()
"augroup END

augroup autoformat_settings
  au!
  autocmd FileType borg,gcl,patchpanel AutoFormatBuffer gclfmt
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  "autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType java AutoFormatBuffer google-java-format
  "autocmd FileType jslayout AutoFormatBuffer jslfmt
  autocmd FileType markdown AutoFormatBuffer mdformat
  "autocmd FileType ncl AutoFormatBuffer nclfmt
  "autocmd FileType python AutoFormatBuffer pyformat
  "autocmd FileType textpb AutoFormatBuffer text-proto-format
augroup END

" Navigate through the quickfix list
nnoremap <C-N> :cn<CR>
nnoremap <C-P> :cp<CR>

" FuzzyFinder options.
map <Leader>f :FufFile<CR>
map <Leader>b :FufBuffer<CR>

" Workaround for bug in LogiPat that exposes a :ELP command to conflict with
" :Explore, per
" http://stackoverflow.com/questions/31695455/vim-how-do-i-disable-the-default-logipat-plugin
let g:loaded_logipat = 1

" Configure Vim to receive mouse events from X.
"set mouse=a

" Screen reports the terminal as screen. Set it to xterm so ctrl-left and right
" work again.
set term=xterm-256color
"
" Work around PgUp/PgDn key problem with screen when we always have an
" xterm-compatible terminal per
" https://bugs.launchpad.net/ubuntu/+source/screen/+bug/82708.
set t_kN=^[[6;*~
set t_kP=^[[5;*~
" Arrows are somehow different though. The following doesn't work but the
" mapping does. Per
" http://unix.stackexchange.com/questions/1709/how-to-fix-ctrl-arrows-in-vim
":set t_kr=^[[1;*~
":set t_kl=^[[1;*~
" It seems like having a mapping that starts with <ESC> could be causing a delay
" every time I hit escape.
"map <ESC>[1;5D <C-Left>
"map <ESC>[1;5C <C-Right>
"map! <ESC>[1;5D <C-Left>
"map! <ESC>[1;5C <C-Right>

" Configure argumentative https://github.com/PeterRincker/vim-argumentative
nmap [; <Plug>Argumentative_Prev
nmap ]; <Plug>Argumentative_Next
xmap [; <Plug>Argumentative_XPrev
xmap ]; <Plug>Argumentative_XNext
nmap <; <Plug>Argumentative_MoveLeft
nmap >; <Plug>Argumentative_MoveRight
xmap i; <Plug>Argumentative_InnerTextObject
xmap a; <Plug>Argumentative_OuterTextObject
omap i; <Plug>Argumentative_OpPendingInnerTextObject
omap a; <Plug>Argumentative_OpPendingOuterTextObject

" Session options and config for xolox/vim-session.
" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers

" Always save sessions on exit without prompting.
let g:session_autosave = 'yes'
" Save the session every 5 minutes.
let g:session_autosave_periodic = 5
" Just save without telling me.
let g:session_autosave_silent = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

" Configure ConqueGDB
" This plugin has a few conflicting shortcuts so give it a different leader key.
let g:ConqueGdb_Leader = ','

" Configure FZF per http://g/engtricks/00hD2TPiSp8
" todo
"nnoremap <silent> <Leader><Enter> :call fzf#run({
"      \   'source': printf('find %s -type f', substitute(system("print_interesting_code_paths.py"), '\n', ' ', 'g')),
"      \   'sink': 'e'
"      \ })<CR>

" Configure Taboo to save tab names in session.
set sessionoptions+=tabpages,globals
augroup buffer_rename
  autocmd!
  autocmd FileType bzl,make execute "TabooRename %P/" . expand('%')
augroup END

" F2 or \p to toggle paste option.
nnoremap <leader>p :set paste!<CR>
nnoremap F2 :set paste!<CR>

" F5 for spellcheck toggle
:map <F5> :setlocal spell! spelllang=en_us<CR>

" ctrl-s for save. Terminals may freeze if they receive the ctrl-s. ctrl-q
" starts them again.
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>
:nmap <c-`> <Esc>
:imap <c-`> <Esc>

