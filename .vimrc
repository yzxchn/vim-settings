syntax enable
"set t_Co=16
set ruler
set laststatus=2
set t_Co=256
set termguicolors
set background=dark
colorscheme gruvbox
filetype indent plugin on

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

" enable hybrid hybrid numbering
set number relativenumber

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
Plug 'https://github.com/Valloric/YouCompleteMe.git', {'do': './install.py'}
Plug 'https://github.com/ConradIrwin/vim-bracketed-paste.git'
" Plug 'https://github.com/pangloss/vim-javascript.git' 
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'morhetz/gruvbox'

call plug#end()

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["tex", "html"]}
let g:syntastic_python_checkers = ["python", "flake8"]
let g:syntastic_python_flake8_args = "--ignore=E501i,W291,E121,E126,E127"
" YCM auto remove preview
autocmd CompleteDone * pclose

" NERDTree show hidden files
let NERDTreeShowHidden=1
" Map key for toggling NERDTree panel to F2
noremap <F2> :NERDTreeToggle<CR>

" enable line numbers
let NERDTreeShowLineNumbers=1

" Map jj in insert mode to ESC
inoremap jj <ESC>

" Show completion menu
set wildmenu wildmode=longest,list,full

" Load Mac specific settings
if has('macunix')
    source ~/.vimrc_mac
endif
