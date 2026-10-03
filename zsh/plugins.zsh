# Zplug: https://github.com/zplug/zplug

export ZPLUG_HOME="$HOMEBREW_PREFIX/opt/zplug"

source "$ZPLUG_HOME/init.zsh"


zplug "zdharma-continuum/fast-syntax-highlighting", as:plugin
zplug "zsh-users/zsh-autosuggestions", as:plugin

if ! zplug check; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load
