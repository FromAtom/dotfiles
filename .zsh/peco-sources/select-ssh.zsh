function peco-select-ssh() {
  local selected_host=$(awk '
    tolower($1)=="host" {
      for (i=2; i<=NF; i++) {
        if ($i !~ "[*?]") {
          print $i
        }
      }
    }
    ' ~/.ssh/config | sort | peco --query "$LBUFFER")
    if [ -n "$selected_host" ]; then
      BUFFER="ssh ${selected_host}"
      zle accept-line
    fi
    zle clear-screen
}
zle -N peco-select-ssh
