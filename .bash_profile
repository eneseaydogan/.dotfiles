[ -f ~/.bashrc ] && source ~/.bashrc

if [ -f ~/.config/sway/env ] && [ -t 1 ]; then
    source ~/.config/sway/env
    exec sway
fi
