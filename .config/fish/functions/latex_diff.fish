function latex_diff --description "Generates LaTeX diff by latest tag" --argument-names file
    if test -d $file
        set file PracaInz
        echo "No main file provided, defaulting to $file"
    end

    set latest_tag (git describe --tags --abbrev=0)
    set latest_tag_sha (git rev-list -n 1 "$latest_tag")
    echo "Diffing from HEAD to $latest_tag ($latest_tag_sha)"
    latexdiff-vc "$file.tex" --git -r $latest_tag_sha --pdf --flatten

    set target_directory diff-$latest_tag_sha
    rm -rf $target_directory
    mkdir $target_directory
    mv $file-* $target_directory
    xdg-open $target_directory/$file-diff$latest_tag_sha.pdf
end
