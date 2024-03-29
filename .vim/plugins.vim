"---------------------------------------------------
"     File Name           :     plugins.vim        "
"     Created By          :     Eloi Silva         "
"     Creation Date       :     [2019-03-27 04:16] "
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


" fzf fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Fuzzy file, buffer, etc finder for Vim (map: ctrl-p)
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'kien/ctrlp.vim'

" Vim plugin to list, select and switch between buffers
"Plug 'jeetsukumaran/vim-buffergator'

" Auto add delimiters like ],},),',",etc.
Plug 'raimondi/delimitmate'

" Personal wiki for vim (branch 64c9f3d)
Plug 'vimwiki/vimwiki'
 

"=-=-= GIT plugins =-=-=
Plug 'tpope/vim-fugitive'


"=-=-= Code Languages =-=-=
" Language Server Protocol (LSP)
Plug 'w0rp/ale', { 'do': 'pip3 install --user flake8 isort yapf' }

" A collection of language packs
Plug 'sheerun/vim-polyglot'

" C++ language
Plug 'lyuts/vim-rtags'

" typescript/javascript
Plug 'leafgarland/typescript-vim'

" Python
Plug 'davidhalter/jedi-vim', { 'do': 'pip3 install --user jedi' }

" Allow run program tests inside vim
Plug 'janko-m/vim-test'

" Run test program in dispatch (integratino with vim-test plugin)
Plug 'tpope/vim-dispatch'

" Easily interact with tmux from vim (integration with vim-test plugin)
"Plug 'benmills/vimux'
Plug 'preservim/vimux'

" .tmux.conf integration like syntax highlighting, commentstring, etc.
Plug 'tmux-plugins/vim-tmux'

" Copy and send to tmux pane
Plug 'jpalardy/vim-slime'

" Markdown plugin
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Markdown table
Plug 'dhruvasagar/vim-table-mode'

" CSS color - show the css colors when coding
Plug 'ap/vim-css-color'


"=-=-= Autocomplete plugins =-=-=
" Code completion
Plug 'maralla/completor.vim', { 'do': 'pip3 install --user jedi' }


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


"-------------------
" Fzf fuzzy finder "
"-------------------
" Map Files to ctrl+p
nnoremap <C-p> :Files<Cr>

" Map Buffers to ctrl+p
nnoremap <leader>b :Buffers<Cr>

" Search wiki files
command! -bang WikiFiles call fzf#vim#files('~/Documents/wiki', <bang>0)
nnoremap <leader>sw :WikiFiles

" Search worklog files
command! -bang WorklogFiles call fzf#vim#files('~/Documents/worklog', <bang>0)
nnoremap <leader>sl :WorklogFiles

" ripgrep function
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


"------------------------
"        RipGrep        "
"------------------------
if executable('rg')
  let g:rg_derive_root='true'
endif

nnoremap <leader>rg :RG<SPACE>


"------------------------
"         ctrlp         "
"------------------------
"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"let g:ctrlp_use_caching = 0

" Easy bindings for its various modes
"nmap <leader>bb :CtrlPBuffer<cr>
"nmap <leader>bm :CtrlPMixed<cr>
"nmap <leader>bs :CtrlPMRU<cr>


"------------------------
"      Buffergator      "
"------------------------
" I want my own keymappings...
"let g:buffergator_suppress_keymaps = 1

" View the entire list of buffers open
"nmap <leader>bl :BuffergatorOpen<cr>


"------------------------
"        vimwiki        "
"------------------------
let g:vimwiki_list = [{'path': '~/Documents/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

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
let test#strategy = "vimux"
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


"------------------------
"       completor       "
"------------------------
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
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^[[:keyword:][:ident:]]'
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

" Complete Options (completeopt)
let g:completor_complete_options = 'menuone,noselect,preview'

" Completor Actions
" Jump to definition completor#do('definition')
noremap <silent> <leader>d :call completor#do('definition')<CR>
" Show documentation completor#do('doc')
noremap <silent> <leader>c :call completor#do('doc')<CR>
" Format code completor#do('format')
noremap <silent> <leader>F :call completor#do('format')<CR>
" Hover info (lsp hover) completor#do('hover')
noremap <silent> <leader>s :call completor#do('hover')<CR>


"---------------------------
"     Configure Vimux      "
"---------------------------
nmap <space>r :call VimuxRunCommand("clear; " . expand('%:p'))<CR><CR>
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>

" Run the current file with realpath (full path)
"nnoremap <Space>r :call VimuxRunCommand("clear; " . expand('%:p'))<cr><cr>
" Run the current file as a command
"nnoremap <Space>r :call VimuxRunCommand("clear; rspec " . bufname("%"))<cr>
"nmap <leader>d :Dispatch expand('%:p')


"-------------------
" VIM Slime Plugin "
"-------------------
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}


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
