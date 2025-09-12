if status is-interactive
    # Path
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.local/share/nvim/mason/bin
    fish_add_path ~/go/bin

    set -g fish_history_size 10000
    set -g fish_greeting ""
    set -gx EDITOR nvim
    set -g hydro_multiline false

    alias eza='eza --icons=always --color=always --git -h'
    alias l='eza -al --sort=type'
    alias ld='eza -lD'
    alias lS='eza -al --sort=size'
    alias lm='eza -al --sort=modified'
    alias lt='eza -l --tree'
    alias vim='nvim'
    alias lg='lazygit'
    alias rm='rm -r -i'

    function v
        if test (count $argv) -gt 0
            nvim $argv
        else
            set file (fd -H -t f --color=always --strip-cwd-prefix=always | \
            fzf --height 30% --ansi --preview 'bat --style=numbers --color=always --line-range :200 {}')
            if test -n "$file"
                nvim "$file"
            end
        end
    end

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    fzf --fish | source
    zoxide init fish | source
    # if command -q keychain
    #     set -lx SHELL (which fish)
    #     keychain --eval git-gh 30F8846CFEC0BA35 -q | source
    # end

    bind \cp history-search-backward
    bind \cn history-search-forward
end
