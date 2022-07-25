" Indentation
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal autoindent

map <leader>t :w <CR> :!python3 -i % <CR>

nmap <space>r :call VimuxRunCommand("clear; " . expand('%:p'))<CR><CR>
