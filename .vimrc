" use vim defaults and set basic config
set nocompatible
syntax on
set number
set paste
set cursorline
set ruler


" expand tab to spaces (2 in fact), and autoindent on <CR>
set expandtab
set tabstop=2
set autoindent
if has("autocmd")
  filetype indent on
  set sw=2
  set ts=2
endif


" allow incremental search
set incsearch
set hlsearch
" set clear-search command
command C let @/=""


" general editor settings
if v:version > 700
  set cursorline
  hi CursorLine ctermbg=DarkGrey cterm=none
endif


" If we have autocommand support, open to last position in file
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\'") > 0 && line("'\'") <= line("$") |
  \  exe "normal! g'\"" |
  \ endif
endif


" register non-standard extensions
au BufNewFile,BufRead *.ru set filetype=ruby

hi Todo ctermbg=Black ctermfg=DarkMagenta
