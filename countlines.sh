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


# Function to get the number of lines of files created at specific month
function get_lines_by_month() {
     # setting array of month to validate input option
     months=("jan" "january" "feb" "february" "mar" "march" "apr" "april" "may" "jun" "june" "jul" "july" "aug" "august" "sep" "september" "oct" "october" "nov" "november" "dec" "december")
     error="The month provided is incorrect!"
     COUNTER=0

    # looing the array to increment the COUNTER if the input month in found in the array
    for m in "${months[@]}"
        do
            month_lower=$(echo "$month" | tr '[:upper:]' '[:lower:]')
            if [[ $m = $month_lower ]]
                 then
                    COUNTER=$((COUNTER + 1))
            fi
        done

    # If the COUNTER is grater than 0 we excute  code
   if [[ $COUNTER -gt 0 ]]
     then
         # Extracting 3 first chars from month
         month_short=${month:(0):(3)}
         # Lowering month
         month_short=$(echo "$month_short" | sed -e 's/\(.*\)/\L\1/')
         # Capitalizing month
         m=$(echo "$month_short" | sed 's/.*/\u&/')
         # Counting  number of files by month
         nfiles=$(find . -type f -ls | grep $m | wc -l)
         echo -e "\e[1;34mLooking for files where the month is: $m\e"
         echo -e "\e[1;37mFiles found: $nfiles"
         echo
         # Traversing glob to filter files by month
         for f in *;
             do 
                # Getting nuber of lines by file
                nlines=$(wc -l < $f)
                # Getting creation time of each file
                ctime=$(ls --time=ctime -l $f)
                # Filtering month
                if [[ $ctime == *$m* ]];
                    then
                        echo -e "File: $f,   \t Lines: $nlines"
                fi
            done
   else
         echo "$error"
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
