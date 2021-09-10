get_git_dirty() {
  git diff --quiet || echo '*'
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats \
    '%F{5}%F{5}[%F{cyan}%b%F{3}|%F{1}%a%c%u%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}%F{5}[%F{cyan}%b%c%u%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn

theme_precmd () {
    vcs_info
}

setopt prompt_subst
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="white"; fi
PROMPT='%{$fg[$NCOLOR]%}%B%n%b%{$reset_color%}:%{$fg[magenta]%}%B%c/%b %{$reset_color%}${vcs_info_msg_0_}%{$reset_color%}'
RPROMPT='[%*]'

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd
