#!/usr/bin/env bash

PREFIX="$HOME/.password-store"
SSH_DIR="$PREFIX/SSH"

while read -r key_file; do
    relative_path="${key_file#"$PREFIX/"}"
    pass_path="${relative_path%.gpg}"
    
    pass show "$pass_path" | ssh-add -

done < <(find "$SSH_DIR" -type f -name "*.gpg")

notify-send "load_ssh_keys" "Keys successfully loaded."
