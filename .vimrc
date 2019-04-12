syntax enable
" Limit syntax highlighting to 250 columns max to avoid slowdown.
set synmaxcol=250
set ruler
set laststatus=2
set ttyfast
" set t_Co=256
set termguicolors
set background=dark
colorscheme gruvbox
filetype indent plugin on

" default re=0 Causes slowdown in ruby. Might want to figure out a
" language-independent way in the future.
set re=1

" enable matchit.vim
runtime macros/matchit.vim

" Set viminfo to restore maximum of 15 buffers across sessions.
set viminfo+=%30

" statusline settings
set statusline=%f%m\ -\ %y " filename mode - filetype
set statusline+=%=       " switch to right aligned
" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=\ %p%%  " percentage in file
set statusline+=\ %l:%c " linenumber : columnnumber


" Always show at least one line above/below the cursor.
set scrolloff=1
set sidescrolloff=5

" show line numbers
set number 
" Somehow relative numbering would cause slow down in insert mode in Ruby
set relativenumber

" tabs are spaces
set expandtab

" highlight all search matches
set hlsearch

" highlight current line
set cursorline


" plug.vim config
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
" Plug 'https://github.com/Valloric/YouCompleteMe.git', {'do': './install.py'}
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/ConradIrwin/vim-bracketed-paste.git'
" Plug 'https://github.com/pangloss/vim-javascript.git' 
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/taglist.vim'
Plug 'tpope/vim-fugitive'

call plug#end()

" ctrlp settings
" skip files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["tex", "html"]}
" Python checkers
let g:syntastic_python_checkers = ["python", "flake8"]
let g:syntastic_python_flake8_args = "--ignore=E501i,W291,E121,E126,E127"
" Ruby checkers
" let g:syntastic_ruby_checkers = ["rubocop"]

" NERDTree show hidden files
let NERDTreeShowHidden=1
" Map key for toggling NERDTree panel to F2
noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :NERDTreeFind<CR>

" enable line numbers
let NERDTreeShowLineNumbers=1

" TagList toggle
nnoremap <silent> <F4> :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_WinWidth = 40

" Map jj in insert mode to ESC
inoremap jj <ESC>

" Use ag for greping
if executable('ag')
    set grepprg=ag\ --vimgrep\ $*
    set grepformat=%f:%l:%c:%m
endif

" Show completion menu
set wildmenu wildmode=longest,list,full

" Load Mac specific settings
if has('macunix')
    source ~/.vimrc_mac
endif
