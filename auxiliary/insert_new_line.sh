#!/bin/bash
#**********************************************************************************************
#   * insert a new line before the line where the fisrt match was found
#   * $1 : the input file
#   * $2 : the pattern to match
#   * $3 : the line to insert
#   * $4 : example : inser_new_line ./input.js .*three.*  'console.log("insert new line");' 2>> ./stderr 
#**********************************************************************************************

function insert_new_line_before()
{
    #verify input
    if ! [[ $# -eq 3 ]]
        then 
            echo "Error: You forgot to pass some parameters to the function 'ask_for_while'. This function require three parameters"
            echo "--> $1"
            echo "--> $2"
            echo "--> $3"
            exit 1
    fi

    local input=$1
    local pattern_match=$2
    local line_to_insert=$3

    dest=./temp
    n=0

    if [[ -f input ]]
        then
            echo "The input file cannot be found. Please specify the entire path to find it"
            read input
    fi

    while IFS= read -r line
    do
        if [[ "$line" =~ $pattern_match && $n == 0 ]]
            then
                echo "$line_to_insert" >> $dest

                # let a space bellow the inserted line
                echo " " >> $dest 
                n=1
           
        fi
        echo "$line" >> $dest  
        
    done < "$input"

    cp ./temp $input

    rm ./temp
}