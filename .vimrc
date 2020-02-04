" [Default Settings]

" Set the current millenium
set nocompatible

" set encode
set encoding=utf8

" Backspace map
set backspace=indent,eol,start

" Enable number and relative number
set nu
set relativenumber

" Syntax and Background configuration
syntax on

" Status line config
" set statusline=%!MyStatusLine()

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

" Search using // in Visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Insert shortcut map
imap {<Tab> {}<Esc>i
imap {<CR> {<Esc>o}<Esc>O
imap "<Tab> ""<Esc>i
imap "<CR> "<Esc>o"<Esc>O
imap (<Tab> ()<Esc>i
imap (<CR> (<Esc>o)<Esc>O

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


"-----------------------------------------------------------------
" Templates

" Bash vim template
autocmd FileType sh source ~/.vim/sh.vim

" Python vim template
" autocmd FileType python source ~/.vim/python.vim

" HTML vim template
autocmd FileType html source ~/.vim/html.vim


"-----------------------------------------------------------------
" Auto Run

" Auto save and Exec Python Script
" autocmd FileType python map <F9> :w<Esc>:!clear && python %<CR>

" Python Auto-Complete command
"autocmd FileType python set omnifunc=pythoncomplete#Complete


" Auto save and Exec Shell Script
" autocmd BufRead,BufNewFile *.sh nmap <F9> :w<Esc>:!clear && bash %<CR>


"-----------------------------------------------------------------
" Reload vimrc
nnoremap <leader>r :source<Space>$MYVIMRC<cr>


"-----------------------------------------------------------------
" Paste/Numeric/RelNumeric toggle
function! PasteMode()
  if &number
    set nonumber
    set showbreak=
  else
    set number
    set showbreak=...
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


"-----------------------------------------------------------------
" colorscheme and airline-theme
source ~/.vim/color.vim

" Enable Plug
source ~/.vim/plugins.vim

"-----------------------------------------------------------------
" Old Config [Disabled]
"
"set textwidth=79
"set mouse=a
"
"map T :TaskList<CR>
"map P :TlistToggle<CR>


"-----------------------------------------------------------------
" Functions

function! MyStatusLine()
    let statusline = ""
    " Filename (F -> full, f -> relative)
    let statusline .= "%f"
    " Buffer flags
    let statusline .= "%( %h%1*%m%*%r%w%) "
    " File format and type
    let statusline .= "(%{&ff}%(\/%Y%))"
    " Left/right separator
    let statusline .= "%="
    " Line & column
    let statusline .= "(%l,%c%V) "
    " Character under cursor (decimal)
    let statusline .= "%03.3b "
    " Character under cursor (hexadecimal)
    let statusline .= "0x%02.2B "
    " File progress
    let statusline .= "| %P/%L"
    return statusline
endfunction

function! PyMain()
    normal Go
    let currline = line(".")
    call append(currline, "def main():")
    call append(currline+1, "    pass")
    call append(currline+2, "")
    call append(currline+3, "if __name__ == '__main__':")
    call append(currline+4, "    main()")
endfunction
