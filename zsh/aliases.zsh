# Edit aliases
alias aliases="$EDITOR $ZSH_FILES/aliases.zsh"

# Editor alias
alias e="$EDITOR ."

# Make sudo understand aliases
alias sudo='sudo '


# ---------- Directories ----------

alias cl='clear'
alias ls='eza --icons auto --group-directories-first'            # Better ls
alias la='eza -lah --icons auto --git --group-directories-first' # Detailed listing
alias tree='eza --tree --icons auto --group-directories-first'   # Tree

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls


# ---------- Navigation ----------

alias ..='cd ../'
alias ...='cd ../../'
alias -- -='cd -'


# ---------- Files ----------

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'


# ---------- Docker ----------

alias dcb='docker compose build'
alias dcbc='docker compose build --no-cache'
alias dcd='docker compose down --remove-orphans'
alias dce='docker compose exec app'
alias dcr='docker compose run --rm app'
alias dcs='docker compose stop'
alias dcx='docker compose restart'


# ---------- Git ----------

alias ga="git add"
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gce='git commit --allow-empty -m'
alias gcm='git commit -m'
alias gcnm='git commit -n -m'
alias gco='git checkout'
alias gdf='git diff --color'
alias gg='gaa && gcms'
alias gl='git lg'
alias gpl='git pull --prune'
alias gps='git push -u origin HEAD'
alias grmerged='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|main|develop)\s*$)" | command xargs -n 1 git branch -d'
alias gs='git status -sb'
alias gst='git stash'
alias gstp='git stash pop'

gcma()  { git commit -m "Add: $*"; }
gcmr()  { git commit -m "Remove: $*"; }
gcmu()  { git commit -m "Update: $*"; }
gcmf()  { git commit -m "Fix: $*"; }
gcmhf() { git commit -m "Hotfix: $*"; }
gcmrl() { git commit -m "Release: $*"; }
gcmrf() { git commit -m "Refactor: $*"; }
gcms()  { git commit -m "📌 $(date +%Y-%m-%d--%H:%M) $*"; }
gcnms() { git commit -n -m "📌 $(date +%Y-%m-%d--%H:%M) $*"; }


# ---------- Rails ----------

alias be='bundle exec'
alias dev-restart='overmind restart web worker vite'
alias rce='rails credentials:edit'
alias rr='rails runner'
alias rspec='rspec --color --format doc'
alias rst='touch tmp/restart.txt'
alias rdbc='rails dbconsole'
alias rdbm='rails db:migrate'


# ---------- OS ----------

killport() { kill -9 $(lsof -ti :$*); }
alias grep='grep --color=auto'
alias flushdnscache='dscacheutil -flushcache'
