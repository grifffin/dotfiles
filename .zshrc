# pywal
(cat ~/.cache/wal/sequences &)

# Zplug
source ~/.zplug/init.zsh
zplug "mafredri/zsh-async", from:github
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme
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

source ~/.purepower

# must be loaded before other keybindings
bindkey -v #vim mode

# auto cd
setopt auto_cd

# keep the clock ticking
TRAPALRM() {
    zle reset-prompt
}
TMOUT=1

# Enable tab completion of flags
source $(dirname $(gem which colorls))/tab_complete.sh

# Move standard ls
alias ols="/bin/ls"
# Base formats
alias ls="exa"           # short, multi-line
alias la="exa -a"
alias lla="exa -la"          # list w/ info

alias prettyjson='python -m json.tool'
