" vim" vimtex {{{
let g:polyglot_disabled = ['latex']
" }}}
" plugin installs {{{
call plug#begin()
" manager of LSPs, formatters, linters, etc.
Plug 'williamboman/mason.nvim' 
Plug 'williamboman/mason-lspconfig.nvim'
" LSP configs
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" debugger
Plug 'puremourning/vimspector'
" tree-sitter; parsing
Plug 'nvim-treesitter/nvim-treesitter'
" rust tools
Plug 'simrat39/rust-tools.nvim'
" syntax for jsx
Plug 'MaxMEllon/vim-jsx-pretty'
" highlight occurrences of word under cursor
Plug 'dominikduda/vim_current_word'
" ui
Plug 'itchyny/lightline.vim'
" dev icons
Plug 'kyazdani42/nvim-web-devicons'
" warnings in a box
Plug 'folke/trouble.nvim'
" git gutter
Plug 'airblade/vim-gitgutter'
" quickly comment out/in lines
Plug 'tpope/vim-commentary'
" adds support for targeting surrounding marks
Plug 'tpope/vim-surround'
" Git integration with :Git/:G
Plug 'tpope/vim-fugitive'
" more motions
Plug 'easymotion/vim-easymotion'
" better word-based motions
Plug 'bkad/CamelCaseMotion'
" gruvbox theme
Plug 'ellisonleao/gruvbox.nvim'
" minimal editing view
Plug 'junegunn/goyo.vim'
" HTML/XML tag auto-close
Plug 'alvan/vim-closetag'
" file tree
Plug 'nvim-tree/nvim-tree.lua'
" easy text alignment with tabs
Plug 'godlygeek/tabular'
" tool for batch renaming files
Plug 'qpkorr/vim-renamer'
" LaTeX
Plug 'lervag/vimtex'
call plug#end()
" }}}
" mason {{{
lua << EOF
require("mason").setup()
EOF
" }}}
" rust {{{
lua << EOF
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
EOF
" }}}
" vimtex {{{
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
" }}}
" lightline {{{
" gets rid of the double INSERT
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }
" }}}
" mappings {{{

" set leader to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" keeps the selection after indenting
vnoremap < <gv
vnoremap > >gv

" replace word mappings with camelcase ones
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" exit insert mode in the terminal with esc
tnoremap <Esc> <C-\><C-n>

" clear highlighting with esc
nnoremap <esc> :noh<return><esc>

" is this cool?
:nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" toggle relative line numbers
nnoremap <Leader>n :set rnu!<CR>

let g:vimspector_enable_mappings = 'HUMAN'

map <Leader>N :NvimTreeToggle<CR>

" }}}
" easymotion {{{
" changes the prefix from <space><space> to <space>
map <Leader> <Plug>(easymotion-prefix)
" characters the word motion to be bi-directional
nmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>t <Plug>(easymotion-bd-t)
nmap s         <Plug>(easymotion-s2)
" }}}
" editor {{{
set background=dark
colorscheme gruvbox
" mouse control
set mouse=a

" searches across cases only if the search is all lowercase
set smartcase

" a lot of plugins use this
set updatetime=300

" Better display for messages (this only kinda works)
set cmdheight=1

" limit the completion popup height
set pumheight=6

" start with folds open
set foldlevel=99

" press <tab>, get two spaces
set expandtab shiftwidth=2 smarttab

" turn line numbers on
:set nu

lua << EOF
require("nvim-tree").setup()
require("trouble").setup() 
EOF
" }}}
" cmp {{{
set completeopt=menuone,noinsert,noselect,preview
lua << EOF
local cmp = require'cmp'
local types = require'cmp.types'
cmp.setup({
  preselect = types.cmp.PreselectMode.None,
  mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})
EOF
" }}}
" tree-sitter {{{
lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
EOF
" }}}
" enables folding in this file {{{
" vim:fdm=marker
" }}}
