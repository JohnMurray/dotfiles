" -----------------------------------------------------------------------------
"   Plugin Setup / Plugins
" -----------------------------------------------------------------------------

" bootstrap plug if needed
if empty(glob("~/.vim/autoload/plug.vim"))
  " Ensure all needed directories are created
  execute '!mkdir -p ~/.vim/plugged'
  execute '!mkdir -p ~/.vim/autoload'
  " Download the actual plugin manager
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'

" Syntax
Plug 'elzr/vim-json',           { 'for': 'json'     }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'StanAngeloff/php.vim',    { 'for': 'php'      }
Plug 'vim-ruby/vim-ruby',       { 'for': 'ruby'     }
Plug 'rust-lang/rust.vim',      { 'for': 'rust'     }
Plug 'derekwyatt/vim-scala',    { 'for': 'scala'    }
Plug 'fatih/vim-go',            { 'for': 'go'       }

" fancy statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" search / navigation tools
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'

Plug 'vim-scripts/winmanager'
Plug 'majutsushi/tagbar', { 'for': ['c', 'cpp', 'rust', 'h', 'cc', 'cxx'] }

call plug#end()

" -----------------------------------------------------------------------------
"   Editor Style Configurations
" -----------------------------------------------------------------------------

" use vim defaults
set nocompatible

" color scheme selection
let base16colorspace=256
colorscheme base16-eighties

" turn on basic elements
syntax on
set number
set cursorline
set ruler
set backspace=indent,eol,start

" highlight current line
if v:version > 700
  set cursorline
  hi CursorLine ctermbg=Black cterm=none
endif

" Set absolute-vs-relative numbering
:au FocusLost * :set number
:au FocusGained * :set relativenumber
:au InsertEnter * :set number
:au InsertLeave * :set relativenumber


" -----------------------------------------------------------------------------
"   Text Editing Configurations
" -----------------------------------------------------------------------------

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

" allow incremental search
set incsearch
set hlsearch
" set clear-search command
command C let @/=""


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
nmap <C-o> :bprev<CR>
nmap <C-c> :bp\|bd #<CR>


" -----------------------------------------------------------------------------
"   Plugin-Specific Configurations
" -----------------------------------------------------------------------------

" Airline
set term=xterm-256color
set termencoding=utf-8
set encoding=utf-8
let g:airline_powerline_fonts = 1
set laststatus=2

" NERD-tree
map <F2> :NERDTreeToggle<CR>
" close vim if nerd-tree is only window open
function! s:CloseIfOnlyControlWinLeft()
  if winnr("$") != 1
    return
  endif
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        \ || &buftype == 'quickfix'
    q
  endif
endfunction
augroup CloseIfOnlyControlWinLeft
  au!
  au BufEnter * call s:CloseIfOnlyControlWinLeft()
augroup END
" open nerd-tree is no files specified on vim-open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" TagBar
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_width=30
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.rs call tagbar#autoopen()
" TagBar - Rust support
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
    \}



" -----------------------------------------------------------------------------
"   Language Specific Settings
" -----------------------------------------------------------------------------

" PHP
autocmd FileType php setlocal noexpandtab
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END


" C
"" cscope
autocmd FileType c setlocal noexpandtab
if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  " map search commands
  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

  " multi-search commands
  nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


  " add any cscope database in current directory
  if filereadable("cscope.out")
    silent cs add cscope.out
  " else add the database pointed to by environment variable
  elseif $CSCOPE_DB != ""
    silent cs add $CSCOPE_DB
  endif

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

