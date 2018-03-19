set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
call vundle#begin()
" " let Vundle manage Vundle, required
" "
Plugin 'VundleVim/Vundle.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'sheerun/vim-polyglot'
Plugin 'rakr/vim-one'
Plugin 'mhartington/oceanic-next'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
"

" Making leader a space
let mapleader = " "

" Smarter tab line via vim-airline readme
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='molokai'

" center the cursor vertically or unset it, 0 is default
set scrolloff=0
if !exists('*VCenterCursor')
  augroup VCenterCursor
  au!
  au OptionSet *,*.*
    \ if and( expand("<amatch>")=='scrolloff' ,
    \         exists('#VCenterCursor#WinEnter,VimResized') )|
    \   au! VCenterCursor WinEnter,WinNew,VimResized|
    \ endif
  augroup END
  function VCenterCursor()
    if !exists('#VCenterCursor#WinEnter,VimResized')
      let s:default_scrolloff=&scrolloff
      let &scrolloff=winheight(win_getid())/2
      au VCenterCursor WinEnter,VimResized *,*.*
        \ let &scrolloff-winheight(win_getid())/2
    else
      au! VCenterCursor WinEnter,VimResized
      let &scrolloff=s:default_scrolloff
    endif
  endfunction
endif

" toggle between VCenterCursor and scrolloff=0
nnoremap <leader>zz :call VCenterCursor()<CR>

" cruise buffer list
nmap <C-f> :bn<CR>
nmap <C-d> :bp<CR>

" " keymap for easy pane motion, apparently obviated by the
" vim-tmux-navigation

"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" Having both relative and absolute line numbering
set number
set cursorcolumn
set colorcolumn=80

" " kill the swp files
set nobackup
set noswapfile
" " spacing n stuff
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set autoindent
set mouse=a

set pastetoggle=<F2>
:map <F3> :nohl<CR>
set showcmd
set showmode
set hlsearch
set incsearch

" " nerdtree access
nnoremap <leader>n :NERDTreeToggle<cr>

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

"Set background as dark
set background=dark

"Don't show the splash screen on startup
set shortmess=I

" set emacs style command line shortcuts
:cnoremap <C-A> <Home>
:cnoremap <C-F> <Right>
:cnoremap <C-B> <Left>
:cnoremap <C-E> <End>

"show hidden files in nerdtree
let NERDTreeShowHidden=1

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
