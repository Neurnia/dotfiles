# zsh configuration

# zim initialization
# keep this line at the beginning
source ~/.config/zsh/zim.zsh

# --------------
# BASIC SETTINGS
# --------------

setopt HIST_IGNORE_ALL_DUPS # remove duplicated history commands
setopt CORRECT # prompt for spelling correction of commands

# customize spelling correction prompt
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
# remove path separator from wordchars
WORDCHARS=${WORDCHARS//[\/]}

# set vim keys
source ~/.config/zsh/vi.zsh
# environmental variables
source ~/.config/zsh/env.zsh


# -----------------------------
# ZIM & GENERAL MODULE SETTINGS
# -----------------------------

# custom terminal title format using prompt expansion escape sequences
zstyle ':zim:termtitle' format '%1~'

# ---------------------
# APP SPECIFIC SETTINGS
# ---------------------

source ~/.config/zsh/fzf.zsh
source ~/.config/zsh/yazi.zsh
source ~/.config/zsh/lazygit.zsh

