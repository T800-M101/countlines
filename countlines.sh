#!/bin/bash

# This bash script counts the number of lines in a directory passing as argument the owner of the directory or the month when the files where created.


nlines=$(wc -l < $1)

echo "There are $nlines lines in $1"
