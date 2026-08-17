#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Installation des dotfiles..."

# Installer Oh My Zsh si nécessaire
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installation de Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Supprimer les anciens plugins s'ils existent mais sont cassés
rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

# Installer les plugins ZSH via git clone
echo "🔌 Installation des plugins ZSH..."
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

# Copier shortcuts.zsh
cp "$DOTFILES_DIR/.oh-my-zsh/custom/shortcuts.zsh" "$HOME/.oh-my-zsh/custom/shortcuts.zsh"

# Réécrire .zshenv (ne pas casser si cargo n'existe pas)
echo "📝 Configuration de .zshenv..."
cat > "$HOME/.zshenv" << 'EOF'
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
EOF

# Installer zoxide si nécessaire
if ! command -v zoxide &> /dev/null; then
    echo "📦 Installation de zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

# Installer oh-my-posh si nécessaire
if ! command -v oh-my-posh &> /dev/null; then
    echo "📦 Installation de oh-my-posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

# Créer les symlinks
echo "🔗 Création des symlinks..."
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo "✅ Terminé ! Relance : exec zsh"
