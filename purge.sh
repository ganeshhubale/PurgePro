#!/bin/bash

echo "------------------------------------------------------------------------------------------------------------------"
echo "Welcome to PurgePro - streamlines file cleanup, effortlessly removing obsolete files and optimizing storage space."
echo "------------------------------------------------------------------------------------------------------------------"
echo ""
# Provide the path of directory -> User should provide path
echo -n "Specify the path of directory to cleanup:-> "
read Path

# Check if the directory is present or not
#[ -d $Path ] && echo "Thanks for providing directory." || echo "Please enter the valid directory path!" exit 1;

if [ -d $Path ]
then
	echo "Thanks for providing directory."
else
	echo "Please enter the valid directory path!"
	exit 1
fi

echo ""
echo -n "Specify the minimum size of the files to be compressed in MB (E.g. 0.1 or 5):-> "
read userMentionedSize
echo ""

#echo -n "Specify directory path for moving compressed files to:-> "
#read Path

# Create archive folder if not already present

# Used date convention considering files created daily  but not cleanedup
currentDate=$(date +"%Y-%m-%d")
archivePath="/Users/ganesh/Desktop/archive-$currentDate"
mkdir $archivePath &> /dev/null

if [[ $? -eq 0 ]]
then
	echo "Folder successfully created at $archivePath to store compressed files."
else
	echo "Folder $archivePath already exist to store compressed files."
fi

# Find all the files with size more than given size
ls $Path > "$archivePath/files.txt"

while read myfile
do
	filePath="$Path/$myfile"
	sizeinBytes=$(stat -f%z $filePath)
	sizeinMB=$(echo "scale=2; $sizeinBytes/1048576" | bc)
	
	if [[ $sizeinMB -ge $userMentionedSize ]]
	then
		filePath="$Path/$myfile"

		# Compress each file
		gzip $filePath

		# Move the compressed files in archive folder
		mv "$filePath.gz" $archivePath
	fi
done < "$archivePath/files.txt"

echo ""
echo -n "Do you want to delete these archived files? (Y/y):-> "
read response

if [[ $response == "Y" || $response == "y" ]]
then
	rm -rf $archivePath
	echo "Archived files permanently deleted."
fi

echo ""
echo "Thanks for using PurgePro!!!"

# (ToDo) Make a cron job to run the script at given time -> User should provide specific time
