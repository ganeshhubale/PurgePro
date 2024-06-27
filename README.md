# PurgePro
PurgePro streamlines file cleanup, effortlessly removing obsolete files and optimizing storage space.


### Project requirements

In the given directory, if you find files more than given size (e.g 5MB) or files older than given days (e.g. 2 days or 1 hour) then compress those files and move in archive folder.

#### Steps to create a script
- Provide the path of directory to cleanup files
        -> User should provide path
- Check if the directory is present or not
- Create `archive` folder if not already present
- Find all the files with size more than given size
- Compress each file
- Move the compressed files in `archive` folder
- Ask if user want to delete archived files permanently and perform operation as per response
- (InProgress) Make a cron job to run the script at given time
        -> User should provide specific time

#### How to use PurgePro
- Clone this repository on local machine
- Make the script executable - `chmod +x purge.sh`
- Execute the script - `./purge.sh` and hit enter 

##### Where to add issues
- Add issues [here](https://github.com/ganeshhubale/PurgePro/issues) to improve the PurgePro tool.
