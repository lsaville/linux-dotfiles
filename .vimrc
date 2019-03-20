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
" determine system to smooth out mac/linux wrinkles
let s:uname = substitute(system("uname -s"), '\n', '', '')

" Makes leader a space
let mapleader = " "

set number
set cursorcolumn
set cursorline
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

"Change list chars
set listchars=tab:»·,trail:·,space:.,eol:¬

"With long filenames make the ENTER to continue business less likely
set cmdheight=3


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
:noremap <F4> :set relativenumber!<CR>

" Change px to rems
:nnoremap <F1> :.! awk 'BEGIN { FPAT = "([[:space:]]*[[:alnum:][:punct:][:digit:]]+)"; } { print $1 " " $2/16.0 "rem;" }'<CR>

" Run spec in tmux pane 1
:nnoremap <F5> :exe ":silent ! tmux send-keys -t 1 'be rspec %' Enter" \| redraw!<CR>

" set emacs style command line shortcuts
:cnoremap <C-A> <Home>
:cnoremap <C-F> <Right>
:cnoremap <C-B> <Left>
:cnoremap <C-E> <End>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" cruise buffer list
" nnoremap <C-f> :bn<CR>
" nnoremap <C-d> :bp<CR>
" Reinstate natural normal <C-f> and <C-d> behavior
" The strange chars for Darwin are the output for alt+f and alt+d
" The strange chars for linux are the output for alt+f and alt+d
" In the linux env alt+seemingly-anything == <esc>
if s:uname == "Darwin"
  nnoremap ƒ :bn<CR>
  nnoremap ∂ :bp<CR>
else
  nnoremap <esc>f :bn<CR>
  nnoremap <esc>d :bp<CR>
endif

" experimental learnvimscriptthehardway mappings
" capitalize word in normal mode
nnoremap <c-u>  viwU

" comment jsx
vnoremap <leader>cc :s/\(\s*\)\(.*\)/\1{\/*\2*\/}/ \| :nohl<CR>
" uncomment jsx
vnoremap <leader>cu :s/\(\s*\){\/\*\(.*\)\*\/}/\1\2<CR>

" sort
vnoremap <leader>s :sor<CR>

" from vimcasts
nnoremap <leader>l :set list!<CR>

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXPERIMENTAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

"nnoremap \ :Ag<SPACE>
