#!/usr/bin/env bash
set -e

echo "[*] Updating system..."
sudo pacman -Syu --noconfirm

echo "[*] Installing paru..."
if ! command -v paru &> /dev/null; then
    git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin
    cd /tmp/paru-bin
    makepkg -si --noconfirm
    cd -
fi

echo "[*] Installing packages from packages.txt..."
paru -S --needed --noconfirm $(cat packages.txt)

echo "[*] Cloning repos into bootstrap/..."
bootstrap_dir="$HOME/Downloads/"
mkdir -p "$bootstrap_dir"

while IFS= read -r repo; do
    # Skip empty lines
    if [[ -z "$repo" ]]; then
        continue
    fi

    name=$(basename "$repo" .git)
    dir="$bootstrap_dir/$name"

    if [[ -d "$dir" ]]; then
        echo "  [=] Updating $name"
        git -C "$dir" pull
    else
        echo "  [+] Cloning $repo"
        git clone "$repo" "$dir"
    fi

    # Special handling for neovim
    if [[ "$name" == "neovim" ]]; then
        echo "  [*] Building neovim (stable)..."
        cd "$dir"
        git checkout stable
        make CMAKE_BUILD_TYPE=RelWithDebInfo
        sudo make install
        cd - > /dev/null
    fi

done < repos.txt


echo "[*] Done!"
