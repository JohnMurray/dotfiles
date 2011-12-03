" use vim defaults and set basic config
set nocompatible
syntax on
set number
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


"""""GENERAL EDITING SHORTCUTS
" move line up
map <C-Down> ddp
" move line down
map <C-UP> dd<Up>P
" duplicate line
map <C-d> yyP
" duplicate line
map! <C-d> <Esc>yyPa


"""""RUBY SPECIFIC FILE EDITING
" insert class
map! <C-S-o> class<Space><CR><Tab><CR><BS><BS>end<Up><Up><End>
" insert method
map! <C-S-d> def<Space><CR><Tab><CR><BS><BS>end<Up><Up><End>()<Left><Left>
" insert comment header
map! <C-c> ##----<ESC>yyp<Up><End>a<CR>##<Space><ESC>yyp<Up><End>a

" If we have autocommand support, open to last position in file
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\'") > 0 && line("'\'") <= line("$") |
  \  exe "normal! g'\"" |
  \ endif
endif


" register non-standard extensions
au BufNewFile,BufRead *.ru set filetype=ruby
