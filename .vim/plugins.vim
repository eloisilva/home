"---------------------------------------------------
"     File Name           :     plugins.vim        "
"     Created By          :     Eloi Silva         "
"     Creation Date       :     [2019-03-27 04:16] "
"     Last Modified       :     [2020-05-02 17:30] "
"     Description         :                        "
"--------------------------------------------------"

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


"------------------------
"------------------------
"       Plug list       "
"------------------------
call plug#begin('~/.vim/plugged')

"=-=-= Core plugins =-=-=
" Make easy to add/change/remove surround (maps: ysiw -- dsiw -- csiw)
Plug 'tpope/vim-surround'

" Make repeat extensible
Plug 'tpope/vim-repeat'
 
" Enable easy motions (maps: <space>w -- <space>s)
Plug 'easymotion/vim-easymotion'

" Undotree plugin (map: <leader>u)
Plug 'mbbill/undotree'

" Automatic add headers to new files
Plug 'shanzi/autoHEADER'

" Grep - (map: <leader>rg)
Plug 'jremmen/vim-ripgrep'

" Fuzzy file, buffer, etc finder for Vim (map: ctrl-p)
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'kien/ctrlp.vim'

" Auto add delimiters like ],},),',",etc.
Plug 'raimondi/delimitmate'

" Personal wiki for vim
Plug 'vimwiki/vimwiki'
 

"=-=-= GIT plugins =-=-=
Plug 'tpope/vim-fugitive'


"=-=-= Code Languages =-=-=
" Language Server Protocol (LSP)
Plug 'w0rp/ale', { 'do': 'pip3 install flake8 isort yapf' }

" A collection of language packs
Plug 'sheerun/vim-polyglot'

" C++ language
Plug 'lyuts/vim-rtags'

" typescript/javascript
Plug 'leafgarland/typescript-vim'

" Python
Plug 'davidhalter/jedi-vim', { 'do': 'pip3 install jedi' }

" Allow run program tests inside vim
Plug 'janko-m/vim-test'

" Run test program in dispatch (integratino with vim-test plugin)
Plug 'tpope/vim-dispatch'

" Easily interact with tmux from vim (integration with vim-test plugin)
Plug 'benmills/vimux'

" .tmux.conf integration like syntax highlighting, commentstring, etc.
Plug 'tmux-plugins/vim-tmux'

" Markdown plugin
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'


"=-=-= Autocomplete plugins =-=-=
" Code completion
Plug 'maralla/completor.vim', { 'do': 'pip3 install jedi' }


"=-=-= Colorschemes plugins =-=-=
" Vim airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colorschemes gruvbox
Plug 'morhetz/gruvbox'

" Colorschemes molokai
"Plug 'rafi/awesome-vim-colorschemes'

"=-=-= Disabled plugins =-=-=
" File manager (disabled)
"Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'sickill/vim-monokai' ### Used on MAC
"Plug 'edkolev/tmuxline.vim' ### Not used
"Plug 'fisadev/fisa-vim-colorscheme' ### Not used

call plug#end()


"------------------------
"  easymotion config    "
"------------------------
map  <Space>w <Plug>(easymotion-bd-w)
nmap <Space>w <Plug>(easymotion-overwin-w)
map  <Space>s <Plug>(easymotion-s)
" nmap <Space>s <Plug>(easymotion-overwin-s)


"------------------------
"       undotree        "
"------------------------
nnoremap <leader>u :UndotreeShow<CR>


"------------------------
"   autoHEADER config   "
"------------------------
" [Eloi Settings]
" Enable AutoHeader Plugin
let g:autoHEADER_auto_enable = 1
let g:autoHEADER_default_author = "Eloi Silva"


"------------------------
"        RipGrep        "
"------------------------
if executable('rg')
  let g:rg_derive_root='true'
endif

nnoremap <leader>rg :Rg<SPACE>


"------------------------
"         ctrlp         "
"------------------------
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>


"------------------------
"        vimwiki        "
"------------------------
let g:vimwiki_list = [{'path': '~/Documents/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" Default maps
"<Leader>ww -- Open default wiki index file.
"<Leader>wt -- Open default wiki index file in a new tab.
"<Leader>ws -- Select and open wiki index file.
"<Leader>wd -- Delete wiki file you are in.
"<Leader>wr -- Rename wiki file you are in.
"<Enter> -- Follow/Create wiki link
"<Shift-Enter> -- Split and follow/create wiki link
"<Ctrl-Enter> -- Vertical split and follow/create wiki link
"<Backspace> -- Go back to parent(previous) wiki link
"<Tab> -- Find next wiki link
"<Shift-Tab> -- Find previous wiki link


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

nnoremap <Space>f :ALEFix<cr>


"------------------------
"      Jedi config      "
"------------------------
let g:jedi#completions_enabled = 1
" When you start typing `from module.name<space>` jedi-vim automatically
" adds the "import" statement and displays the autocomplete popup.
let g:jedi#smart_auto_mappings = 1


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


"------------------------
"       completor       "
"------------------------
" Use Tab to select completion
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

" Jump to definition completor#do('definition')
noremap <silent> <leader>d :call completor#do('definition')<CR>
" Show documentation completor#do('doc')
noremap <silent> <leader>c :call completor#do('doc')<CR>
" Format code completor#do('format')
noremap <silent> <leader>f :call completor#do('format')<CR>
" Hover info (lsp hover) completor#do('hover')
noremap <silent> <leader>s :call completor#do('hover')<CR>


"---------------------------
"     Configure Vimux      "
"---------------------------
nmap <space>r :call VimuxRunCommand("clear; " . expand('%:p'))<CR><CR>

" Run the current file with realpath (full path)
"nnoremap <Space>r :call VimuxRunCommand("clear; " . expand('%:p'))<cr><cr>
" Run the current file as a command
"nnoremap <Space>r :call VimuxRunCommand("clear; rspec " . bufname("%"))<cr>
"nmap <leader>d :Dispatch expand('%:p')


"---------------------------
"      Airline theme       "
"---------------------------
let g:airline_theme='molokai'

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'



"-----------------------
"     colorscheme      "
"-----------------------
"colorscheme molokai
colorscheme gruvbox


"---------------------------
" Enable miniBufExp Plugin "
"---------------------------
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1
