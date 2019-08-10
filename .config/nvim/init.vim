call plug#begin()
" syntax for like a million langs
Plug 'sheerun/vim-polyglot'
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
" easy text alignment with tabs
Plug 'godlygeek/tabular'
" tool for batch renaming files
Plug 'qpkorr/vim-renamer'
" LaTeX
Plug 'lervag/vimtex'
" floating preview window for completion (wait for new release
" Plug 'ncm2/float-preview'
call plug#end()

""" Coc
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" lightline integration
function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

""" vimtex
let g:polyglot_disabled = ['latex'] 
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

""" wal
colo wal

""" lightline
" gets rid of the double INSERT
set noshowmode

" real config
let g:lightline = {
      \ 'colorscheme': 'wal',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" searches across cases only if the search is all lowercase
set smartcase

" a lot of plugins use this
set updatetime=300

" Better display for messages
set cmdheight=2

" limit the completion popup height
set pumheight=6

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

" langmaps for Colemak
" Map Colemak keys to QWERTY keys in normal/visual modes.
command Colemak set langmap=fpgjluyrstdneiokFPGJLUYRSTDNEIOK;ertyuiosdfgjklpnERTYUIOSDFGJKLPN
" Map QWERTY keys to QWERTY keys in normal/visual modes.
command Qwerty set langmap=""

Colemak
