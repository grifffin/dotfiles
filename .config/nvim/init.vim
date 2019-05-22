call plug#begin()
" binds basic completion to tab
" Plug 'ajh17/vimcompletesme'
" syntax for like a million langs
Plug 'sheerun/vim-polyglot'
" js
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" async linting
" Plug 'w0rp/ale'
" ui
Plug 'itchyny/lightline.vim'

" quickly comment out/in lines
Plug 'tpope/vim-commentary'
" adds support for targeting surrounding marks<Paste>
Plug 'tpope/vim-surround'
" completion engine
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" wal colorscheme
Plug 'dylanaraps/wal.vim'
" minimal editing view
Plug 'junegunn/goyo.vim'
" HTML/XML tag auto-close
Plug 'alvan/vim-closetag'
" file tree
Plug 'scrooloose/nerdtree'
" show git status in nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'godlygeek/tabular'
" tool for batch renaming files
Plug 'qpkorr/vim-renamer'
" LaTeX
Plug 'lervag/vimtex'
call plug#end()

""" vimtex
let g:polyglot_disabled = ['latex'] 
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'


""" wal
colo wal


""" lightline
let g:lightline = {
      \ 'colorscheme': 'wal',
      \ }


""" vimcompletesme
" set omnifunc=syntaxcomplete#Complete
" closes the scratch window when a completion is selected
" autocmd CompleteDone * pclose

" searches across cases only if the search is all lowercase
set smartcase

" press <tab>, get two spaces
set expandtab shiftwidth=2 smarttab

" exit insert mode in the terminal with esc
tnoremap <Esc> <C-\><C-n>

" clear highlighting with escape
nnoremap <esc> :noh<return><esc>

" turn hybrid line numbers on
:set number relativenumber
:set nu rnu

" is this cool?
:nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
