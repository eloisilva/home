" Indentation
setlocal expandtab
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal autoindent

" clipboard to *
setlocal clipboard=unnamed

" folding config
setlocal foldmethod=syntax
setlocal foldnestmax=10
nnoremap <cr> za
vnoremap <cr> zf

" Simple way to compile and run
map <leader>t :w <CR> :!gcc % && ./a.out <CR>

" Use vimux to compile and run in a separated pane
"nmap <space>r :w <CR> :call VimuxRunCommand("clear; gcc " . expand("%") . " -o " . expand("%:r") . " ; " . expand("%:r"))<CR>
nmap <space>r :w <CR> :call VimuxRunCommand("gcc " . expand("%") . " -o " . expand("%:r") . " ; " . expand("%:r"))<CR>
