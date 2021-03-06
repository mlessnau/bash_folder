# creates the directory structure using "mkdir -p" and immediately
# enters it using "pushd"
md() {
  if [ "$1" == "" ]; then
    return 1
  fi
  mkdir -p $@
  pushd $@ &> /dev/null
  return 0
}

