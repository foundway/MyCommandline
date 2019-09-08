# Git Autocompelte
source ~/git-completion.bash

# Color
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export GREP_OPTIONS='--color=auto'
export PATH=$PATH:/Users/foundway/Library/Android/sdk/platform-tools/
alias ls='ls -GFh'
alias Unity='/Applications/Unity/Unity.app/Contents/MacOS/Unity&'

# Auto Complete
_complete_open() {
        COMPREPLY=()
        local cur="${COMP_WORDS[$COMP_CWORD]}"
        local prev="${COMP_WORDS[COMP_CWORD-1]}"
        [[ "$cur" == -* || "$prev" != '-a' ]] && return
        apps="$(mdfind kMDItemKind==Application -onlyin /Applications -onlyin ~/Applications -onlyin /Developer -onlyin ~/Developer | grep -v '/.*/.*/.*/.*/' | sed -E 's|.*/||g;s|\.app$||g' | uniq)"$'Finder\nArchive Utility\nCharacterPalette\nKeyboardViewer'
        local IFS=$'\n'
        if [[ "${cur:0:1}" = '"' || "${cur:0:1}" = "'" ]]; then
            quote="${cur:0:1}"
            cur="${cur:1}"
        fi
        local found="$(grep -i "^$cur" <<< "$apps")"
        if [[ "$quote" == '"' ]]; then
            found="$(sed "s|^|\"|g;s|$|\"|g" <<< "$found")"
        elif [[ "$quote" == "'" ]]; then
            found="$(sed "s|^|'|g;s|$|'|g" <<< "$found")"
        else
            found="$(sed 's| |\\ |g' <<< "$found")"
        fi
        COMPREPLY=($found)
}
complete -o default -F _complete_open open

