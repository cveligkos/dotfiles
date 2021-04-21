" =================================
" vim-plug
" =================================
" Auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

" sensible.vim: Defaults everyone can agree on
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plugin to move lines and selections up and down
Plug 'matze/vim-move'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'
Plug 'folke/tokyonight.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tweekmonster/startuptime.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

call plug#end()

" =================================
" Theme
" =================================
" Tokyo Night settings
" The theme comes in two styles, 'storm' and a darker variant 'night'.
let g:tokyonight_style = "night"

" Comments are italicized by default
let g:tokyonight_italic_comments = 1

" Keywords are italicized by default
let g:tokyonight_italic_keywords = 1

" Functions are not italicized by default
let g:tokyonight_italic_functions = 0

" Enable this to disable setting the background color
let g:tokyonight_transparent = 0

" Enabling this option, will hide inactive statuslines and
" replace them with a thin border instead. Should work with
" the standard `StatusLine` and `LuaLine`.
let g:tokyonight_hide_inactive_statusline = 0

colorscheme tokyonight

" =================================
" Options
" =================================
" Load vim-sensible defaults so that settings below can override them
runtime! plugin/sensible.vim

set cursorline

set number
set relativenumber

set hidden

" Needed for nvim-compe
set completeopt=menuone,noselect

" Mappings
let mapleader = " "
nnoremap <leader>sv :source ~/.local/share/chezmoi/dot_config/nvim/init.vim<CR>
nnoremap <leader>ev :vsplit ~/.local/share/chezmoi/dot_config/nvim/init.vim<CR>

nnoremap <M-s> :write<CR>
nnoremap <M-q> :bd<CR>
nnoremap ; :

nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>r :Rg 

nmap <leader>c gcc

nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pU :PlugUpgrade<CR>
nnoremap <leader>pu :PlugUpdate<CR>

" Auto apply chezmoi files
augroup chezmoi
    autocmd! chezmoi
    autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path %
    autocmd BufWritePost ~/.local/share/chezmoi/dot_config/nvim/init.vim :source $MYVIMRC
augroup END

" =================================
" Plugin settings
" =================================
" gitsigns.nvim
lua require('gitsigns').setup()

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" nvim-tresitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  }
}
EOF

" nvim-lspconfig
lua << EOF

-- rust-analyzer
require'lspconfig'.rust_analyzer.setup{}

-- vimls
require'lspconfig'.vimls.setup{}

EOF

" Jump to definition
nnoremap <silent> gD <cmd>lua vim.lsp.buf.definition()<CR>

" nvim-compe
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
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
let g:compe.source.vsnip = v:true

" Mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

highlight link CompeDocumentation NormalFloat
