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
    if command -q keychain
        set -lx SHELL (which fish)
        keychain --eval git-gh -q | source
    end

    function ze
        set personal_dirs (fd --type d --max-depth 2 --min-depth 2 . $HOME/personal | \
                   string replace "$HOME/personal/" "" | \
                   string replace -r '/$' '')

        set dotfiles_dirs
        if test -d $HOME/.dotfiles
            set dotfiles_dirs ".dotfiles"
        end

        set dir (printf '%s\n' $personal_dirs $dotfiles_dirs | \
         fzf --prompt "Select directory: ")

        if string match -q ".dotfiles" $dir
            set full_path $HOME/.dotfiles
            set session_name dotfiles
        else
            set full_path $HOME/personal/$dir
            set session_name (string replace "/" "-" $dir)
        end

        if not zellij list-sessions | string match -q "*$session_name*"
            echo "Creating session: $session_name"
            z $full_path
            zellij --session $session_name
        else
            echo "Attaching to session: $session_name"
            z $full_path
            zellij attach $session_name
        end
    end

    bind \cp history-search-backward
    bind \cn history-search-forward
end
