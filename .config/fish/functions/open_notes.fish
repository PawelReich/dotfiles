function open_notes --description "Opens notes"
    for i in (seq 0 6)
        set -l name (date -d"-$i days" +%d_%m_%y)
        set -f -a files "$name.md"
    end
    mkdir -p "$HOME/notes" 
    pushd "$HOME/notes"
    nvim $files
    popd
end
