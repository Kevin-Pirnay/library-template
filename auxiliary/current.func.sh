#!/bin/bash
source $ROOT/sys/func.sh
#**********************************************************************
#   * verify that a directory or a file is present at the current 
#   * level. Otherwise it print the error_message and exit
#   * $1: pattern_match
#   * $2: message_error
#**********************************************************************
verify_in_the_explorer_the_presence_of() #$1=pattern_match,$2=message_error
{
    #verify input
    if ! [[ $# -eq 2 ]]
        then 
            echo "Error: You forgot to pass some parameters to the function 'verify_in_the_explorer_the_presence_of'. This function require two parameters"
            echo "--> $1"
            echo "--> $2"
            exit 1
    fi

    #function
    local explorer=$( ls )

    if ! [[ "$explorer" =~ $1 ]]
        then
            echo "$2"
            exit 1
    fi
}

check_in_the_explorer_the_presence_of() #$1=pattern_match,$2=message_error
{
    #verify input
    if [[ $# -lt 1 ]]
        then 
            echo "Error: You forgot to pass some parameters to the function 'check_in_the_explorer_the_presence_of'. This function require at least one parameter"
            echo "--> $1"
            exit 1
    fi

    #function
    local explorer=$( ls )

    if [[ "$explorer" =~ $1 ]]
        then
            sys_result "0" #true
        else
            sys_result "1" #false
    fi
}


#**********************************************************************
#   * if a value is not specified then ask to the user for a response
#   * return the response specified by the user
#   * $1: question that will be display
#   * $2: variable to check to see if a value is already set (optional)
#**********************************************************************
if_not_already_specified_ask_for() #$1=the_question_to_ask, $2=the_variable_to_check_to_see_if_a_value_is_already_specified
{
    #verify input
    if [[ $# -lt 1 ]]
        then 
            printf "Error: You forgot to pass some parameters to the function 'if_not_already_specified_ask_for'. This function require at least one parameters"
            echo "--> $1"
            exit 1
    fi

    #function
    if [[ -z "$2" ]]
        then
            echo "$1"
            read RESPONSE
            sys_result "$RESPONSE"
    fi
}


#**********************************************************************
#   * while an input from the user doesn't match with a pattern
#   * the question will be asked
#   * $1: the variable that must fullfill some pattern
#   * $2: the pattern to match
#   * $3: the error message that help the user to enter a correct input
#   * return the input of the user
#**********************************************************************
ask_for_while() # $1: the__user_input_variable_that_must_fulfill_some_pattern, $2: the_pattern_to_match, $3: error_message
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

    #function
    local INPUT="$1"
    while ! [[ "$INPUT" =~ $2 ]]
    do  
        echo "$3"
        read INPUT
    done
    sys_result "$INPUT"
}


#**********************************************************************
#   * while an input from the user doesn't match an existing file or directory
#   * the question will be asked
#   * $1: the option to choose looking for a file or a directory
#   * $2: the name of the file or the directory
#   * return the name inserted by the user when this name match with something
#**********************************************************************
ask_for_while_not_exist() #$1: option_directory_or_file, $2: the_name_of_the_file_or_the_directory
{
    #verify input
    if ! [[ $# -eq 2 ]]
        then 
            echo "Error: You forgot to pass some parameters to the function 'ask_for_while'. This function require two parameters"
            echo "--> $1"
            echo "--> $2"
            exit 1
    fi

    #function
    local name_inserted=$2
    case $1 in

    "-d")
        while ! [[ -d "$name_inserted" ]]
        do
            echo "The name of the directory inserted is: $name_inserted"
            echo "$name_inserted doesn't match with any name of the directories in your current location. Please enter a new name."
            read name_inserted
        done
        ;;

    "-f")
        while ! [[ -f "$name_inserted" ]]
        do
            echo "The name of the file inserted is: $name_inserted"
            echo "$name_inserted doesn't match with any name of the files in your current location. Please enter a new name"
            read name_inserted
        done
        ;;

    *)
       echo "Wrong option parameter provided."
       exit 1
        ;;
    esac

    sys_result "$name_inserted"
}


#**********************************************************************
#   * extract and return the part of the string that match with the pattern
#   * $1: the variable from where extract the match
#   * $2: the pattern to match
#**********************************************************************
extract_the_match_from() # $1: the_variable_from_where_extract_the_match, $2: pattern_match
{
    #verify input
    if ! [[ $# -eq 2 ]]
        then 
            echo "Error: You forgot to pass some parameters to the function 'verify_in_the_explorer_the_presence_of'. This function require two parameters"
            echo "--> $1"
            echo "--> $2"
            exit 1
    fi

    #function
    if [[ "$1" =~ $2 ]]
        then 
            echo "$BASH_REMATCH"
    fi  
}


#**********************************************************************


function search_file() #$1 the location from where to search
{
    #verify input
    if ! [[ $# -eq 2 ]]
        then 
            echo "Error: You forgot to pass some parameters to the function 'verify_in_the_explorer_the_presence_of'. This function require two parameters"
            echo "--> $1"
            echo "--> $2"
            exit 1
    fi

    #function
    #queue=()
    for dir in "$2"
    do
        if [[ -d "$dir" && -f $dir/"$1" ]]
            then    
                echo "$dir"
                exit 0
        #... else recursif
        fi
    done
}


function verify_yes_or_no()
{
    while ! [[ $1 =~ [yn] ]]
    do
        echo "Please enter either n or y to respond to the question"
    done
}