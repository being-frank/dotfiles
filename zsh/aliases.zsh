# Edit aliases
alias aliases='$EDITOR ~/dotfiles/zsh/aliases.zsh'

# Editor alias
alias e='code .'

# Make sudo understand aliases
alias sudo='sudo '

# Directories
#
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Git
#
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gce='git commit --allow-empty -m'
alias gcnm='git commit -n -m'
alias gco='git checkout'
alias gdf='git diff --color | diff-so-fancy'
alias gl='git lg'
alias gpl='git pull --prune'
alias gps='git push -u origin HEAD'
alias gs='git status -sb'
alias gst='git stash'
alias gstp='git stash pop'
alias grmerged='git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|main|develop)\s*$)" | command xargs -n 1 git branch -d'
alias gg='gaa && gcms'

# OS
#
killport() { kill -9 $(lsof -ti:$*); }
alias flushdnscache='dscacheutil -flushcache'
