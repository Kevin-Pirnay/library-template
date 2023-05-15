#!/bin/bash
#**********************************************************************
#   * verify the equality between two variable
#   * if true, return nothing
#   * if false, return the name of the function test and the result false
#   * $1: fisrt variable
#   * $2: second variable
#   * $3: the name of the test function
#**********************************************************************
assert_equal() #$1: fisrt_variable, $2: second_variable, $3: the_name_of_the_test_function
{
    #verify input
    if [[ -z "$1" || -z "$2" || -z "$3" ]]
        then 
            echo "Error: You forgot to pass some parameters to the function 'ask_for_while'. This function require three parameters"
            exit 1
    fi

    #function
    if ! [[ $1 == $2 ]]
        then
            echo "$3 : false"
    fi
}

#--------------------> maybe simply it wih !

#**********************************************************************
#   * verify that the varible to test contain some pattenr
#   * if true, return nothing
#   * if false, return the name of the function test and the result false
#   * $1: the pattern to match
#   * $2: the varible to test
#   * $3: the name of the test function
#**********************************************************************
assert_match() #$1: the_pattern_to_match, $2: the_varible_to_verify, $3: the_name_of_the_test_function
{
    #verify input
    if [[ -z "$1" || -z "$2" || -z "$3" ]]
        then 
            echo "Error: You forgot to pass some parameters to the function 'ask_for_while'. This function require three parameters"
            exit 1
    fi

    #function
    if ! [[ "$2" =~ $1 ]]
        then
            echo "$3 : false"
    fi
}