function peco-select-git-checkout () {
    local selected_branch=$(git branch | peco)
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    # zle clear-screen
}
zle -N peco-select-git-checkout
