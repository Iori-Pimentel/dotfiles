add-zsh-hook zshaddhistory mark-history-line
mark-history-line() {
	[[ ${PWD:t} == $HIST_NAME ]] && return

	mkdir --parent ${CURRENT_HISTFILE:h}
	HISTFILE=$CURRENT_HISTFILE

	setopt INC_APPEND_HISTORY
	local CP_ARGS=(
		# treat DEST as normal file
		--no-target-directory
		# Skip if the .old file is still there.
		# Which meant it has not been processed.
		--update=none
		$CURRENT_HISTFILE
		$CURRENT_HISTFILE.old
	)
	touch $CURRENT_HISTFILE
	cp "${CP_ARGS[@]}"

	# <Docs> man zshmisc | less +/zshaddhistory +/returns.status </Docs>
	return 0
}

add-zsh-hook preexec save-history-line
save-history-line() {
	[[ ${PWD:t} == $HIST_NAME ]] && return

	if [[ -f $CURRENT_HISTFILE.old && -f $CURRENT_HISTFILE ]]; then
		local COMM_ARGS=(
			-1 -3 # output lines unique to CURRENT_HISTFILE
			$CURRENT_HISTFILE.old
			$CURRENT_HISTFILE
		)
		mkdir --parent ${OTHER_HISTFILE:h}
		comm "${COMM_ARGS[@]}" >> $OTHER_HISTFILE
		rm $CURRENT_HISTFILE.old
	fi

	# We want to preserve HISTFILE
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
