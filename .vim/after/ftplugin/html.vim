" Indentation
setlocal expandtab
setlocal autoindent

" mapping config
imap ><Tab> ><Esc>F<lyt>f>a</<C-r>"><Esc>F>a
imap ><CR> ><Esc>F<lyt>o</<C-r>"><Esc>O

" folding config
set foldmethod=indent
nnoremap <cr> za
vnoremap <cr> zf
