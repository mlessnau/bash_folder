# directory listing
if [ `uname` != "Darwin" ]; then
  alias ls='ls --color=auto'
  alias l='ls --group-directories-first -a'
else
  alias l='ls -la'
fi
alias ll='ls -alF'
alias la='ls -A'

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

# ruby, rails, rake, bundler
alias b='bundle'
alias be='bundle exec'
alias rake='bundle exec rake'
alias guard='bundle exec guard'
alias rspec='bundle exec rspec'

# miscellaneous
alias tree="tree -C"

# apt-get
alias agdu="sudo apt-get update && sudo apt-get dist-upgrade"

# vim
VIM_TMP_PATH=/tmp
alias vim_cleanup="rm $VIM_TMP_PATH/*.swp &> /dev/null; rm $VIM_TMP_PATH/*.swo &> /dev/null; rm $VIM_TMP_PATH/*.*~v &> /dev/null; rm ~/.viminfo"
