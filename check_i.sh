#!/bin/bash


R="\e[1;31m" # red
B="\e[0m" # black

function print_help {
	echo "------------help menu-------------"
	echo "command list"
	echo ""
	echo "check: verify hash of each file(default)"
	echo "make: make the hash list of file"
	echo "help: print this message"
	echo ""
	echo "usage"
	echo "bash check_i.sh make [dir_path]: make the hash list in dir_path"
	echo "bash check_i.sh check [dir_path]: verify hash of each file"
	echo "bash check_i.sh [dir_path]: same as above"

}

function confirm {
	while true
	do
		read -p "[Y/N]" yn
	case $yn in 
		[Yy] ) echo "1"; break;;
		[Nn] ) echo "0"; break;;
	esac
done
}


output_path="hash_list.txt"


if [ $1 = "help" ]
then
	print_help
elif [ $1 = "make" ]
then
	if [ -d $2 ]
	then
		target_path=$2
	else
		target_path="./"
	fi

	if [ -e $target_path/$output_path ]
	then
		echo -n "File already exist are you sure you want to re-make the hash list?"
		if [ $(confirm) -eq "1" ]
		then 
			rm $target_path/$output_path
			touch $target_path/$output_path

			for fileName in $(find $target_path -type f)
			do
				echo $fileName
				sha=$(sha256sum $fileName)
				echo $sha
				echo $sha | awk '{print $1"," $2}' >> $target_path/$output_path
				
			done
		else
			echo "No hash list file here!"
		fi
	fi

elif [ $1 = "check" ] || [ -d $1 ]
then
	# declare map 
	declare -A fileName_hash_map

	if [ -d $2 ]
	then
		target_path=$2
	else
		target_path="./"
	fi

	if [ -e $target_path/$output_path ]
	then
		# define key-value
		
		for fileName in $(find $target_path -type f)
		do
			a_file_hash=$(sha256sum $fileName | awk '{print $1}')
			fileName_hash_map[$fileName]=$a_file_hash
		done 

		# iterate key in map 

		#for _key in "${!fileName_hash_map[@]}"
		#do
		#	echo "key: $_key == value: ${fileName_hash_map[$_key]}"
		#done
		

		for line_of_list in $(cat $target_path/$output_path)
		do
			hash_before=$(echo $line_of_list | awk -F ',' '{print $1}')	
			key_before=$(echo $line_of_list | awk -F ',' '{print $2}')

			hash_now=${fileName_hash_map[$key_before]}

			if [ $hash_before != $hash_now ]
			then
				printf "$R[file has been tampered!!!]$B\n"
				echo "$key_before: $hash_before -> $hash_now"
			fi	
		done
	else 
		echo "No hash list file in here!"
	fi


else
	echo "Invalid command. Enter help for more information"
fi
