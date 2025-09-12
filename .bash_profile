[ -f ~/.bashrc ] && source ~/.bashrc

if [ "$(tty)" = "/dev/tty1" ]; then
    [ -f ~/.config/sway/env ] && source ~/.config/sway/env
    exec sway
fi
