" load Pathogen (for plugin management)
execute pathogen#infect()
Helptags
set laststatus=2


" use vim defaults and set basic config
set nocompatible
syntax on
set number
set cursorline
set ruler
set backspace=indent,eol,start

" search settings
set ignorecase
set smartcase


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

" Set absolute-vs-relative numbering
:au FocusLost * :set number
:au FocusGained * :set relativenumber

:au InsertEnter * :set number
:au InsertLeave * :set relativenumber


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


" If we are running in GUI mode, set some colors
if has("gui_running")
  colorscheme solarized
  set background=dark
endif


" highlight TODO markers
hi Todo ctermbg=Black ctermfg=DarkMagenta


" Make tab smarter (use super tab).
"   If the line is empty (or just whitespace) then use a normal
"   tab, otherwise try to use auto-completion.
function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>


" Easy switch buffers
nmap <C-e> :e#<CR>
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>
nmap <C-c> :bp\|bd #<CR>


" Terminal Settings to make airline work better
set term=xterm-256color
set termencoding=utf-8
set encoding=utf-8
let g:airline_powerline_fonts = 1

" NERD-tree
map <F2> :NERDTreeToggle<CR>
" close vim if nerd-tree is only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" open nerd-tree is no files specified on vim-open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
