# history file where directories are stored that were accessed via "j" and "h"
J_HISTORY_FILE=$HOME/.j_history
J_HISTORY_FILE_TMP=$HOME/.j_history.tmp
# history file length (duplicates excluded)
J_HISTORY_LENTH=1000
# max. number of suggestions the "h" gives
JH_SUGGESTIONS_MAX=10

# "j" takes a space separated list of path prefixes, infixes, or suffixes and
# tries to expand them to a path. In case of ambiguities "j" offers a prompt
# and asks the user to select the desired match.
# "j" also maintains a history file whose entries can be accessed via "h".
#
# Examples:
#   $ j a       -> cd *a*/
#   $ j a bo    -> cd *a*/*b*o*/
#   $ j / a bo  -> cd /*a*/*b*o*/
#   $ j .. a    -> cd ../*a*/
#
j() {
  D=(`echo "$@/" | tr -s " " "/" | tr -s "/" "/" | sed -e "s/\//*\/*/g" -e "s/\/\*$/\//" -e "s/^\*\//\//" -e "s/^\([^\/]\)/*\1/" -e "s/\*\(\.\.*\)\*/\1/g" -e "s/\*~\*/~/g" -e "s/\([_\-\+a-zA-Z0-9]\)\([_\-\+a-zA-Z0-9]\)/\1*\2/g" -e "s/\([_\-\+a-zA-Z0-9]\)\([_\-\+a-zA-Z0-9]\)/\1*\2/g"`)
  DC=${#D[@]}
  if [ $DC -eq 1 ]; then
    pushd "${D[0]}" &> /dev/null
    if [ $? -eq 0 ]; then
      if [ -f $J_HISTORY_FILE ]; then
        { pwd; head -$J_HISTORY_LENTH $J_HISTORY_FILE; } > $J_HISTORY_FILE_TMP && awk '!x[$0]++' $J_HISTORY_FILE_TMP > $J_HISTORY_FILE
        rm $J_HISTORY_FILE_TMP
      else
        pwd > $J_HISTORY_FILE
      fi
      return 0;
    fi
  elif [ $DC -gt 1 ]; then
    echo "Have $DC possible expansion(s)"
    I=1
    OIFS=$IFS
    IFS=''
    for DIR in ${D[@]}; do
      echo "  $((I++)). $DIR"
    done
    IFS=$OIFS
    echo -n "Choice [1]: "
    read C
    if [ "$C" == "" ]; then
      C=1
    fi
    if [ $C -gt 0 ] && [ $C -le $DC ]; then
      pushd "${D[$((C - 1))]}" &> /dev/null
      if [ $? -eq 0 ]; then
        if [ -f $J_HISTORY_FILE ]; then
          { pwd; head -$J_HISTORY_LENTH $J_HISTORY_FILE; } > $J_HISTORY_FILE_TMP && awk '!x[$0]++' $J_HISTORY_FILE_TMP > $J_HISTORY_FILE
          rm $J_HISTORY_FILE_TMP
        else
          pwd > $J_HISTORY_FILE
        fi
        return 0;
      fi
    fi
  fi
  echo "Unable to expand path"
  return 1
}

alias J="j /"

# When called without arguments "h" offers a list of the last directories
# accessed via "j", or "h" and prompts the user which directory to jump to.
# When called with an argument "h" searches the history for the last directory
# whose path contains the argument.
#
# Examples:
#   If the user history looks like:
#     /home/joe/Documents   <- most recent jump
#     /var/logs/apache2
#     /var/bin              <- oldest jump
#   The following applies:
#     $ h o  -> cd /home/joe/Documents
#     $ h 2  -> cd /var/logs/apache2
#     $ h bi -> cd /var/bin
#     $ h va -> cd /var/logs/apache2 (because it's more recent than /var/bin)
#   The user could as well choose any other character sequence that is unique
#   for the desired match
#
h() {
  if [ -f $J_HISTORY_FILE ]; then
    if [ "$1" == "" ]; then
      OIFS=$IFS
      IFS=$'\n'
      D=(`head -$JH_SUGGESTIONS_MAX $J_HISTORY_FILE`)
      DC=${#D[@]}
      if [ $DC -gt 0 ]; then
        echo "Most recently jumped directories"
        I=1
        I_FILTER=$((DC + 1))
        for DIR in ${D[@]}; do
          if [ $DIR != $PWD ]; then
            echo "  $((I++)). $DIR"
          else
            I_FILTER=$I
          fi
        done
        echo -n "Choice [1]: "
        read C
        if [ "$C" == "" ]; then
          C=1
        fi
        if [ $C -gt 0 ] && [ $C -le $DC ]; then
          if [ $C -ge $I_FILTER ]; then
            C=$((C + 1))
          fi
          pushd "${D[$((C - 1))]}" &> /dev/null
          if [ $? -eq 0 ]; then
            { pwd; head -$J_HISTORY_LENTH $J_HISTORY_FILE; } > $J_HISTORY_FILE_TMP && awk '!x[$0]++' $J_HISTORY_FILE_TMP > $J_HISTORY_FILE
            rm $J_HISTORY_FILE_TMP
            IFS=$OIFS
            return 0;
          fi
        fi
      fi
      IFS=$OIFS
    else
      PATTERN=`echo "$@" | sed -e "s/\s\s*/[^\/]*\/[^\/]*/g" -e "s/\([_\-\+a-zA-Z0-9]\)\([_\-\+a-zA-Z0-9]\)/\1.*\2/g" -e "s/\([_\-\+a-zA-Z0-9]\)\([_\-\+a-zA-Z0-9]\)/\1.*\2/g"`
      D=`egrep -m 1 --mmap "$PATTERN[^\/]*$" $J_HISTORY_FILE`
      pushd "$D" &> /dev/null
      if [ $? -eq 0 ]; then
        { pwd; head -$J_HISTORY_LENTH $J_HISTORY_FILE; } > $J_HISTORY_FILE_TMP && awk '!x[$0]++' $J_HISTORY_FILE_TMP > $J_HISTORY_FILE
        rm $J_HISTORY_FILE_TMP
        return 0
      fi
    fi
  fi
  echo "Unable to lookup path"
  return 1
}

