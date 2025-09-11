#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export GPG_TTY=$(tty)
export PATH="$HOME/.local/bin:$PATH"
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#121212,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4 \
    --highlight-line --info=inline-right --ansi --layout=reverse"
PS1='[\u@\h \W]\$ '
