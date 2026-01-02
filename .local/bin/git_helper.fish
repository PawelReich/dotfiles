#!/usr/bin/fish

set command $argv[1]
set file (realpath $argv[2])
set line $argv[3]

function open_copy_or_print
    # Use `ttu-copy` if available to pass clipboard through SSH
    if command -q tty-copy
        tty-copy "$argv[1]"
    end

    if test -n "$DISPLAY" -o -n "$DISPLAY"
        # Fallback to `wl-copy` if not available
        if not command -q tty-copy
            wl-copy "$argv[1]"
        end
        xdg-open "$argv[1]"
    else
        echo "$argv[1]"
    end
end

# Enter the file repository
cd (dirname $file)

# Get and cd into repository root
set repo_dir (git rev-parse --show-toplevel)
cd $repo_dir

set giturl (git remote get-url origin | string replace '.git' '')
set domain (echo $giturl | string replace -m 1 'git@' '' | string replace -m 1 'https://' '' | cut -d '/' -f 1 | cut -d ':' -f 1)
set commit_sha (git blame --root -L$line,$line -- $file | cut -d' ' -f 1)
if string match -q "*github.com*" "$domain"
    set is_github "true"
else
    set is_github "false"
end

# Convert ssh to http url
if not string match -q "http*" "$giturl"
    set giturl (echo "$giturl" | string replace -m 1 ':' '/' | string replace 'git@' 'https://')
end

switch $command
    case goto-issue
        set commit_msg (git log --pretty=format:"%s" -n 1 $commit_sha)

        # Get first #<num> id
        set issueid (echo $commit_msg | string match -r '#(\d+)' -m 1 -g)
        if test "$issueid" = ""
            echo "Issue id not found for commit: $commit_msg"
        else
            if test "$is_github" = "true"
                # GitHub format
                open_copy_or_print "$giturl/issues/$issueid"
            else
                # Default to domain/issues/id
                open_copy_or_print "https://$domain/issues/$issueid"
            end
        end

    case copy-url
        set reposiory (git remote get-url origin | cut -d ':' -f 2 | cut -d '.' -f 1)
        set commit (git rev-parse HEAD)
        if test "$commit" = ""
            set commit "master"
        end
        set relative_file (echo $file | string replace $repo_dir "")

        if test "$is_github" = "true"
            # GitHub format
            open_copy_or_print "$giturl/blob/$commit$relative_file#L$line"
        else
            # Gitlab format
            open_copy_or_print "https://$domain/git/repositories/$reposiory/blob/$commit$relative_file#L$line"
        end
end
