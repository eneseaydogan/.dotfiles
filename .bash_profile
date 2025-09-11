[ -f ~/.bashrc ] && source ~/.bashrc

if [ -f ~/.config/sway/env ]; then
    source ~/.config/sway/env
    exec sway
fi
