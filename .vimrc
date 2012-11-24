" use vim defaults and set basic config
set nocompatible
syntax on
set number
set cursorline
set ruler


" expand tab to spaces (2 in fact), and autoindent on <CR>
set expandtab
set tabstop=2
set autoindent
set smartindent
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
  hi CursorLine ctermbg=Black cterm=none
endif


" If we have autocommand support, open to last position in file
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\'") > 0 && line("'\'") <= line("$") |
  \  exe "normal! g'\"" |
  \ endif
endif


" highlight TODO markers
hi Todo ctermbg=Black ctermfg=DarkMagenta


" what vi user doesn't love the mousse!
set mouse=a
