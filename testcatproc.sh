#!/bin/bash
cd /proc/
isNumber="^[0-9]+$";
for i in $(ls -C1)
do
	if [[ "$i" =~ $isNumber ]]; then
		cd "$i/"
		for line in `cat status `
		do
			case $line in
				Name:)
					echo "True Line ****** $line"
					;;
				Pid:)
					echo "True Line ****** $line"
					;;
				PPid:)
					echo "True Line ****** $line"
					;;
			esac
			echo "Line is $line"
			#sleep 1s
		done
		cd ..
		echo "Done $i"
	else
		echo "The folder is not process..."
	fi
	sleep 1s
done