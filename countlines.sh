#!/bin/bash

# This bash script counts the number of lines in a directory passing as argument the owner of the directory or the month when the files where created.

echo -n "Please enter a filename: "

read filename

nlines=$(wc -l < $filename)

echo "There are $nlines lines in $filename"
