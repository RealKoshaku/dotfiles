export THEMAC="koshaku@100.94.31.7"

# Zoxide
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

# Aliases (uniquement si les commandes existent)
command -v eza &> /dev/null && alias ls="eza --icons"
command -v eza &> /dev/null && alias ll="eza -l --icons"
command -v eza &> /dev/null && alias la="eza -la --icons"
command -v bat &> /dev/null && alias cat="bat"

alias connect_themacintosh="ssh koshaku@100.94.31.7"
alias python=python3
