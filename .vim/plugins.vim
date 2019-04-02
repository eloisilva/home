"--------------------------------------------------------------------------------
"     File Name           :     plugins.vim
"     Created By          :     Eloi Silva
"     Creation Date       :     [2019-03-27 04:16]
"     Last Modified       :     [2019-03-28 23:25]
"     Description         :      
"--------------------------------------------------------------------------------


" install vim-Plug
let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.vim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif


" Plug list
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'w0rp/ale', { 'do': 'pip3 install flake8 isort yapf' }

Plug 'maralla/completor.vim', { 'do': 'pip3 install jedi' }

Plug 'davidhalter/jedi-vim', { 'do': 'pip3 install jedi' }

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'edkolev/tmuxline.vim'

" Colorschemes
"Plug 'fisadev/fisa-vim-colorscheme'
Plug 'rafi/awesome-vim-colorschemes'

Plug 'tpope/vim-surround'
Plug 'shanzi/autoHEADER'

Plug 'easymotion/vim-easymotion'

Plug 'tmux-plugins/vim-tmux'

call plug#end()


let g:ale_fix_on_save = 0
let g:ale_fixers = {
\   'python': [
\       'isort',
\       'yapf',
\       'remove_trailing_lines',
\       'trim_whitespace'
\   ]
\}


let g:jedi#completions_enabled = 1
let test#python#runner = 'pytest'

" Air-Line
colorscheme molokai
let g:airline_theme='molokai'
"let g:airline_theme='simple'
"
"let g:airline_powerline_fonts = 1


"if !exists('g:airline_symbols')
    "let g:airline_symbols = {}
"endif

" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'


" Use TAB to complete when typing words, else inserts TABs as usual.  Uses
" dictionary, source files, and completor to find matching words to complete.

" Note: usual completion is on <C-n> but more trouble to press all the time.
" Never type the same word twice and maybe learn a new spellings!
" Use the Linux dictionary when spelling is in doubt.
function! Tab_Or_Complete() abort
  " If completor is already open the `tab` cycles through suggested completions.
  if pumvisible()
    return "\<C-N>"
  " If completor is not open and we are in the middle of typing a word then
  " `tab` opens completor menu.
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    " If we aren't typing a word and we press `tab` simply do the normal `tab`
    " action.
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

map  <Space>w <Plug>(easymotion-bd-w)
nmap <Space>w <Plug>(easymotion-overwin-w)
map  <Space>s <Plug>(easymotion-s)
" nmap <Space>s <Plug>(easymotion-overwin-s)
