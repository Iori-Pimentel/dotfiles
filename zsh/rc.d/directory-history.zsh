add-zsh-hook zshaddhistory before-save-history
before-save-history() {
	setopt INC_APPEND_HISTORY

	mkdir --parent ${CURRENT_HISTFILE:h} ${OTHER_HISTFILE:h}
	touch $CURRENT_HISTFILE

	exec {HIST_FD}< $CURRENT_HISTFILE
	<&$HIST_FD > /dev/null

	HISTFILE=$CURRENT_HISTFILE
}

add-zsh-hook preexec after-save-history
after-save-history() {
	# Assume only this process has written to CURRENT_HISTFILE
	<&$HIST_FD >> $OTHER_HISTFILE
	exec {HIST_FD}>&-

	HISTFILE=$GLOBAL_HISTFILE
}

add-zsh-hook precmd start-history-precmd
start-history-precmd() {
	[[ $HISTFILE == '/'* ]] || HISTFILE=${XDG_DATA_HOME}/zsh/history
	[[ $HISTORY_BASE == '/'* ]] || HISTORY_BASE=${XDG_DATA_HOME}/zsh/directory-history
	[[ $HIST_START_LOCAL == false ]] || HIST_START_LOCAL=true
	GLOBAL_HISTFILE=$HISTFILE
	if [[ $HIST_NAME == */* || $HIST_NAME == '' ]]; then
	# We make HIST_NAME really long so that it
	# becomes unlikely to conflict with a directory name
		HIST_NAME=directory-local-history-file.txt
	fi

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
	local PWD_HISTFILE=$HISTORY_BASE$PWD/$HIST_NAME

	fc -P
	fc -p $PWD_HISTFILE
	CURRENT_HISTFILE=$PWD_HISTFILE
	OTHER_HISTFILE=$GLOBAL_HISTFILE

	# <Docs> man zshbuiltins | less +/fc.-p +/one.argument </Docs>
	# We want to preserve HISTFILE
	HISTFILE=$GLOBAL_HISTFILE
}

global-history-list() {
	local PWD_HISTFILE=$HISTORY_BASE$PWD/$HIST_NAME

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
