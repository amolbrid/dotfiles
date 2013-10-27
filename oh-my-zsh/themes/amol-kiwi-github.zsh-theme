ZSH_THEME_RVM_PROMPT_PREFIX=" "
ZSH_THEME_RVM_PROMPT_SUFFIX=" "

PROMPT='%* |%{$fg_bold[cyan]%} %2~%{$reset_color%}$(git_prompt_info) |%{$fg_bold[blue]%}$(rvm_prompt_info)%{$reset_color%}
 '

# git theming
ZSH_THEME_GIT_PROMPT_PREFIX=" | "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}✗%{$reset_color%}"

