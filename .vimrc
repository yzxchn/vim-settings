syntax enable
set t_Co=16
set background=dark
colorscheme solarized
filetype indent plugin on

" enable line number
set number

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
Plug 'https://github.com/Valloric/YouCompleteMe.git'

call plug#end()

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["tex"]}

" YCM auto remove preview
autocmd CompleteDone * pclose

" NERDTree show hidden files
let NERDTreeShowHidden=1
" Map key for toggling NERDTree panel to F2
nmap <F2> :NERDTreeToggle<CR>

" Load Mac specific settings
if has('macunix')
    source ~/.vimrc_mac
endif
