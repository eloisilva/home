" Indentation
setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal autoindent

" clipboard to *
setlocal clipboard=unnamed

" Run code
nmap <leader>t :w <CR> :!python3 -i % <CR>
nmap <space>r :call VimuxRunCommand("clear; " . expand('%:p'))<CR><CR>

" folding config
setlocal foldmethod=indent
setlocal foldnestmax=10
nnoremap <cr> za
vnoremap <cr> zf

" Ale lint
let b:ale_linters = ['flake8', 'pylint']
let b:ale_fixers = ['autopep8', 'yapf']
