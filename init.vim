syntax enable
set ruler
" Always show status line.
set laststatus=2
" set t_Co=256
set termguicolors
set background=dark
colorscheme gruvbox
filetype indent plugin on

set spelllang=en,cjk
set spell

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
" set statusline+=\ %{gutentags#statusline()}
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
Plug 'neovim/nvim-lspconfig'
" Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/ConradIrwin/vim-bracketed-paste.git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-vinegar.git'
Plug 'hrsh7th/nvim-compe'

call plug#end()

" LSP configs
lua << EOF
-- require'lspconfig'.pyright.setup{}
local nvim_lsp = require('lspconfig')
nvim_lsp.pyright.setup{}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "solargraph", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" nvim-compe
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
"let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

inoremap <silent><expr> <TAB>     compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <Tab>     pumvisible() ? "<C-n>" : "<Tab>"
inoremap <silent><expr> <S-Tab>   pumvisible() ? "<C-p>" : "<S-Tab>"
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

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


" fzf settings
" " Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--layout=reverse'

" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  " 90% of the height
  let height = float2nr(&lines * 0.8)
  " 60% of the height
  let width = float2nr(&columns * 0.6)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (one line down of the top)
  let vertical = 3

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': "minimal"
        \ }

  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction


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
