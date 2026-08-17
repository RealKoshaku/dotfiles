#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Installation des dotfiles..."

# Installer Oh My Zsh si nécessaire
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installation de Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Installer les plugins ZSH
echo "🔌 Installation des plugins ZSH..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

# Copier shortcuts.zsh (pas de symlink pour éviter les soucis)
cp "$DOTFILES_DIR/.oh-my-zsh/custom/shortcuts.zsh" "$HOME/.oh-my-zsh/custom/shortcuts.zsh"

# Installer zoxide si nécessaire
if ! command -v zoxide &> /dev/null; then
    echo "📦 Installation de zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

# Installer oh-my-posh si nécessaire
if ! command -v oh-my-posh &> /dev/null; then
    if command -v brew &> /dev/null; then
        echo "📦 Installation de oh-my-posh via brew..."
        brew install oh-my-posh
    elif [ "$(uname)" = "Linux" ]; then
        echo "📦 Installation de oh-my-posh..."
        curl -s https://ohmyposh.dev/install.sh | bash -s
    fi
fi

# Créer les symlinks
echo "🔗 Création des symlinks..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# .zshenv: on ne symlink pas, on fusionne (pour ne pas casser cargo env existant)
if [ ! -f "$HOME/.zshenv" ]; then
    cp "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
else
    if ! grep -q "cargo/env" "$HOME/.zshenv" 2>/dev/null; then
        echo '. "$HOME/.cargo/env"' >> "$HOME/.zshenv"
    fi
fi

echo "✅ Terminé ! Relance ton shell ou exécute : source ~/.zshrc"
