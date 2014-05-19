export PS1_BACKUP="$PS1"

short_prompt() {
  export PS1="$PS1_BACKUP\n> "
}

default_prompt() {
  export PS1="$PS1_BACKUP"
}
