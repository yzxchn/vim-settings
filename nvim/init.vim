syntax enable
set ruler
" Always show status line.
set laststatus=2
" set t_Co=256
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

" Gutentag running indicator
set statusline+=\ %{gutentags#statusline()}
set statusline+=\ %p%%  " percentage in file
set statusline+=\ %l:%c " linenumber : columnnumber


" Always show at least one line above/below the cursor.
set scrolloff=1
set sidescrolloff=5

" show hybrid line numbers
set number 
set relativenumber

" highlight all search matches
set hlsearch

" highlight current line
set cursorline


" plug.vim config
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/ervandew/supertab.git'
Plug 'https://github.com/ConradIrwin/vim-bracketed-paste.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
" Plug 'vim-scripts/taglist.vim'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

" fzf settings
" mappings
" file finder
nnoremap <Leader>f :GFiles<CR>
" Uncomment to enable preview window
" command! -bang -nargs=? -complete=dir GFiles
"   \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview({'options': ['--preview', 'bat {} || less {}']}), <bang>0)
nnoremap <Leader>F :Files<CR>
" Uncomment to enable preview window
" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--preview', 'bat {} || less {}']}), <bang>0)
" buffer finder
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" tag finder
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>
" Ag finder
nnoremap <Leader>a :Ag<Space>

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

" Map jk in insert mode to ESC
inoremap jk <ESC>

" Make movements between splits easier
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

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
