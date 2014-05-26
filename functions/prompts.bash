export PS1_BACKUP="$PS1"

short_prompt() {
  export PS1="$PS1_BACKUP\n\[\033[1;33m\]★\[\033[0m\] "
}

default_prompt() {
  export PS1="$PS1_BACKUP"
}
