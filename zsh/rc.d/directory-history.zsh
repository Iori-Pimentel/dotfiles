autoload add-zsh-hook

add-zsh-hook zshaddhistory before-save-history
before-save-history() {
	# If SHARE_HISTORY option is set, using CURRENT_HISTFILE
	# is needed so that the appropriate history is imported
	HISTFILE=$CURRENT_HISTFILE
	setopt INC_APPEND_HISTORY

	{ exec {HIST_FD}< $CURRENT_HISTFILE } 2>/dev/null || return
	sysseek -u $HIST_FD -w end 0
}

add-zsh-hook preexec after-save-history
after-save-history() {
	[[ $PRESERVE_HISTFILE_PARAM == true ]] && HISTFILE=$GLOBAL_HISTFILE

	(( $HIST_FD )) || return
	cat <&$HIST_FD >> $OTHER_HISTFILE &!

	exec {HIST_FD}>&-
	unset HIST_FD
}

add-zsh-hook precmd start-history-precmd
start-history-precmd() {
	zmodload zsh/system 2>/dev/null # For sysseek

	[[ $HISTFILE == '/'* ]] || HISTFILE=${XDG_DATA_HOME}/zsh/history
	[[ $HISTORY_BASE == '/'* ]] || HISTORY_BASE=${XDG_DATA_HOME}/zsh/directory-history
	[[ $HIST_START_LOCAL == false ]] || HIST_START_LOCAL=true
	[[ $PRESERVE_HISTFILE_PARAM == false ]] || PRESERVE_HISTFILE_PARAM=true
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
	add-zsh-hook -d precmd start-history-precmd
}

local-history-list() {
	CURRENT_HISTFILE=$HISTORY_BASE$PWD/$HIST_NAME
	OTHER_HISTFILE=$GLOBAL_HISTFILE

	set-history-list
}

global-history-list() {
	CURRENT_HISTFILE=$GLOBAL_HISTFILE
	OTHER_HISTFILE=$HISTORY_BASE$PWD/$HIST_NAME

	set-history-list
}

set-history-list() {
	[[ -d ${CURRENT_HISTFILE:h} ]] || mkdir --parent ${CURRENT_HISTFILE:h}
	[[ -f ${CURRENT_HISTFILE} ]] || touch ${CURRENT_HISTFILE}

	[[ -d ${OTHER_HISTFILE:h} ]] || mkdir --parent ${OTHER_HISTFILE:h}
	[[ -f ${OTHER_HISTFILE} ]] || touch ${OTHER_HISTFILE}

	fc -P
	fc -p $CURRENT_HISTFILE
	stat=$?

	[[ $PRESERVE_HISTFILE_PARAM == true ]] && HISTFILE=$GLOBAL_HISTFILE

	return $stat
}

zle -N toggle-history-list
toggle-history-list() {
	if [[ $CURRENT_HISTFILE == $GLOBAL_HISTFILE ]]; then
		local-history-list
	else
		global-history-list
	fi
}
