# Edit aliases
alias aliases='$EDITOR ~/dotfiles/zsh/aliases.zsh'

# Editor alias
alias e='$EDITOR .'

# Make sudo understand aliases
alias sudo='sudo '

# Cloudflare
#
alias run-bless-tunnel='cloudflared tunnel run bless-app-frank'

# Directories
#
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias cl='clear'
alias cp='cp -iv'
alias l='ls -lh'
alias la='ls -Alh'
alias lh='ls -Alt | head'
alias mv='mv -iv'
alias rm='rm -iv'

# Docker
#
alias dcb='docker compose build'
alias dcbc='docker compose build --no-cache'
alias dcd='docker compose down --remove-orphans'
alias dcr='docker compose run --rm app'
alias dcx='docker compose restart'
alias dcs='docker compose stop'
alias dce='docker compose exec app'

# Git
#
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gce='git commit --allow-empty -m'
alias gcm='git commit -m'
alias gcnm='git commit -n -m'
alias gco='git checkout'
alias gdf='git diff --color | diff-so-fancy'
alias gg='gaa && gcms'
alias gl='git lg'
alias gpl='git pull --prune'
alias gps='git push -u origin HEAD'
alias grmerged='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|main|develop)\s*$)" | command xargs -n 1 git branch -d'
alias gs='git status -sb'
alias gst='git stash'
alias gstp='git stash pop'

gcma()  { git commit -m "Add: $*"; }      # add
gcmr()  { git commit -m "Remove: $*"; }   # remove
gcmu()  { git commit -m "Update: $*"; }   # update
gcmf()  { git commit -m "Fix: $*"; }      # fix
gcmhf() { git commit -m "Hotfix: $*"; }   # hotfix
gcmrl() { git commit -m "Release: $*"; }  # release
gcmrf() { git commit -m "Refactor: $*"; } # refactor
gcms()  { git commit -m "Commit: $(date +%Y-%m-%d--%H:%M) $*"; }
gcnms() { git commit -n -m "Commit: $(date +%Y-%m-%d--%H:%M) $*"; }

# Rails
#
alias be='bundle exec'
alias dev-restart='overmind restart web worker vite'
alias rce="EDITOR='code --wait' rails credentials:edit"
alias rr='rails runner'
alias rspec='rspec --color --format doc'
alias rst='touch tmp/restart.txt'
alias rdbc='rails dbconsole'
alias rdbm='rails db:migrate'

# OS
#
killport() { kill -9 $(lsof -ti:$*); }
alias flushdnscache='dscacheutil -flushcache'
