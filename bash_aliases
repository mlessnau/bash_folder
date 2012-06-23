# directory listing
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls --group-directories-first -a'

# directory traversal
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd+='pushd &> /dev/null'
alias cd-='popd &> /dev/null'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ruby, rails
alias b='bundle'
alias be='bundle exec'
alias rake='bundle exec rake'
alias guard='bundle exec guard'
alias rspec='bundle exec rspec'

# miscellaneous
alias q="exit"
alias cls="clear"

# apt-get
alias agu="sudo apt-get update"
alias agi="sudo apt-get install"
alias agui="sudo apt-get update && sudo apt-get install"
alias agdu="sudo apt-get update && sudo apt-get dist-upgrade"

