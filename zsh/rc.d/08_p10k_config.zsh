# Custom configuration for p10k prompt.
# Also see: 07_p10k.zsh (Generated using `p10k configure`)

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
	os_icon dir per_directory_history vcs status
	newline prompt_char
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

POWERLEVEL9K_DIR_MAX_LENGTH=30
# allows shortening current directory
POWERLEVEL9K_SHORTEN_DIR_LENGTH=0

POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_OK_PIPE=true
POWERLEVEL9K_STATUS_ERROR=true
# Turns off status icons
typeset -m 'POWERLEVEL9K_STATUS_*_VISUAL_IDENTIFIER_EXPANSION'=
