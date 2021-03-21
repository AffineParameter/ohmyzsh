function __is_root(){
    if [[ $UID == 0 || $EUID == 0 ]]; then
        # root
        echo 124
    else
        echo 023
    fi
}

#
# PROMPT
#
PROMPT_PRIMARY_COLOR='$(__is_root)'
PROMPT_USER_HOST='%B%F{$PROMPT_PRIMARY_COLOR}┌─[%n @ %m]%b'
PROMPT_TIME='%B%F{$PROMPT_PRIMARY_COLOR}(%*)%b'
PROMPT_PATH='%B%F{$PROMPT_PRIMARY_COLOR}└──(∂𝑺≃0) [%5~]%b'
PROMPT_CONDA_SEP='%{$fg_bold[white]%}⇒%{$fg_no_bold[yellow]%}'
PROMPT_SIGN='%{$reset_color%}'


function __conda(){
    echo $CONDA_DEFAULT_ENV
}


function __exit_code(){
    if [ "$?" != "0" ]; then
        LAST_STATUS="%{$fg_bold[red]%}✗%{$reset_color%}"      # Add red if exit code non 0
    else
        LAST_STATUS="%{$fg_bold[green]%}✓%{$reset_color%}"
    fi
    echo ${LAST_STATUS}
}

GIT_PROMPT_INFO='$(git_prompt_info)'
CONDA_PROMPT_INFO='%{$fg_no_bold[yellow]%}$(__conda)'
EXIT_STATUS='$(__exit_code)'

# My current prompt looks like:
# ┌─[user @ host] (hh:mm:ss)
# └──(∂𝑺≃0) [path] ⇒ conda_env ✓
# 
PROMPT="${PROMPT_USER_HOST} ${PROMPT_TIME} ${GIT_PROMPT_INFO}
${PROMPT_PATH} ${PROMPT_CONDA_SEP} ${CONDA_PROMPT_INFO:-~} ${EXIT_STATUS}
${PROMPT_SIGN}"

#
# Plugin Specific
#
ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg_no_bold[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}⚡%{$reset_color%}"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'
