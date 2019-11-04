call plug#begin()
" syntax for like a million langs
Plug 'sheerun/vim-polyglot'
" highlight occurrences of word under cursor
Plug 'dominikduda/vim_current_word'
" ui
Plug 'itchyny/lightline.vim'
" quickly comment out/in lines
Plug 'tpope/vim-commentary'
" adds support for targeting surrounding marks<Paste>
Plug 'tpope/vim-surround'
" more motions
Plug 'easymotion/vim-easymotion'
" completion engine
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
" prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
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
" Color previews
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
" floating preview window for completion (wait for new release)
Plug 'ncm2/float-preview'
call plug#end()

set mouse=a
" keeps the selection after indenting
vnoremap < <gv
vnoremap > >gv

" maybe??
" set termguicolors
" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" easymotion
" changes the prefix from \\ to \
map <Leader> <Plug>(easymotion-prefix)
" characters the word motion to be bi-directional
map <Leader>w <Plug>(easymotion-bd-w)
map <Leader>f <Plug>(easymotion-bd-f)
map <Leader>t <Plug>(easymotion-bd-t)
map s         <Plug>(easymotion-s2)


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

" mappings
map <Leader>c <Plug>(coc-fix-current)
map <Leader>n <Plug>(coc-diagnostic-next)
map <Leader>N <Plug>(coc-diagnostic-prev)

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

" Better display for messages (this only kinda works)
set cmdheight=1

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

" NERDTree
" show dots
let NERDTreeShowHidden=1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
