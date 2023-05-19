# Zplug
source ~/.zplug/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "chrissicool/zsh-256color"
zplug "djui/alias-tips"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# must be loaded before other keybindings
bindkey -v #vim mode

bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# auto cd
setopt auto_cd

alias ':q'='exit'
alias reload='. ~/.zshrc'
alias ols="/bin/ls" # move standard ls
alias ls="exa"      # short, multi-line
alias la="exa -a"
alias ll="exa -l"
alias lla="exa -la" # list w/ info
alias prettyjson='python -m json.tool'
alias vi='nvim'
alias gits='git status'

eval "$(starship init zsh)"

