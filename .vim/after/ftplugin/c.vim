" Simple way to compile and run
"map <leader>t :w <CR> :!gcc % && ./a.out <CR>

" Use vimux to compile and run in a separated pane
nmap <space>r :w <CR> :call VimuxRunCommand("clear; gcc " . expand("%") . " -o " . expand("%:r") . " ; " . expand("%:r"))<CR>
