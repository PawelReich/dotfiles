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

    alias icat='kitten icat'

    abbr -a uvv 'uv venv -q --allow-existing --seed; source .venv/bin/activate.fish'
    abbr -a uvd deactivate
    alias pip="uv pip"

    set -gx EDITOR nvim

    set FZF_DEFAULT_OPTS "--color bg:#080808 \
  --color bg+:#262626 \
  --color border:#2e2e2e \
  --color fg:#b2b2b2 \
  --color fg+:#e4e4e4 \
  --color gutter:#262626 \
  --color header:#80a0ff \
  --color hl+:#f09479 \
  --color hl:#f09479 \
  --color info:#cfcfb0 \
  --color marker:#f09479 \
  --color pointer:#ff5189 \
  --color prompt:#80a0ff \
  --color spinner:#36c692"

end
