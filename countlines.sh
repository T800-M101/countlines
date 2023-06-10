#!/bin/bash

# This bash script counts the number of lines in a directory passing as argument the owner of the directory or the month when the files where created.


# Function to provide help on how to use the script
function help(){
     echo -e  "\e[1;31m***** THIS SMALL HELP WILL SHOW YOU HOW TO USE THE countlines.sh BASH SCRIPT *****\e"
     echo -e "\e[0;37m'countlines.sh' bash script will count the number of lines of a file that belongs to an owner or the number of lines of a file created at any specific month.\e"
     echo
     echo -e "\e[1;32mTo count the number of lines of files owned by a specific onwer, use  the owner option:\e"
     echo -e "\e[0;37m./countlines.sh -o"
     echo -e "./countlines.sh --owner\e"
     echo
     echo -e "\e[1;32mTo count the number of lines of files created at an specific month, use the month option\e"
     echo -e "\e[0;37m./countlines.sh -m"
     echo "./countlines.sh -month\e"
     echo
     echo "-o or --owner is the owner of the files and is optional."
     echo "-m or --month is the month in which the files were created and is optioan"
     echo
     echo "*** If you have more questions you can google it :)*** "
}


# Function to get the number os lines of files owned by the owner
function get_lines_by_owner() {
    # validate if the owner exists
     if ! id -u $owner >/dev/null 2>&1; then
         echo "The owner does not exists!"
     else
         # counting the number of files owned by the owmer
         nfiles=$(find . -user $owner -type f | wc -l)
         # Extracting to an array the name of the files owned by the owner
         files=($(find . -user $owner -type f)) 

         echo -e "\e[1;34mLooking for files where the owner is: $owner\e"
         echo -e "\e[1;37mFiles found: $nfiles"
         echo

         for f in "${files[@]}"
            do
                nlines=$(wc -l < $f)
                echo -e "File: ${f:2},  \t Lines: $nlines"
            done
      fi

}


# ***** SCRIPT INIT ******
    # Validating if there are options
    if [[ $# -gt 0 ]]
        then
            key=$1

            case $key in 
                "-o" | "--owner")
                     owner=$2
                     get_lines_by_owner $owner
                     ;;

                "-m" | "--month")
                    month=$2
                    get_lines_by_month $month
                    ;;

                *)
                help
                ;;
             esac
    else
        echo "Please provide an option: ./countlines.sh -o or ./countlines.sh -m"
    fi
