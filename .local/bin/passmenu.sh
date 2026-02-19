#!/usr/bin/env bash
shopt -s nullglob globstar

prefix="$HOME/.password-store"

password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | tofi --prompt-text="Search Password: ")

[[ -n $password ]] || exit

pass show -c "$password" 2>/dev/null
