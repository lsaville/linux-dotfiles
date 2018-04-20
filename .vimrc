set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
call vundle#begin()
" " let Vundle manage Vundle, required
" "
Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'mhartington/oceanic-next'
Plugin 'vim-airline/vim-airline'
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes leader a space
let mapleader = " "

set number
set relativenumber
set cursorcolumn
set colorcolumn=80
set backspace=indent,eol,start

" " kill the swp files
set nobackup
set noswapfile
" " spacing n stuff
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set autoindent
set mouse=a

set pastetoggle=<F2>
set showcmd
set showmode
set hlsearch
set incsearch

"Set background as dark
set background=dark

"Don't show the splash screen on startup
set shortmess=I

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Colorscheme
colorscheme OceanicNext
autocmd Colorscheme * highlight Normal ctermbg=None
autocmd Colorscheme * highlight NonText ctermbg=None

" Switch syntax highlighting on
syntax on
" oceanic settings
syntax enable
if (has("termguicolors"))
  set termguicolors
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smarter tab line via vim-airline readme
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='oceanicnext'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

:noremap <F3> :nohl<CR>

" set emacs style command line shortcuts
:cnoremap <C-A> <Home>
:cnoremap <C-F> <Right>
:cnoremap <C-B> <Left>
:cnoremap <C-E> <End>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" cruise buffer list
nnoremap <C-f> :bn<CR>
nnoremap <C-d> :bp<CR>

" experimental learnvimscriptthehardway mappings
" capitalize word in normal mode
nnoremap <c-u>  viwU

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " nerdtree access
nnoremap <leader>n :NERDTreeToggle<cr>

"show hidden files in nerdtree
let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
