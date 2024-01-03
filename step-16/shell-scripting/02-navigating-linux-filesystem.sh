#!/bin/bash

# Display current directory
echo "Current directory: $(pwd)"

# Create new directory
mkdir new-directory
ls

# Change directory
cd new-directory
echo "We're now in: $(pwd)"

# Create new files
echo "How many files do you want to create?"
read numFiles
for ((i=1; i<=$numFiles; i++)); do
    touch "file$i.txt"
    echo "File $i created"
done

# List the files
ls

# Move back to previous directory
cd ..
echo "We're back to: $(pwd)"

# Delete the new directory & its contents
sudo rm -rf new-directory

# List the files in the current directory
ls