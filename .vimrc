"---------------------------
"    [Default Settings]    "
"---------------------------

" Set the current millenium
set nocompatible

" set encode
set encoding=utf8

" Backspace map
set backspace=indent,eol,start

" Remove bells
set noerrorbells

" Disable swapfiles and backups
set noswapfile
set nobackup
set nowritebackup

" Enable undodir
if !isdirectory($HOME."/.vim/undodir")
  call mkdir($HOME."/.vim/undodir", "", 0700)
endif
set undodir=~/.vim/undodir
set undofile

" Enable number and relative number
set nu
set relativenumber

" Syntax and Background configuration
syntax on

" Set search behave
set ignorecase 
set smartcase
set hlsearch
set incsearch
" smartindent - is enabled on MacOS
" set smartindent

" Set background
set background=dark

" Indentation Global
set tabstop=2
set shiftwidth=2
set expandtab

" Map leader key
let mapleader = ','

" Map <ESC> to jk
inoremap jk <ESC>
vnoremap jk <ESC>

" Map Visual mode (.) to normal mode repeat
vnoremap . :norm.<CR>

" Map <leader>, to save file
nmap <leader>w :w<CR>
nmap <leader>W :wq<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>

" Reload current file
nnoremap <leader>e :e<cr>

" Reload vimrc
nnoremap <leader>r :source<Space>$MYVIMRC<cr>

" Search using // in Visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Insert shortcut map
imap {<Tab> {}<Esc>i
imap {<CR> {<Esc>o}<Esc>O
imap "<Tab> ""<Esc>i
imap "<CR> "<Esc>o"<Esc>O
imap (<Tab> ()<Esc>i
imap (<CR> (<Esc>o)<Esc>O

" In Visual mode move lines up (J) and down (K)
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" History
set history=500
set hidden

" set Windows display
set laststatus=2
set ruler
set showcmd

" show list bar
"set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
"set listchars=trail:.,tab:>-,extends:>,precedes:<,nbsp:¬

" Line break (wrap)
set wrap
set linebreak
set wrapmargin=0
set showbreak=...

" Completion (Menu)
set path+=**
set wildmenu
set showmatch

" Open a buffer in a vertical split on the left side
cabbrev vbr vert sb

" Open a buffer in a vertical split on the right side
cabbrev vb vert belowright sb

" Return to the same file line as before
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Load System Global File
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Detect when a file was changed
"set autoread

" Debian Style
runtime! debian.vim

" Enable indentation
if has("autocmd")
  filetype plugin indent on
endif


"-------------------------
"-------------------------
"      Load section      "
"-------------------------
" Enable Plug
source ~/.vim/plugins.vim

" colorscheme and airline-theme (Moved to plugins.vim file)
"source ~/.vim/color.vim


"-------------------------
"-------------------------
"       Templates        "
"-------------------------

" Bash vim template
autocmd FileType sh source ~/.vim/sh.vim

" Python vim template
" autocmd FileType python source ~/.vim/python.vim

" HTML vim template
autocmd FileType html source ~/.vim/html.vim


" Python Auto-Complete command
"autocmd FileType python set omnifunc=pythoncomplete#Complete


"-------------------------
"-------------------------
"       Functions        "
"-------------------------

" Enable/Disable Paste mode (number/ALE/linebreak)
function! PasteMode()
  if &number
    set nonumber
    set showbreak=
    :ALEDisable
  else
    set number
    set showbreak=...
    :ALEEnable
  endif

  if &relativenumber
    set norelativenumber
  else
    set relativenumber
  endif

  if &paste
    set nopaste
  else
    set paste
  endif
endfunction

noremap <Space>n :call PasteMode()<CR>


" Create python main to run when not imported
function! PyMain()
    normal Go
    let currline = line(".")
    call append(currline, "def main():")
    call append(currline+1, "    pass")
    call append(currline+2, "")
    call append(currline+3, "if __name__ == '__main__':")
    call append(currline+4, "    main()")
endfunction


" Create a custom StatusLine (Disabled)
"function! MyStatusLine()
    "let statusline = ""
    " Filename (F -> full, f -> relative)
    "let statusline .= "%f"
    " Buffer flags
    "let statusline .= "%( %h%1*%m%*%r%w%) "
    " File format and type
    "let statusline .= "(%{&ff}%(\/%Y%))"
    " Left/right separator
    "let statusline .= "%="
    " Line & column
    "let statusline .= "(%l,%c%V) "
    " Character under cursor (decimal)
    "let statusline .= "%03.3b "
    " Character under cursor (hexadecimal)
    "let statusline .= "0x%02.2B "
    " File progress
    "let statusline .= "| %P/%L"
    "return statusline
"endfunction

function! PyMain()
    normal Go
    let currline = line(".")
    call append(currline, "def main():")
    call append(currline+1, "    pass")
    call append(currline+2, "")
    call append(currline+3, "if __name__ == '__main__':")
    call append(currline+4, "    main()")
endfunction
