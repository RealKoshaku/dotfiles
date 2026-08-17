export EDITOR="nvim"
export VISUAL="nvim"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
	git
	sudo
	copypath
	colored-man-pages
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# PATH - macOS (Homebrew)
if [ -d "/opt/homebrew" ]; then
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    export PATH="/opt/homebrew/opt/curl/bin:$PATH"
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi

# PATH - Linux
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Emacs
[ -d "$HOME/.config/emacs/bin" ] && export PATH="$HOME/.config/emacs/bin:$PATH"

# Kitty
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"

# Completions
fpath+=~/.zfunc; autoload -Uz compinit; compinit

# Oh My Posh
if command -v oh-my-posh &> /dev/null; then
    if command -v brew &> /dev/null; then
        eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/negligible.omp.json)"
    elif [ -f "$HOME/.local/share/oh-my-posh/themes/negligible.omp.json" ]; then
        eval "$(oh-my-posh init zsh --config $HOME/.local/share/oh-my-posh/themes/negligible.omp.json)"
    fi
fi

# Zoxide
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"
