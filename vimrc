set modeline
set backspace=2
set backspace=indent,eol,start
set nocompatible
set ls=2

map <space> "+y
colorscheme darkblue


" show cursor line and column in the status line
set ruler

" show matching brackets
set showmatch

" display mode INSERT/REPLACE/...
set showmode

" changes special characters in search patterns (default)
" set magic

" Required to be able to use keypad keys and map missed escape sequences
set esckeys


" Changed default required by SuSE security team
set modelines=0

" get easier to use and more user friendly vim defaults
" /etc/vimrc ends here





set ts=4
" enable syntax highlighting
"syntax on
set number

set hlsearch

" automatically indent lines (default)
" set noautoindent

" select case-insenitiv search (not default)
set ignorecase

" set more search settings
set smartcase
set incsearch
" show cursor line and column in the status line
set ruler

" show matching brackets
set showmatch

" display mode INSERT/REPLACE/...
set showmode

set modeline
set ls=2

syntax on
autocmd BufNewFile,BufReadPost *.cpp,*.hpp,*.h,*.c set filetype=cpp
autocmd BufNewFile,BufReadPost *.vs set filetype=verilog

colorscheme darkblue
