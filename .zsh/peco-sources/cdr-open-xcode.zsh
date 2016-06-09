function peco-cdr-and-open-xcode () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir} && open-xcode-project"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr-and-open-xcode
