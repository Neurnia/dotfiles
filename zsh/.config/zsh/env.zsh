# environmental variables
export LANG=en_US.UTF-8
export EDITOR=nvim

# paths
export PATH="$PATH:/snap/bin" # snap


# --------------------
# PACKAGE MANAGERS ENV
# --------------------

# homebrew (linuxbrew) env
if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# fnm env
if [[ -x "$HOME/.local/share/fnm/fnm" ]]; then
  eval "$($HOME/.local/share/fnm/fnm env)"
fi
