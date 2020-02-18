"--------------------------------------------------------------------------------
"     File Name           :     plugins.vim
"     Created By          :     Eloi Silva
"     Creation Date       :     [2019-03-27 04:16]
"     Last Modified       :     [2020-02-18 16:56]
"     Description         :      
"--------------------------------------------------------------------------------


"-----------------------------------------------------------------
"------------------------
"   Install vim-Plug    "
"------------------------
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


"-----------------------------------------------------------------
"------------------------
"       Plug list       "
"------------------------
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'w0rp/ale', { 'do': 'pip3 install flake8 isort yapf' }

Plug 'maralla/completor.vim', { 'do': 'pip3 install jedi' }

Plug 'davidhalter/jedi-vim', { 'do': 'pip3 install jedi' }

Plug 'ctrlpvim/ctrlp.vim'

Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'janko-m/vim-test'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'sickill/vim-monokai' ### Used on MAC

" Plug 'edkolev/tmuxline.vim' ### Not used

" Colorschemes
"Plug 'fisadev/fisa-vim-colorscheme' ### Not used
Plug 'rafi/awesome-vim-colorschemes'

Plug 'tpope/vim-surround'
Plug 'shanzi/autoHEADER'

Plug 'easymotion/vim-easymotion'

Plug 'tmux-plugins/vim-tmux'

Plug 'raimondi/delimitmate'

Plug 'benmills/vimux'

" Markdown plugin
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()


"-----------------------------------------------------------------
"------------------------
"      ALE config       "
"------------------------
" ALE configure
let g:ale_fix_on_save = 0
let g:ale_fixers = {
\   'python': [
\       'isort',
\       'yapf',
\       'remove_trailing_lines',
\       'trim_whitespace'
\   ]
\}

"
"-----------------------------------------------------------------
"------------------------
"        ALEFix         "
"------------------------
nnoremap <Space>f :ALEFix<cr>


"-----------------------------------------------------------------
"------------------------
"      Jedi config      "
"------------------------
let g:jedi#completions_enabled = 1


"-----------------------------------------------------------------
"------------------------
"       vim-test        "
"------------------------
"let test#python#runner = 'unittest'
let test#python#runner = 'pytest'
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


"-----------------------------------------------------------------
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


"-----------------------------------------------------------------
"------------------------
"  easymotion config    "
"------------------------
map  <Space>w <Plug>(easymotion-bd-w)
nmap <Space>w <Plug>(easymotion-overwin-w)
map  <Space>s <Plug>(easymotion-s)
" nmap <Space>s <Plug>(easymotion-overwin-s)


"-----------------------------------------------------------------
"------------------------
"   autoHEADER config   "
"------------------------
" [Eloi Settings]
" Enable AutoHeader Plugin
let g:autoHEADER_auto_enable = 1
let g:autoHEADER_default_author = "Eloi Silva"


"-----------------------------------------------------------------
"---------------------------
" Enable miniBufExp Plugin "
"---------------------------
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1


"-----------------------------------------------------------------
"---------------------------
"     Configure Vimux      "
"---------------------------
nmap <leader>r :call VimuxRunCommand("clear; " . expand('%:p'))<CR><CR>

" Run the current file with realpath (full path)
"nnoremap <Space>r :call VimuxRunCommand("clear; " . expand('%:p'))<cr><cr>
" Run the current file as a command
"nnoremap <Space>r :call VimuxRunCommand("clear; rspec " . bufname("%"))<cr>
"nmap <leader>d :Dispatch expand('%:p')
