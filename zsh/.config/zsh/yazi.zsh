# yazi related zsh configuration

# auto cd when leaving yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# shortcut for opening yazi
function y_widget () {
	y
	zle reset-prompt
}
zle -N y_widget
bindkey '^y' y_widget # ^y in insert mode
bindkey -M vicmd 'gy' y_widget # gy in command mode
