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
alias db='bundle exec rake db:drop db:create db:migrate db:seed RAILS_ENV=test'
alias db!='bundle exec rake db:drop db:create db:migrate db:seed'
alias c="rails c test"
alias c!="rails c"
alias s='rails s RAILS_ENV=test'
alias s!='rails s'
alias t='bundle exec rspec spec'
alias t+='bundle exec rspec spec --fail-fast'
alias t..='bundle exec guard'
alias kill_guard="ps | egrep 'ruby.*guard' | grep -v egrep | sed 's/^\([0-9]*\).*/\1/g' | xargs kill"

# git
alias g='git'

# miscellaneous
alias f='find . -name'
alias q="exit"
alias cls="clear"

# apt-get
alias agu="sudo apt-get update"
alias agi="sudo apt-get install"
alias agui="sudo apt-get update && sudo apt-get install"
alias agdu="sudo apt-get update && sudo apt-get dist-upgrade"

# vim
VIM_TMP_PATH=/tmp
alias vim_cleanup="rm $VIM_TMP_PATH/*.swp &> /dev/null; rm $VIM_TMP_PATH/*.swo &> /dev/null; rm $VIM_TMP_PATH/*.*~v &> /dev/null; rm ~/.viminfo"

