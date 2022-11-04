# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# force history to read/write on every command
#export PROMPT_COMMAND="history -a; history -n"
export PROMPT_COMMAND='history -a; history -n; if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias r='ranger'
alias pnr='git co master-passing-tests && git pull origin master-passing-tests && git co - && git rebase master-passing-tests'

alias meow='mpg123 -q ~/git/linux-dotfiles/jaguar2.mp3'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Don't clear the screen after quitting a man page
export MANPAGER="less";
#export PAGER="pspg -s 4";
export PAGER="less";
#export LESS="-iMSx4 -RFX"

# set vim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# The following ported from my macbook
# [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

#  ⚡ [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# export PS1="\W \[\033[0;33m\]⚡\[\033[0;39m\] "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# bash_prompt

# Example:
# nicolas@host: ~/.dotfiles on master [+!?$]
# $

# Screenshot: http://i.imgur.com/DSJ1G.png
# iTerm2 prefs: import Solarized theme (disable bright colors for bold text)
# Color ref: http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
# More tips: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html

prompt_git() {
    local s=""
    local branchName=""

    # check if the current directory is in a git repository
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?) == 0 ]; then

        # check if the current directory is in .git before running git checks
        if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == "false" ]; then

            # ensure index is up to date
            git update-index --really-refresh  -q &>/dev/null

            # check for uncommitted changes in the index
            if ! $(git diff --quiet --ignore-submodules --cached); then
                s="$s+";
            fi

            # check for unstaged changes
            if ! $(git diff-files --quiet --ignore-submodules --); then
                s="$s!";
            fi

            # check for untracked files
            if [ -n "$(git ls-files --others --exclude-standard)" ]; then
                s="$s?";
            fi

            # check for stashed files
            if $(git rev-parse --verify refs/stash &>/dev/null); then
                s="$s$";
            fi

        fi

        # get the short symbolic ref
        # if HEAD isn't a symbolic ref, get the short SHA
        # otherwise, just give up
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
                      git rev-parse --short HEAD 2> /dev/null || \
                      printf "(unknown)")"

        [ -n "$s" ] && s=" [$s]"

        printf "%s" "$1$branchName$s"
    else
        return
    fi
}

dashed_line() {
  printf "%*s" $(tput cols) "" | sed "s/ /-/g"
}

set_prompts() {
    local black=""
    local blue=""
    local bold=""
    local cyan=""
    local green=""
    local orange=""
    local purple=""
    local red=""
    local reset=""
    local white=""
    local yellow=""

    local hostStyle=""
    local userStyle=""

    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        tput sgr0 # reset colors

        bold=$(tput bold)
        reset=$(tput sgr0)

        # Solarized colors
        # (https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized#the-values)
        black=$(tput setaf 0)
        blue=$(tput setaf 33)
        cyan=$(tput setaf 37)
        green=$(tput setaf 64)
        orange=$(tput setaf 166)
        purple=$(tput setaf 125)
        red=$(tput setaf 124)
        white=$(tput setaf 15)
        yellow=$(tput setaf 136)
    else
        bold=""
        reset="\e[0m"

        black="\e[1;30m"
        blue="\e[1;34m"
        cyan="\e[1;36m"
        green="\e[1;32m"
        orange="\e[1;33m"
        purple="\e[1;35m"
        red="\e[1;31m"
        white="\e[1;37m"
        yellow="\e[1;33m"
    fi

    # build the prompt

    # logged in as root
    if [[ "$USER" == "root" ]]; then
        userStyle="\[$bold$red\]"
    else
        userStyle="\[$orange\]"
    fi

    # connected via ssh
    if [[ "$SSH_TTY" ]]; then
        hostStyle="\[$bold$red\]"
    else
        hostStyle="\[$yellow\]"
    fi

    # set the terminal title to the current working directory
    PS1="\$(dashed_line)"
    PS1+="\[\033]0;\w\007\]"

    PS1+="\n" # newline
    PS1+="\[$purple\]\u @ \[$blue\]\w" # working directory
    PS1+="\$(prompt_git \"$reset on $bold$cyan\")" # git repository details
    PS1+="\n"
    PS1+="\[$reset$white\]\$ \[$reset\]" # $ (and reset color)

    export PS1
}

set_prompts
unset set_prompts

man() {
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;34m')" \
		LESS_TERMCAP_md="$(printf '\e[1;34m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[100m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[2;32m')" \
		man "$@"
}

alias awsume=". awsume"
# shortcuts for git
alias ga="git add"
alias gb="git branch"
alias gd="git diff --patience --ignore-space-change"
#alias gh="git log --pretty=format:\"%Cgreen%h%Creset %Cblue%ad%Creset %s%C(yellow)%d%Creset %Cblue[%an]%Creset\" --graph --date=short"
alias gc="git commit -m"
alias gs="git status"

alias nuke="bundle exec rake db:drop db:create db:migrate db:seed db:test:prepare"
alias be="bundle exec"
alias reload='source ~/.bashrc'
alias o="cs git/optimizely_server/public/optimizely"
#alias fd="rg --hidden --ignore-case"
alias aep="awsume eac_production -r --role-duration 28800"
alias aes="awsume eac_staging -r --role-duration 28800"
# "temp time"
alias tt="sudo mount -o remount,size=10G,noatime /tmp"
alias kiq="SIDEKIQ_LOGGING=debug SIDEKIQ_CONCURRENCY=1 nice -n19 bundle exec sidekiq -C config/sidekiq.yml"
alias rs="bundle exec rails s"
alias rc="bundle exec rails c"
alias norg="gron --ungron"
alias ungron="gron --ungron"

#combo functions from Sal Espinosas bash profile
function cs () {
  cd "$@" && ls
}

function mdc () {
  mkdir "$@" && cd "$@"
}

#git diff followed by git add
function da () {
  gd "$@" && ga "$@"
}

#a la Robbie Smith
gcb() {
  local tags branches target
  branches=$(
  git branch --color | grep -v HEAD             |
  sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
  sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
  ( echo "$branches") |
  fzf-tmux -l40 -- --no-hscroll --ansi +m -d "\t" -n 2 -1 -q "$*") || return
  git checkout $(echo "$target" | awk '{print $2}')
}

gdb() {
  local tags branches target
  branches=$(
  git branch --color | grep -v HEAD             |
  sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
  sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
  ( echo "$branches") |
  fzf-tmux -l40 -- --no-hscroll --ansi +m -d "\t" -n 2 -1 -q "$*") || return
  git branch -d $(echo "$target" | awk '{print $2}')
}

function notify {
  title=${1:-"🎉  Finished! 🎉 "}
  msg=${2:-"Your command is finished!"}
  osascript -e "display notification \"$msg\" with title \"$title\" sound name \"Default\""
}

#PATH=/home/lee/.rbenv/shims:/home/lee/.rbenv/bin:/home/lee/.rbenv/bin:/home/lee/.rbenv/shims:/home/lee/.rbenv/bin:/home/lee/bin:/home/lee/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/lee/.phantomjs/phantomjs/bin
export PHANTOMJS_BIN=/home/lee/.phantomjs/phantomjs/bin/phantomjs

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# This is a quick fix for awsume... should probably link this elsewhere
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin/
#export NODEJS_HOME=/usr/local/lib/nodejs/node-v11.6.0-linux-x64/bin
#export PATH=$NODEJS_HOME:$PATH

#eval "$(rbenv init -)"

#source ~/.meow

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#. $HOME/.asdf/asdf.sh

#. $HOME/.asdf/completions/asdf.bash

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

export FZF_DEFAULT_COMMAND='rg \
--files \
--no-ignore \
--hidden \
--follow \
--glob "!.git/*" \
--glob "!node_modules/*" \
--glob "!deps/*" \
--glob "!tmp/*" \
--glob "!_build/*"'

# from zk trial -> https://github.com/sirupsen/zk

#export FZF_DEFAULT_OPTS="--height=40% --multi --tiebreak=begin \
#  --bind 'ctrl-y:execute-silent(echo {} | xclip -sel clip)' \
#  --bind 'alt-down:preview-down,alt-up:preview-up' \
#  --bind \"ctrl-v:execute-silent[ \
#    tmux send-keys -t \{left\} Escape :vs Space && \
#    tmux send-keys -t \{left\} -l {} && \
#    tmux send-keys -t \{left\} Enter \
#  ]\"
#  --bind \"ctrl-x:execute-silent[ \
#    tmux send-keys -t \{left\} Escape :sp Space && \
#    tmux send-keys -t \{left\} -l {} && \
#    tmux send-keys -t \{left\} Enter \
#  ]\"
#  --bind \"ctrl-o:execute-silent[ \
#    tmux send-keys -t \{left\} Escape :read Space ! Space echo Space && \
#    tmux send-keys -t \{left\} -l \\\"{}\\\" && \
#    tmux send-keys -t \{left\} Enter \
#  ]\""

export PATH=$PATH:$HOME/git/zk/bin
export ZK_PATH="$HOME/Dropbox/Zettelkasten"

export DISABLE_SPRING=1

alias awsume_eac_stag1="awsume eac_staging && kubectl config use-context stag1"
alias awsume_eac_stag2="awsume eac_staging && kubectl config use-context stag2"
alias awsume_eac_prod1="awsume eac_production && kubectl config use-context prod1"
# prod2 has database proxy
alias awsume_eac_prod2="awsume eac_production && kubectl config use-context prod2"

alias awsume_exs_stag1="awsume calcs_admin_staging && kubectl config use-context stag1"
alias awsume_exs_stag2="awsume calcs_admin_staging && kubectl config use-context stag2"
alias awsume_exs_prod1="awsume calcs_admin_production && kubectl config use-context prod1"
# prod2 has database proxy
alias awsume_exs_prod2="awsume calcs_admin_production && kubectl config use-context prod2"


alias pay_eac='pay ssh --force-tty "cd /pay/src/engine-admin-console; source ./bin/devbox_env; /bin/bash"'

alias bb="bazel build //uppsala/src/main/java/com/stripe/monetization/tax/... //uppsala/src/test/java/com/stripe/monetization/tax/..."
alias bt="bazel build //uppsala/src/test/java/com/stripe/monetization/tax/..."
alias bm="bazel build //uppsala/src/main/java/com/stripe/monetization/tax/..."
# alias pay_filing='pay ssh --force-tty "cd /pay/src/filing_api; source ./bin/devbox_env; /bin/bash"'
# alias pay_tj='pay ssh --force-tty "cd /pay/src/taxjar; source ./bin/devbox_env; /bin/bash"'
# alias pay_centauri='pay ssh --force-tty "cd /pay/src/centauri; source ./bin/devbox_env; /bin/bash"'

# alias sync_env_tj='pay copy ~/stripe/taxjar/.env.development.local qa-mydev:/pay/src/taxjar/.env.development.local'
# alias sync_env_centauri='pay copy ~/stripe/centauri/.env.development.local qa-mydev:/pay/src/centauri/.env.development.local'
# These take about 2 seconds longer than the commands above, but also pull down the latest ENV vars from Confidant onto the dev box.
# alias sync_env_tj='pay ssh "/pay/src/pay-server/devbox/dev_services/scripts/taxjar/populate_dotenv_files.sh taxjar" && pay copy ~/stripe/taxjar/.env.development.local qa-mydev:/pay/src/taxjar/.env.development.local'
# alias sync_env_centauri='pay ssh "/pay/src/pay-server/devbox/dev_services/scripts/taxjar/populate_dotenv_files.sh centauri" && pay copy ~/stripe/centauri/.env.development.local qa-mydev:/pay/src/centauri/.env.development.local'

# alias awsume_staging="awsume staging && kubectl config use-context staging"
# alias awsume_production="awsume production && kubectl config use-context production"
# 
# alias staging_console="cd ~/stripe/taxjar-console && docker-compose exec console zsh -i -c 'awsume staging && kubectl config use-context staging && hatch run -n taxjar -a taxjar-ui rails c'"
#alias staging_console="cd ~/stripe/taxjar-console && docker-compose exec console zsh -i -c 'awsume staging && kubectl config use-context staging && hatch run -n taxjar -a taxjar-ui rails c'"
# alias staging_shell="cd ~/stripe/taxjar-console && docker-compose exec console zsh -i -c 'awsume staging && kubectl config use-context staging && hatch run -n taxjar -a taxjar-ui /bin/bash'"
# 
# alias prod_read_console="cd ~/stripe/taxjar-console && docker-compose exec console zsh -i -c 'awsume production && kubectl config use-context production && hatch run -n readonly -a taxjar rails c'"
# alias prod_write_console="cd ~/stripe/taxjar-console && docker-compose exec console zsh -i -c 'awsume production && kubectl config use-context production && hatch run -n taxjar-ui -a taxjar rails c'"
# alias prod_shell="cd ~/stripe/taxjar-console && docker-compose exec console zsh -i -c 'awsume production && kubectl config use-context production && hatch run -n taxjar -a taxjar-ui /bin/bash'"
# 
# alias dev_db_tunnel="ssh -L 3333:localhost:5432 '$USER'@'$(pay show-host)'"
# 
# alias docker-login='awsume default && aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 708017133719.dkr.ecr.us-east-1.amazonaws.com'

# This wrecks my current prompt... powerline is experimental for i3status-rust
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/share/powerline/bindings/bash/powerline.sh
source ~/git-completion.bash
source <(kubectl completion bash)

# fzf-menu was throwing ls errors... these don't exist
#export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/lib:$PATH/"
export LD_LIBRARY_PATH=/usr/local/lib

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

. "$HOME/.cargo/env"
