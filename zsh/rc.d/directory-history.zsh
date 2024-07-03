add-zsh-hook zshaddhistory mark-history-line
mark-history-line() {
	local PWD_HISTFILE=$HISTORY_BASE$PWD/history

	# <Docs> man zshmisc | less +/fc.-p </Docs>
	fc -p $PWD_HISTFILE.temp
	setopt INC_APPEND_HISTORY

	# This is necessary since `fc -p` does not
	# create the directories automatically
	mkdir --parent ${PWD_HISTFILE:h}
}

add-zsh-hook preexec save-history-line
save-history-line() {
	local PWD_HISTFILE=$HISTORY_BASE$PWD/history
	[[ -s $PWD_HISTFILE.temp ]] || return

	cat $PWD_HISTFILE.temp >> $HISTFILE
	cat $PWD_HISTFILE.temp >> $PWD_HISTFILE

	# Adds history line back to internal history list,
	# Counteracting the `fc -p` in mark-history-line
	# that prevented it from being added.
	# 
	# This is better than using `print -sr -- $1`
	# since `fc -p` unsets $1 for preexec hooks
	# and using it in zshaddhistory hooks complicates
	# if HISTORY_IGNORE or any HIST*IGNORE* options is set
	fc -R $PWD_HISTFILE.temp

	rm $PWD_HISTFILE.temp
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

	fc -p $PWD_HISTFILE
	CURRENT_HISTFILE=$PWD_HISTFILE

	# <Docs> man zshbuiltins | less +/fc.-p +/one.argument </Docs>
	# We want to preserve HISTFILE
	HISTFILE=$GLOBAL_HISTFILE
}

global-history-list() {
	fc -p $GLOBAL_HISTFILE
	CURRENT_HISTFILE=$GLOBAL_HISTFILE
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
