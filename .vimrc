set nocompatible              " be iMproved, required
filetype off

" Vimwiki... bad things start to happen with filetype plugin on and html.erb
" files. This is an outstanding mystery
filetype plugin on
let g:vimwiki_list = [
  \{'path': '~/Dropbox/wiki_wiki/', 'syntax': 'markdown', 'ext': '.md'},
  \{'path': '~/Dropbox/old_vimwiki/', 'syntax': 'markdown', 'ext': '.md'}
  \]
syntax on

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

let g:netrw_browsex_viewer= "xdg-open"

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

" Prevent screen clear on vim exit (bg too)
" https://github.com/garybernhardt/dotfiles/blob/7e0f353bca25b07d2ef9bcae2070406e3d4ac029/.vimrc#L57
" http://www.shallowsky.com/linux/noaltscreen.html
" This is now handled on a system level by a line in .Xresources
set t_ti= t_te=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
colorscheme OceanicNext

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smarter tab line via vim-airline readme
let g:airline#extensions#tabline#enabled=1
let g:airline_theme='oceanicnext'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

noremap <F3> :nohlsearch<CR>
noremap <F4> :set relativenumber!<CR>

" Change px to rems
nnoremap <F1> :.! awk 'BEGIN { FPAT = "([[:space:]]*[[:alnum:][:punct:][:digit:]]+)"; } { print $1 " " $2/16.0 "rem;" }'<CR>

" Run spec in tmux pane 1
nnoremap <F5> :execute ":silent ! tmux send-keys -t 1 Enter \| tmux send-keys -t 1 'be rspec %' Enter" \| redraw!<CR>

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

nnoremap <esc>p :Buffers<CR>

nnoremap <leader>q :bd<CR>
nnoremap <leader>wq :w\|bd<CR>

" experimental learnvimscriptthehardway mappings
" capitalize word in normal mode
inoremap <c-u>  viwUEi
nnoremap <c-u>  viwUe
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>eb :e ~/.bashrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>c :.!awk -F, '{print NF}'<CR>

" Kill html tags. Makes it easy to manually scrape web-content
nnoremap <leader>kh :%s/<\([^<]*\)>//g<CR>

" comment jsx
vnoremap <leader>cc :s/\(\s*\)\(.*\)/\1{\/*\2*\/}/ \| :nohl<CR>
" uncomment jsx
vnoremap <leader>cu :s/\(\s*\){\/\*\(.*\)\*\/}/\1\2<CR>

" sort
vnoremap <leader>s :sort<CR>

vnoremap <leader>0 :Twrite 0<CR>}
vnoremap <leader>1 :Twrite 1<CR>}
vnoremap <leader>2 :Twrite 2<CR>}
vnoremap <leader>3 :Twrite 3<CR>}
vnoremap <leader>4 :Twrite 4<CR>}
vnoremap <leader>5 :Twrite 5<CR>}
vnoremap <leader>6 :Twrite 6<CR>}

nnoremap <leader>7 vip:call DBeaver()<CR>}

" from vimcasts
nnoremap <leader>l :set list!<CR>

" from https://github.com/sirupsen/dotfiles/blob/8d232bab79c0032af1b827ad523d77f0f8959037/home/.vimrc#L147
vnoremap <leader>s :!sqlformat --reindent --keywords lower --identifiers lower -<CR>

" from https://vim.fandom.com/wiki/Move_to_next/previous_line_with_same_indentation
nnoremap <esc>b :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
nnoremap <esc>e :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>
vnoremap <esc>b :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%<' . line('.') . 'l\S', 'be')<CR>
vnoremap <esc>e :call search('^'. matchstr(getline('.'), '\(^\s*\)') .'\%>' . line('.') . 'l\S', 'e')<CR>


" From youtube video... primitive snippet
" https://youtu.be/XA2WjJbmmoM
" https://github.com/changemewtf/dotfiles/blob/master/vim/.vimrc
" -1 gets rid of having a blank line at top
nnoremap <leader>m1 :-1read $HOME/.vim/final-commit-msg.txt<CR>C
nnoremap <leader>m2 :-1read $HOME/.vim/tj-pr.txt<CR>o

" Get persisted bit from pry session
" nnoremap <leader>p :.! ruby -e "require 'json'; pp JSON.parse(File.read('/tmp/pry-output.json'))"<CR>

nnoremap <leader>p :.! cat /tmp/pry-output.json \| jq .<CR>

" Get current filename to system clipboard
function! GimmeFilename()
  execute system('echo -n ' . expand('%') . ' | xclip -sel clip')
endfunction
"nnoremap <leader>f :silent call GimmeFilename()<CR>
nnoremap <leader>f :let @+=expand('%')<CR>

" file name with line
nnoremap <leader>gl :let @+=expand('%') . ":" . line('.')<CR>

" Go to or create scratch file
nnoremap <leader>sf :call FindOrCreateScratchFile()<CR>

" Toggle Goyo
nnoremap <leader>g :Goyo<CR>

function! DBeaver() range
  let selection = join(map(getline(a:firstline, a:lastline), 'substitute(v:val, "^\\s*","","")'), "\r")
  let @+ = selection

  " go to left i3 pane
  execute system('xdotool key Super_L+h')
  " select all text and delete
  execute system('xdotool key ctrl+a BackSpace')
  " paste query
  execute system('xdotool key ctrl+v')
  " run query in DBeaver
  execute system('xdotool key ctrl+Return')
  " go to back from whence it came
  execute system('xdotool key Super_L+h')
  "redraw!
endfunction

function! DoStuff()
    let lineNum = line('.')
    let fileName = resolve(expand('%:t'))
    let fileDir = resolve(expand("%:p:h"))
    let cdDir = "cd '" . fileDir . "'; "
    let l:remotes = system(cdDir . "git remote")
    let l:remote_list = split(l:remotes, '\n')
    let remote_url = system(cdDir . "git config --get remote.origin.url")
    " Get Directory & File Names
    let fullPath = resolve(expand("%:p"))
    " Git Commands
    let gitRoot = system(cdDir . "git rev-parse --show-toplevel")
    " Strip Newlines
    let remote_url = StripNL(remote_url)
    let gitRoot = StripNL(gitRoot)
    let fullPath = StripNL(fullPath)
    " Git Relative Path
    let relative = split(fullPath, gitRoot)[-1]

    echom "lineNum: " . lineNum
    echom "fileName: " . fileName
    echom "fileDir: " . fileDir
    echom "cdDir: " . cdDir
    echom "l:remotes: " . l:remotes
    echom "l:remote_list: " . l:remote_list
    echom "remote_url: " . remote_url
    echom "fullPath: " . fullPath
    echom "gitRoot: " . gitRoot
    echom "remote_url: " . remote_url
    echom "gitRoot: " . gitRoot
    echom "fullPath: " . fullPath
    echom "relative: " . relative
endfunction

func! StripNL(l)
  return substitute(a:l, '\n$', '', '')
endfun


" attemp to use jk as ctrl-c
inoremap jk 
inoremap  <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " nerdtree access
nnoremap <leader>n :NERDTreeToggle<cr>

"show hidden files in nerdtree
let NERDTreeShowHidden=1

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
augroup filetype_elixir
  autocmd!
  autocmd filetype elixir :iabbrev <buffer> pry require IEx;IEx.pry
augroup end

augroup filetype_ruby
  autocmd!
  autocmd filetype ruby :iabbrev <buffer> def defend<up>
  autocmd filetype ruby :iabbrev <buffer> pry binding.pry
augroup end

" Vimscript file settings ------------------------------- {{{
augroup filetype_vim
  autocmd!
  autocmd filetype vim setlocal foldmethod=marker
augroup end
" }}}

augroup filetype_html
  autocmd!
  autocmd filetype html nnoremap <buffer> <localleader>f Vatzf
augroup end

" From Zach Thomas
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

function FindOrCreateScratchFile()
  let l:scratch_file_name = StripNL(system("branch-scratch-name"))
  execute "e ".fnameescape("../scratch/" . l:scratch_file_name)
endfunction


" zk trial -> https://github.com/sirupsen/dotfiles/blob/master/home/.vimrc#L480-L517

function! SNote(...)
  let path = strftime("%Y%m%d%H%M")."-".trim(join(a:000)).".md"
  execute ":sp " . fnameescape(path)
endfunction
command! -nargs=* SNote call SNote(<f-args>)

function! Note(...)
  let path = strftime("%Y%m%d%H%M")."-".trim(join(a:000)).".md"
  execute ":e " . fnameescape(path)
endfunction
command! -nargs=* Note call Note(<f-args>)

function! ZettelkastenSetup()
  if expand("%:t") !~ '^[0-9]\+'
    return
  endif
  " syn region mkdFootnotes matchgroup=mkdDelimiter start="\[\["    end="\]\]"

  inoremap <expr> <plug>(fzf-complete-path-custom) fzf#vim#complete#path("rg --files -t md \| sed 's/^/[[/g' \| sed 's/$/]]/'")
  imap <buffer> [[ <plug>(fzf-complete-path-custom)

  function! s:CompleteTagsReducer(lines)
    if len(a:lines) == 1
      return "#" . a:lines[0]
    else
      return split(a:lines[1], '\t ')[1]
    end
  endfunction

  inoremap <expr> <plug>(fzf-complete-tags) fzf#vim#complete(fzf#wrap({
        \ 'source': 'zkt-raw',
        \ 'options': '--multi --ansi --nth 2 --print-query --exact --header "Enter without a selection creates new tag"',
        \ 'reducer': function('<sid>CompleteTagsReducer')
        \ }))
  imap <buffer> # <plug>(fzf-complete-tags)
endfunction

" Don't know why I can't get FZF to return {2}
function! InsertSecondColumn(line)
  " execute 'read !echo ' .. split(a:e[0], '\t')[1]
  exe 'normal! o' .. split(a:line, '\t')[1]
endfunction

command! ZKR call fzf#run(fzf#wrap({
        \ 'source': 'ruby ~/.bin/zk-related.rb "' .. bufname("%") .. '"',
        \ 'options': '--ansi --exact --nth 2',
        \ 'sink':    function("InsertSecondColumn")
      \}))

autocmd BufNew,BufNewFile,BufRead ~/Documents/Zettelkasten/*.md call ZettelkastenSetup()

function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    silent exec "!xdg-open '".s:uri."'"
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>
