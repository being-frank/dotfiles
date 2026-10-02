# reload! is a priority alias to reload the zsh configuration.
alias reload!='exec zsh'

source "$ZSH_FILES/environment.zsh"


# ---------- Smart directory navigation & lf ----------

# if [[ -f ~/.config/lf/icons ]]; then
#   LF_ICONS=$(cat ~/.config/lf/icons | tr '\n' ':')
#   export LF_ICONS
# fi


# ---------- Completion ----------

# Load completion system
autoload -Uz compinit

# Initialize completion with cached metadata file
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Make completion case-insensitive
# Example: "doc" can complete to "Documents"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # lowercase input matches upper and lower


# ---------- Fuzzy finder ----------

if [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]]; then
  source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
  source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
fi


# ---------- Homebrew ----------

eval "$(/opt/homebrew/bin/brew shellenv)"


# bun
export BUN_INSTALL="$HOME/.bun"

# nodenv
eval "$(~/.nodenv/bin/nodenv init - --no-rehash zsh)"

# rbenv
eval "$(~/.rbenv/bin/rbenv init - --no-rehash zsh)"


# ---------- Modular Config Files ----------

source "$ZSH_FILES/aliases.zsh"
source "$ZSH_FILES/keybindings.zsh"
source "$ZSH_FILES/plugins.zsh"
source "$ZSH_FILES/prompt.zsh"



# ---------- Local Configurations ----------

if [[ -f "$HOME/local.zsh" ]]; then
  source "$HOME/local.zsh"
fi


# Additional completions.
# FPATH=~/.nodenv/completions:"$FPATH"
# FPATH=~/.rbenv/completions:"$FPATH"
# FPATH=~/.grok/completions/zsh:"$FPATH"

# Source $ZSH_FILES/zim.zsh first.
# source $ZSH_FILES/zim.zsh
# [[ -f $HOME/private-aliases.zsh ]] && source $HOME/private-aliases.zsh

# bun completions
# [ -s "/Users/frank/.bun/_bun" ] && source "/Users/frank/.bun/_bun"
