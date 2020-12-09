# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# must be loaded before other keybindings
bindkey -v #vim mode

bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

# auto cd
setopt auto_cd

# keep the clock ticking
TRAPALRM() {
    zle reset-prompt
}
TMOUT=1

# Move standard ls
alias ols="/bin/ls"
# Base formats
alias ls="exa"           # short, multi-line
alias la="exa -a"
alias lla="exa -la"          # list w/ info

alias prettyjson='python -m json.tool'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# reset pywal scheme
wal -t -s -R
