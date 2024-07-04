add-zsh-hook zshaddhistory mark-history-line
mark-history-line() {
	local PWD_HISTFILE=$HISTORY_BASE$PWD/history

	mkdir --parent ${PWD_HISTFILE:h}

	cat $CURRENT_HISTFILE > $CURRENT_HISTFILE.temp
	HISTFILE=$CURRENT_HISTFILE

	setopt INC_APPEND_HISTORY
}

add-zsh-hook preexec save-history-line
save-history-line() {
	local PWD_HISTFILE=$HISTORY_BASE$PWD/history
	[[ -s $CURRENT_HISTFILE.temp ]] || return

	comm -13 $CURRENT_HISTFILE.temp $CURRENT_HISTFILE >> $OTHER_HISTFILE

	rm $CURRENT_HISTFILE.temp

	# We want to preserve HISTFILE
	HISTFILE=$GLOBAL_HISTFILE
}

add-zsh-hook precmd start-history-precmd
start-history-precmd() {
	[[ $HISTORY_BASE == '/'* ]] || HISTORY_BASE=${XDG_DATA_HOME}/zsh/directory-history
	[[ $HIST_START_LOCAL == false ]] || HIST_START_LOCAL=true
	GLOBAL_HISTFILE=$HISTFILE

	if [[ $HIST_START_LOCAL == true ]]; then
		local-history-list
		add-zsh-hook chpwd local-history-list
	else
		global-history-list
		add-zsh-hook chpwd global-history-list
	fi

	# Remove this function from precmd_functions
	# since we only want it be called once at startup
	precmd_functions=("${precmd_functions[@]:#start-history-precmd}")
}

local-history-list() {
	local PWD_HISTFILE=$HISTORY_BASE$PWD/history

	fc -P
	fc -p $PWD_HISTFILE
	CURRENT_HISTFILE=$PWD_HISTFILE
	OTHER_HISTFILE=$GLOBAL_HISTFILE

	# <Docs> man zshbuiltins | less +/fc.-p +/one.argument </Docs>
	# We want to preserve HISTFILE
	HISTFILE=$GLOBAL_HISTFILE
}

global-history-list() {
	local PWD_HISTFILE=$HISTORY_BASE$PWD/history

	fc -P
	fc -p $GLOBAL_HISTFILE
	CURRENT_HISTFILE=$GLOBAL_HISTFILE
	OTHER_HISTFILE=$PWD_HISTFILE
}

bindkey '^G' toggle-history-list
zle -N toggle-history-list
toggle-history-list() {
	if [[ $CURRENT_HISTFILE == $GLOBAL_HISTFILE ]]; then
		local-history-list
		zle -M 'Using local history'
	else
		global-history-list
		zle -M 'Using global history'
	fi
}
