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

" Set column line at chr 80
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgray

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

" Move between splits using ctrl-l, ctrl-h, ctrl-j and ctrl-k
nmap <c-l> <c-w>l
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k

" Centrilize line scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Reload current file
nnoremap <leader>e :e<cr>

" Reload vimrc
nnoremap <leader>r :source<Space>$MYVIMRC<cr>
"nnoremap <leader>v :e<Space>$MYVIMRC<cr>

" Search using // in Visual mode
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Configure spell checking
nmap <silent> <leader>p :set spell!<CR>
set spelllang=en_us

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

"set list listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
"set listchars=trail:.,tab:>-,extends:>,precedes:<,nbsp:¬
set list listchars=tab:»\ ,trail:·

" Line break (wrap)
set wrap
set linebreak
set wrapmargin=0
set showbreak=...

" Completion (Menu)
set path+=**
set wildmenu
set showmatch
set completeopt=longest,menuone

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
"au FocusGained,BufEnter * :silent! !

" Debian Style
runtime! debian.vim

" Enable indentation
if has("autocmd")
  filetype plugin indent on
endif


"------------------------
"------------------------
"       [Buffers]       "
"------------------------
" Open a buffer in a vertical split on the left side
cabbrev vbr vert sb

" Open a buffer in a vertical split on the right side
cabbrev vb vert belowright sb

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Show all open buffers and their status (replaced by plugin Buffergator)
nmap <leader>b :ls<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Open new empty buffer
nmap <leader>bn :enew<cr>


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

" moved templates to ~/.vim/after/ftplugin/


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

  :AirlineToggle
endfunction

noremap <Space>n :call PasteMode()<CR>

" Log view mode
function! LogView()
  if &cursorline
    set nocursorline
  else
    set cursorline
    hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
  endif
endfunction

noremap <Space>l :call LogView()<CR>

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


"-------------------------
"-------------------------
"         NetRW          "
"-------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_winsize = 80
nmap <leader>f :Explore<CR>

"-----------------------------------------
"-----------------------------------------
" vim -b : edit binary using xxd-format! "
"-----------------------------------------
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END


"function! OpenToRight()
"  :normal v
"  let g:path=expand('%:p')
"  :q!
"  execute 'belowright vnew' g:path
"  :normal <C-w>l
"endfunction
"
"function! OpenBelow()
"  :normal v
"  let g:path=expand('%:p')
"  :q!
"  execute 'belowright new' g:path
"  :normal <C-w>l
"endfunction
"
"" Allow for netrw to be toggled
"function! ToggleNetrw()
"  if g:NetrwIsOpen
"    let i = bufnr("$")
"    while (i >= 1)
"      if (getbufvar(i, "&filetype") == "netrw")
"        silent exe "bwipeout " . i
"      endif
"      let i-=1
"    endwhile
"    let g:NetrwIsOpen=0
"  else
"    let g:NetrwIsOpen=1
"    silent Lexplore
"  endif
"endfunction
"
"function! NetrwMappings()
"  " Hack fix to make ctrl-l work properly
"  "noremap <buffer> <C-l> <C-w>l
"  noremap <buffer> V :call OpenToRight()<cr>
"  noremap <buffer> H :call OpenBelow()<cr>
"endfunction
"
"" Close Netrw if it's the only buffer open
"autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif
"
"augroup netrw_mappings
"  autocmd!
"  autocmd filetype netrw call NetrwMappings()
"augroup END
"
"noremap <leader>f :call ToggleNetrw()<cr>


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

" Status line config
" set statusline=%!MyStatusLine()


"-------------------------
"-------------------------
"        Try later       "
"-------------------------

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
"set updatetime=300

" Don't pass messages to |ins-completion-menu|.
"set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"set signcolumn=yes
