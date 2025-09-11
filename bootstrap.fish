#!/usr/bin/env fish
set -e

echo "[*] Updating system..."
sudo pacman -Syu --noconfirm

echo "[*] Installing paru..."
if not type -q paru
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si --noconfirm
    cd -
end

echo "[*] Installing packages from packages.txt..."
paru -S --needed --noconfirm (cat packages.txt)

echo "[*] Cloning repos into bootstrap/..."
set bootstrap_dir "$HOME/.dotfiles/bootstrap"
mkdir -p $bootstrap_dir

for repo in (cat repos.txt)
    if test -z "$repo"
        continue
    end
    set name (basename $repo .git)
    set dir "$bootstrap_dir/$name"

    if test -d $dir
        echo "  [=] Updating $name"
        git -C $dir pull
    else
        echo "  [+] Cloning $repo"
        git clone $repo $dir
    end
end

echo "[*] Linking configs with stow..."
cd (dirname (status -f))  # go to .dotfiles repo root
stow .

echo "[*] Done!"
