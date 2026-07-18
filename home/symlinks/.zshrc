# Enable Emacs-style keyboard shortcuts.
bindkey -e

# reload! is a priority alias to reload the zsh configuration.
alias reload!='exec zsh'

# Additional completions.
FPATH=~/.nodenv/completions:"$FPATH"
FPATH=~/.rbenv/completions:"$FPATH"
FPATH=~/.grok/completions/zsh:"$FPATH"

# Source $ZSH_FILES/zim.zsh first.
source $ZSH_FILES/zim.zsh
source $ZSH_FILES/aliases.zsh
[[ -f $HOME/private-aliases.zsh ]] && source $HOME/private-aliases.zsh

# shortcuts
export CDPATH="$CDPATH:$HOME/Code"

# bun
export BUN_INSTALL="$HOME/.bun"

# nodenv
eval "$(~/.nodenv/bin/nodenv init - --no-rehash zsh)"

# rbenv
eval "$(~/.rbenv/bin/rbenv init - --no-rehash zsh)"

# bun completions
[ -s "/Users/frank/.bun/_bun" ] && source "/Users/frank/.bun/_bun"
