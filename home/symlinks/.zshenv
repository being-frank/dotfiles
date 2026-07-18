# ---------- XDG ----------
# Centralise config, cache and data locations
#
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"


# ---------- Editor ----------
# Sets the default editor
#
export EDITOR="code --wait"

# ---------- Misc. ----------
#
export GREP_COLOR="1;36;40"
export LANG=en_US.UTF-8
export LC_ALL=$LANG
export LC_CTYPE=$LANG
export ZSH_FILES="$HOME/dotfiles/zsh"

# ---------- Path ----------
# Add additional paths to $PATH
#
export PATH="./bin:\
$BUN_INSTALL/bin:\
$HOME/.local/bin:\
$PATH"
