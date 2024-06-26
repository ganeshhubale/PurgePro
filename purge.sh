#!/bin/bash

# Provide the path of directory -> User should provide path
print -n "Directory path:-> "
read Path

# Check if the directory is present or not
[ -d $Path ] && echo "Directory exists" || echo "Please enter valid directory path"

print -n "Specify the minimum size of the files to be compressed in MB:-> "
read userMentionedSize

#print -n "Specify directory path for archive folder:-> "
#read Path

# Create archive folder if not already present
archivePath=/Users/ganesh/work/learning/shellscripting/projects/purgepro/PurgePro/archive
mkdir /Users/ganesh/work/learning/shellscripting/projects/purgepro/PurgePro/archive &> /dev/null
if [[ $? -eq 0 ]]
then
	echo "Folder successfully created"
else
	echo "Folder already exists with same name"
fi

# Find all the files with size more than given size
ls $Path > files.txt

while read myfile
do
	#echo "File name: $myfile"
	filePath="$Path/$myfile"
	sizeinBytes=$(stat -f%z $filePath)
	#echo "Size of $myfile -> $sizeinBytes"
	sizeinMB=$(echo "scale=2; $sizeinBytes/1048576" | bc)
	#echo "Size of $myfile -> $sizeinMB MB"
	
	if [[ $sizeinMB -ge $userMentionedSize ]]
	then
		filePath="$Path/$myfile"
		mv $filePath $archivePath
	else
		#echo "less than specified MB-> $myfile"
	fi
done < files.txt 


# Compress each file
#tar -cfz 

# Move the compressed files in archive folder
# Make a cron job to run the script at given time -> User should provide specific time
