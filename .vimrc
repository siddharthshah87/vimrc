" ---------------------------------------------------------
" Vim Config for Windows Git Bash - Modern Setup with vim-plug
" ---------------------------------------------------------

set nocompatible
set encoding=utf8
filetype plugin indent on
syntax on

" -----------------------------
" => vim-plug Plugin Manager
" -----------------------------
call plug#begin('~/.vim/plugged')

" File explorer
Plug 'preservim/nerdtree'

" Fuzzy search and grep
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" GitHub Copilot
" Plug 'github/copilot.vim'
Plug 'dense-analysis/ale'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colorschemes
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/everforest'
Plug 'shaunsingh/nord.nvim'

" Editing helpers
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

call plug#end()

let g:ale_completion_enabled = 1
" -----------------------------
" => General Settings
" -----------------------------
set number
set relativenumber
set ruler
set wrap
set showmatch
set cursorline
set scrolloff=5
set hidden
set backspace=indent,eol,start

" File encodings
set fileencodings=utf-8
set fileformats=unix,dos,mac

" Search behavior
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <leader><CR> :nohlsearch<CR>

" Tabs and indentation
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent

" Leader key
let mapleader = " "

" Save shortcut
nnoremap <leader>w :w!<CR>

" NERDTree toggle
nnoremap <leader>n :NERDTreeToggle<CR>

" Comment toggle
nnoremap <leader>c :Commentary<CR>
vnoremap <leader>c :Commentary<CR>

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Reload vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

" Statusline with airline
let g:airline_powerline_fonts = 1

" Colorscheme
colorscheme onedark
set background=dark

" Completion fixes for popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"

" -----------------------------
" => FZF + Ripgrep Settings
" -----------------------------
set grepprg=rg\ --vimgrep\ --smart-case
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>rg :Rg<Space>
nnoremap <leader>qf :copen<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprev<CR>

" -----------------------------
" => GitHub Copilot
" -----------------------------
" imap <C-l> <Plug>(copilot-accept)

" -----------------------------
" => Auto Commands
" -----------------------------
" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Automatically open NERDTree if starting empty or with a folder
autocmd VimEnter * if argc() == 0 | NERDTree | wincmd p | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'NERDTree' argv()[0] | wincmd l | endif
