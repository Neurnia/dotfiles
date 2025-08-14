# shortcut for opening lazygit
function lazygit_widget () {
	lazygit
	zle reset-prompt
}
zle -N lazygit_widget
bindkey '^g' lazygit_widget # insert mode
bindkey -M vicmd 'gi' lazygit_widget # command mode
