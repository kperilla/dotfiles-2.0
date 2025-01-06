autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='╭─ %F{white}%*%f %F{yellow}%n@%M%f %F{green}%~%f %F{cyan}${vcs_info_msg_0_}%f${NEWLINE}╰── $ '
