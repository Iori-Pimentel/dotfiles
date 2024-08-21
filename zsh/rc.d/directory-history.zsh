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
	set-history-list local
}

global-history-list() {
	set-history-list global
}

set-history-list() {
	HIST_STATE=${1}

	if [[ $HIST_STATE == local ]]; then
		CURRENT_HISTFILE=$HISTORY_BASE$PWD/$HIST_NAME
		OTHER_HISTFILE=$GLOBAL_HISTFILE
	elif [[ $HIST_STATE == global ]]; then
		CURRENT_HISTFILE=$GLOBAL_HISTFILE
		OTHER_HISTFILE=$HISTORY_BASE$PWD/$HIST_NAME
	else
		return 1
	fi

	[[ -d ${CURRENT_HISTFILE:h} ]] || mkdir --parent ${CURRENT_HISTFILE:h}
	[[ -f ${CURRENT_HISTFILE} ]] || touch ${CURRENT_HISTFILE}

	[[ -d ${OTHER_HISTFILE:h} ]] || mkdir --parent ${OTHER_HISTFILE:h}
	[[ -f ${OTHER_HISTFILE} ]] || touch ${OTHER_HISTFILE}

	local stat
	fc -P
	fc -p $CURRENT_HISTFILE
	stat=$?

	[[ $PRESERVE_HISTFILE_PARAM == true ]] && HISTFILE=$GLOBAL_HISTFILE

	return $stat
}

zle -N toggle-history-list
toggle-history-list() {
	if [[ $HIST_STATE == global ]]; then
		local-history-list
	elif [[ $HIST_STATE == local ]]; then
		global-history-list
	else
		return 1
	fi
}

custom-fc() {
	local FC_ARGS=(
		-l # list
		-r # reverse
		1 # history starting from 1
	)

	local SET_COLOR
	local RESET_COLOR=$'\e[m'
	if [[ $HIST_STATE == global ]]
	then SET_COLOR=$'\e[33m' # Yellow
	elif [[ $HIST_STATE == local ]]
	then SET_COLOR=$'\e[35m' # Magenta
	else SET_COLOR=$'\e[2;3m' # dim and italic
	fi

	setopt LOCAL_OPTIONS no_KSH_ARRAYS
	local SED_ARGS=(
		# Convert first column from right to left align
		--expression='s/^[[:space:]]*//'
		# Set styles for first column
		--expression='s/^[0-9]*/'${SET_COLOR}'&'${HIST_STATE[1]}${RESET_COLOR}'/'
	)

	local stat
	fc "${FC_ARGS[@]}" | sed "${SED_ARGS[@]}"
	stat=${pipestatus[-2]}

	if [[ $1 == all && $HIST_STATE == local ]]; then
		( fc -p && global-history-list && custom-fc )
		stat=$?
	fi

	return $stat
}

fetch-history-line() {
# Note that `fc -pa` is not enough to preverve
# directory-history parameters so we run in a subshell
(
	local HISTORY_NUM=$1

	if [[ ${HISTORY_NUM[-1]} == [l] && $HIST_STATE == global ]] ||
	   [[ ${HISTORY_NUM[-1]} == [g] && $HIST_STATE == local ]]
	then fc -p && toggle-history-list
	fi

	HISTORY_NUM=${HISTORY_NUM%[lg]}
	printf '%s\0' "${history[$HISTORY_NUM]}"

	[[ -n ${history[$HISTORY_NUM]} ]]
)
}
