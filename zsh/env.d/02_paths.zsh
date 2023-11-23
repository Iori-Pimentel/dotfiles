# Add custom functions and completions 
fpath=(${ZDOTDIR}/fpath ${fpath})
MANPATH="$PREFIX/share/man:$MANPATH"


# Enable local binaries and man pages 
# I dont use these, can be removed after checking only
path=(${HOME}/.local/bin ${path}) 
# MANPATH="${XDG_DATA_HOME}/man:${MANPATH}"
