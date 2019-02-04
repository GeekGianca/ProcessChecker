#!/bin/bash
#Gian Carlos Cuello
#Deivy Miranda
echo "=*=*=*=*=*=*=*=*=*=VERIFICADOR DE PROCESOS=*=*=*=*=*=*=*=*=*="
#Directory
dir=$1
#File
file=$2
#Check if number
isNumber="^[0-9]+$";
#certified process
certproc=""
#If the user sends parameters such as the 
#location directory, of the file and the name,
#of file.
#If the user enters only the name of the file,
#the current route is taken by default
if [ "$dir" != "" ]; then
	cd "$dir"
	echo "Direct me -> $dir"
	#It's verified that they exist and can be read
	if [[ -r $file && $file != "" ]]; then
		echo "File is $file"
	else
		read -p "Please enter the path attached to the file or the file name: " pathfile
		file=$pathfile
	fi
	#Otherwise it's requested to enter the path
else
	read -p "Please enter the path attached to the file or the file name: " pathfile
	file=$pathfile
	SCRIPT=$(readlink -f $0);
	dir=`dirname $SCRIPT`
fi
echo "Verifying route..."
echo "$dir"
sleep 2s
echo $file
#Check extension file
basename="${file##*.}"
echo "Current file extension ====> .$basename"
#Control variables for pid, name and ppid
foundproc=false
pidfound=false
namefound=false
ppidfound=false
#Check if the file can be read and if 
#its extension is txt.
if  [[ -r $file && "$basename" =~ "" ]]; then
	#If condition true
	echo "File OK..."
	echo "--> $file"
	sleep 1s
	#Go through the file lines, and divide the data
	#inside the file.
	for DATA in `cat $file `
	do
		pid=`echo $DATA | cut -d ";" -f1`
		name=`echo $DATA | cut -d ";" -f2`
		ppid=`echo $DATA | cut -d ";" -f3`
		echo "Process in file queue =====> $pid"
		echo "Verifying process"
		#Access the process folder and verify that the current
		#process exists in the folder.
		cd /proc/
		#Go through the folders in the /proc directory
		for i in $(ls -C1)
		do
			#If the folder contains a number access and verify 
			#next to the current process.
			if [[ "$i" =~ $isNumber ]]; then
				#Access the folder and browse the status file.
				cd "$i/"
				for line in `cat status `
				do
					#If the control variable gives true in the case,
					#then it will enter and verify if the processes exist and
					#are the same as the current ones.
					if [[ "$foundproc" = true ]]; then
						if [[ "$line" =~ "$pid" ]]; then
							echo "Occurrence found ===> $line"
							pidfound=true
							#sleep 1s
						else
							if [[ "$line" =~ "$name" ]]; then
								echo "Occurrence found ===> $line"
								namefound=true
								#sleep 1s
							else
								if [[ "$line" =~ "$ppid" ]]; then
									echo "Occurrence found ===> $line}"
									ppidfound=true
									#sleep 1s	
								fi
							fi
						fi
						#sleep 1s
						#Reset the var to false
						foundproc=false
					fi
					case $line in
						Name:)
							echo "Verifying line ======> $line"
							foundproc=true
							;;
						Pid:)
							echo "Verifying line ======> $line"
							foundproc=true
							;;
						PPid:)
							echo "Verifying line ======> $line"
							foundproc=true
							;;
						State:)
							certproc="$line"
							;;
					esac
				done
				cd ..
				echo "Done $i"
			fi
		done
		#Access the current directory path 
		#again and check if the control variables are true.
		cd "$dir"
		#Show directory for control view
		echo $dir
		echo $PWD
		#If the are true then save the 
		#processes in a plain text file with your data.
		if [[ "$pidfound" = true && "$namefound" = true && "$ppidfound" = true ]]; then
			echo "Process Exist -> $pid - $name - $ppid"
			echo "$pid - $name - $ppid => State -> $certproc => OK" >> proctrue.txt
			pidfound=false
			namefound=false
			ppidfound=false
		else
			#Otherwise, save the data in a file that contains 
			#non-existent processes.
			echo "Process not exist -> $pid - $name - $ppid"
			echo "$pid - $name - $ppid => N/F" >> procfalse.txt
		fi
		sleep 3s
	done
	#End for 
	echo "Exit script...."
	echo "Done"
else
	#End if file is not correct.
	echo "The parameter does not contain a valid file..."
	echo "Close Script..."
	exit
fi
echo "Creado por: "
echo "Gian Carlos Cuello"
echo "Deivy Miranda"