if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

# Set env variable (export)
set -x PROJECTS /mnt/Projects

# Alias
alias launcher="conda activate launcher; python /home/agorgec/workspace/proj_launcher/python3.11libs/main.py"

# Example autostart for a new tmux session
if status is-interactive
    if not set -q TMUX
        tmux new-session -d -s main
        # Attaches to the session
        tmux attach-session -t main
    end
end

function houdini_env
    bash -c 'cd /opt/hfs21.0.559 && source houdini_setup && env' | while read -l line
        # If the line is a message (no '='), print it
        if not string match -q '*=*' -- $line
            echo $line
            continue
        end

        # Split only on the FIRST '='
        set -l name (string split -m 1 "=" $line)[1]
        set -l value (string split -m 1 "=" $line)[2]

        # Skip read-only/unwanted vars in fish
        if contains $name PWD SHLVL _ OLDPWD
            continue
        end

        if test -z "$name"
            continue
        end

        # Export into Fish
        set -x $name $value
    end
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/agorgec/miniconda3/bin/conda
    eval /home/agorgec/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/home/agorgec/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/agorgec/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /home/agorgec/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<
