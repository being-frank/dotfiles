# Disables automatic selection of the first completion
# option, allowing menu-style completion instead.
unsetopt menu_complete

# Disables flow control (Ctrl+S/Ctrl+Q) to prevent
# terminal input/output pausing.
unsetopt flowcontrol

# Enables menu completion automatically after the
# second tab press, showing a list of options.
setopt auto_menu

# Allows completion to work when the cursor is inside
# a word, modifying only part of it.
setopt complete_in_word

# Moves the cursor to the end of the completed word
# after completion.
setopt always_to_end
