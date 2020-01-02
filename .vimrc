set nocompatible              " be iMproved, required
filetype off

" Vimwiki... bad things start to happen with filetype plugin on and html.erb
" files. This is an outstanding mystery
"filetype plugin on
"let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugins have been moved into ~/.vim/pack/foo/start/* to utilize vim8 packages

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" determine system to smooth out mac/linux wrinkles
let s:uname = substitute(system("uname -s"), '\n', '', '')

" Makes leader a space
let mapleader = " "
let maplocalleader = "\\"

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

noremap <F3> :nohlsearch<CR>
noremap <F4> :set relativenumber!<CR>

" Change px to rems
nnoremap <F1> :.! awk 'BEGIN { FPAT = "([[:space:]]*[[:alnum:][:punct:][:digit:]]+)"; } { print $1 " " $2/16.0 "rem;" }'<CR>

" Run spec in tmux pane 1
nnoremap <F5> :execute ":silent ! tmux send-keys -t 1 'be rspec %' Enter" \| redraw!<CR>

vnoremap <F6> :Twrite 1<CR>

" set emacs style command line shortcuts
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" cruise buffer list
" nnoremap <C-f> :bn<CR>
" nnoremap <C-d> :bp<CR>
" Reinstate natural normal <C-f> and <C-d> behavior
" The strange chars for Darwin are the output for alt+f and alt+d
" The strange chars for linux are the output for alt+f and alt+d
" In the linux env alt+seemingly-anything == <esc>
if s:uname == "Darwin" " osx
  nnoremap ƒ :bn<CR>
  nnoremap ∂ :bp<CR>
else " linux
  nnoremap <esc>f :bn<CR>
  nnoremap <esc>d :bp<CR>
endif

nnoremap <leader>q :bd<CR>
nnoremap <leader>wq :w\|bd<CR>

" experimental learnvimscriptthehardway mappings
" capitalize word in normal mode
nnoremap <c-u>  viwU
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Kill html tags. Makes it easy to manually scrape web-content
nnoremap <leader>kh :%s/<\([^<]*\)>//g<CR>

" comment jsx
vnoremap <leader>cc :s/\(\s*\)\(.*\)/\1{\/*\2*\/}/ \| :nohl<CR>
" uncomment jsx
vnoremap <leader>cu :s/\(\s*\){\/\*\(.*\)\*\/}/\1\2<CR>

" sort
vnoremap <leader>s :sort<CR>

vnoremap <leader>0 :Twrite 0<CR>
vnoremap <leader>1 :Twrite 1<CR>
vnoremap <leader>2 :Twrite 2<CR>
vnoremap <leader>3 :Twrite 3<CR>
vnoremap <leader>4 :Twrite 4<CR>
vnoremap <leader>5 :Twrite 5<CR>
vnoremap <leader>6 :Twrite 6<CR>

" from vimcasts
nnoremap <leader>l :set list!<CR>

" From youtube video... primitive snippet
" https://youtu.be/XA2WjJbmmoM
" https://github.com/changemewtf/dotfiles/blob/master/vim/.vimrc
nnoremap <leader>m1 :-1read $HOME/.vim/final-commit-msg.txt<CR>C
nnoremap <leader>m2 :-1read $HOME/.vim/tj-pr.txt<CR>}}O

" Get persisted bit from pry session
nnoremap <leader>p :.! cat /tmp/pry-output.json \| jq .<CR>

"nnoremap <leader>f :exe ":silent ! echo % \| tr -d '\n' \| xclip -sel clip \| redraw!"<CR>

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
"if executable('ag')
"  " Use ag over grep
"  set grepprg=ag\ --nogroup\ --nocolor
"
"  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"
"  " ag is fast enough that CtrlP doesn't need to cache
"  let g:ctrlp_use_caching = 0
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Let vim know from whence springs fzf
set rtp+=~/.fzf

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'up': '~20%' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <C-p> :FZF<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EXPERIMENTAL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bind \ (backward slash) to grep shortcut
"command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

"nnoremap \ :Ag<SPACE>
function! GitUntrackedChanges()
  let flist = systemlist("git status --porcelain | sed 's/M //g'")
  let list = []
  for f in flist
    " git blame is the easiest comamnd I found that actually gives back line
    " numbers.
    let command = "git blame " . f . " -nf
          \ | grep 'Not Committed Yet'
          \ | sed 's/^[0..9,a..z]* //g'
          \ | sed 's/(.*//g' "
    let blamed_lines = system(command)
    let split = split(blamed_lines)
    if len(split) != 0
      let dic = { "filename": split[0], "lnum": split[1] }
    else
      " If the only change is a deletion, git blame won't pick it up, so
      " instead we just have to put the file name in, this isn't ideal.
      let filename = trim(f)
      let dic = { "filename": filename}
    endif
    call add(list, dic)
  endfor
  " This sets the quickfix list, with 'list' being a list of dictionaries that
  " have filename, line number, model etc.
  call setqflist(list)
  copen
endfunction
nnoremap <Leader>gc :silent call GitUntrackedChanges()<Cr>
