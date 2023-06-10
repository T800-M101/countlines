#!/bin/bash

# This bash script counts the number of lines in a directory passing as argument the owner of the directory or the month when the files where created.


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
