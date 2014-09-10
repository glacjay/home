local ret_status="%(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})%?%{$reset_color%}"
local prompt_char="%{$fg[white]%}%(!.#.%%)%{$reset_color%}"
PROMPT=$'%{$fg_bold[blue]%}%n@%m $(git_prompt_info)$(hg_prompt_info) %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%}\
[${ret_status}]%{$fg_bold[blue]%} ${prompt_char}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
