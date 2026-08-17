#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Installation des dotfiles..."

# Installer Oh My Zsh si nécessaire
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installation de Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Créer les symlinks
echo "🔗 Création des symlinks..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES_DIR/.oh-my-zsh/custom/shortcuts.zsh" "$HOME/.oh-my-zsh/custom/shortcuts.zsh"
ln -sf "$DOTFILES_DIR/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
ln -sf "$DOTFILES_DIR/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

echo "✅ Terminé ! Relance ton shell ou exécute : source ~/.zshrc"
