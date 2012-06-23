J_HISTORY_FILE=$HOME/.j_history
J_HISTORY_LENTH=1000
JH_SUGGESTIONS_MAX=10

j() {
	D=(`echo "$@/" | tr -s " " "/" | tr -s "/" "/" | sed -e "s/\//*\/*/g" -e "s/\/\*$/\//" -e "s/^\*\//\//" -e "s/^\([^\/]\)/*\1/" -e "s/\*\**/*/g" -e "s/\*\(\.\.*\)\*/\1/g"`)
	DC=${#D[@]}
	if [ $DC -eq 1 ]; then
		pushd "${D[0]}" &> /dev/null
		if [ $? -eq 0 ]; then
			if [ -f $J_HISTORY_FILE ]; then
				{ pwd; head -$J_HISTORY_LENTH $J_HISTORY_FILE; } > /tmp/.j_history && awk '!x[$0]++' /tmp/.j_history > $J_HISTORY_FILE
			else
				pwd > $J_HISTORY_FILE
			fi
			return 0;
		fi
    elif [ $DC -gt 1 ]; then
		echo "Possible expansions are"
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
					{ pwd; head -$J_HISTORY_LENTH $J_HISTORY_FILE; } > /tmp/.j_history && awk '!x[$0]++' /tmp/.j_history > $J_HISTORY_FILE
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

h() {
	if [ -f $J_HISTORY_FILE ]; then
		if [ "$1" == "" ]; then
			OIFS=$IFS
			IFS=$'\n'
			D=(`head -$JH_SUGGESTIONS_MAX $J_HISTORY_FILE`)
			DC=${#D[@]}
			if [ $DC -gt 0 ]; then
				echo "$DC most recent visited directories"
				I=1
				for DIR in ${D[@]}; do 
					echo "  $((I++)). $DIR"
				done
				echo -n "Choice [1]: "
				read C
				if [ "$C" == "" ]; then
					C=1
				fi
				if [ $C -gt 0 ] && [ $C -le $DC ]; then
					pushd "${D[$((C - 1))]}" &> /dev/null
					if [ $? -eq 0 ]; then
						{ pwd; head -$J_HISTORY_LENTH $J_HISTORY_FILE; } > /tmp/.j_history && awk '!x[$0]++' /tmp/.j_history > $J_HISTORY_FILE
						IFS=$OIFS
						return 0;
					fi
				fi
			fi
			IFS=$OIFS
		else
			D=`egrep -m 1 --mmap "$@[^\/]*$" $J_HISTORY_FILE`
			pushd "$D" &> /dev/null
			if [ $? -eq 0 ]; then
				{ pwd; head -$J_HISTORY_LENTH $J_HISTORY_FILE; } > /tmp/.j_history && awk '!x[$0]++' /tmp/.j_history > $J_HISTORY_FILE
				return 0
			fi
		fi
	fi
	echo "Unable to lookup path history"
	return 1
}

