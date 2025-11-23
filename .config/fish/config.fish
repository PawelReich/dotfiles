if status is-interactive
    # Commands to run in interactive sessions can go here

    alias ls='eza --color=always --group-directories-first --icons'
    alias ll='eza -la --icons --octal-permissions --group-directories-first'
    alias l='eza -bGF --header --git --color=always --group-directories-first --icons'
    alias llm='eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons' 
    alias la='eza --long --all --group --group-directories-first'
    alias lx='eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons'

    alias lt='eza --tree --level=2 --color=always --group-directories-first --icons'
    alias l.="eza -a | grep -E '^\.'"

    alias lg='lazygit'

    alias clip="xsel --clipboard"
    abbr -a fish-reload-config 'source ~/.config/fish/**/*.fish'

    set -gx EDITOR nvim

end
