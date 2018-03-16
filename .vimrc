syntax enable
"set t_Co=16
set ruler
set laststatus=2
"set t_Co=256
set background=dark
colorscheme solarized
filetype indent plugin on

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

call plug#end()

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["tex", "html"]}

" YCM auto remove preview
autocmd CompleteDone * pclose

" NERDTree show hidden files
let NERDTreeShowHidden=1
" Map key for toggling NERDTree panel to F2
nmap <F2> :NERDTreeToggle<CR>

" enable line numbers
let NERDTreeShowLineNumbers=1

" Load Mac specific settings
if has('macunix')
    source ~/.vimrc_mac
endif
