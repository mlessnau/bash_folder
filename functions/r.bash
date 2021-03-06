# rake task completion
r() {
  PATTERN=(`echo "$@" | sed -e "s/ /[^:]*:[^:]*/g" -e "s/\([_\-\+a-zA-Z0-9]\)\([_\-\+a-zA-Z0-9]\)/\1[^:]*\2/g" -e "s/\([_\-\+a-zA-Z0-9]\)\([_\-\+a-zA-Z0-9]\)/\1[^:]*\2/g"`)
  MATCHES=(`bundle exec rake -T | tr -s "\t" " " | grep -E "^rake" | cut -d " " -f 2 | grep -E "^[^:]*$PATTERN"`)
  N=${#MATCHES[@]}
  if [ $N -eq 1 ]; then
    bundle exec rake $MATCHES
    return 0
  elif [ $N -gt 1 ]; then
    echo "Which task do you want to run?"
    I=1
    for TASK in ${MATCHES[@]}; do
      echo "  $((I++)). $TASK"
    done
    echo -n "Choice [1]: "
    read C
    if [ "$C" == "" ]; then
      C=1
    fi
    CHOICES=(`echo "$C" | sed -e "s/[^0-9,]*//g" | tr "," "\n"`)
    for CHOICE in ${CHOICES[@]}; do
      if [ $CHOICE -gt 0 ] && [ $CHOICE -le $N ]; then
        bundle exec rake ${MATCHES[$((CHOICE - 1))]}
      else
        return 1
      fi
    done
    return 0
  else
    echo "No task matches"
  fi
  return 1
}
