#!/bin/bash
source ./dbcontext.sh
source ./test_helper.sh

#********************** verify_in_the_explorer_the_presence_of : Test **********************

function setup_verify_in_the_explorer_the_presence_of()
{
    local pattern_match="[A-Za-z]+.csproj"
    local message_error="No project with .cproj detected. You need to be inside a project"

    echo $pattern_match
    echo $message_error
}

# should_print_the_error_message__in_case_of_the_actual_location_is_not_at_the_level_of_a_csproj

function verify_in_the_explorer_the_presence_of____should_print_the_error_message()
{
    var_setup+=($( setup_verify_in_the_explorer_the_presence_of ))

    local result=$( verify_in_the_explorer_the_presence_of "${var_setup[0]}" "${var_setup[1]}" )

    assert_equal "${var_setup[1]}" "$result" "verify_in_the_explorer_the_presence_of___should_print_the_error_message"
}

verify_in_the_explorer_the_presence_of____should_print_the_error_message


# should_not_print_the_error_message__in_case_of_the_actual_location_is_at_the_level_of_a_csproj

function verify_in_the_explorer_the_presence_of___should_not_print_the_error_message()
{
    var_setup+=($( setup_verify_in_the_explorer_the_presence_of ))

    cd api
    local result=$( verify_in_the_explorer_the_presence_of "${var_setup[0]}" "${var_setup[1]}" )
    cd ..
    assert_equal "" "$result" "verify_in_the_explorer_the_presence_of___should_not_print_the_error_message"
}

verify_in_the_explorer_the_presence_of___should_not_print_the_error_message


#********************** if_not_already_specified_ask_for : Test **********************

# should_return_the_question_and_the_response_entered_by_the_user

function if_not_already_specified_ask_for___should_return_the_response_entered()
{
    local db_context="ApiDbContext"
    local ask="What is the DbContext name?"

    local result="$( printf "$db_context" | if_not_already_specified_ask_for "$ask" "" )"

    assert_match "$db_context" "$result" "if_not_already_specified_ask_for__should_return_the_response_entered"
}

if_not_already_specified_ask_for___should_return_the_response_entered


#********************** ask_for_while : Test **********************

# should_return_the_input_entered__in_case_of_the_input_of_the_user_match_already_with_the_pattern

function ask_for_while___return_the_response_entered()
{
    local user_input="1"
    local pattern_to_match='[123]'
    local error_message="Unkow db type. Please select one of the following : Sqlite[1], InMemory database[2], Sql server[3]"

    result="$( printf "$user_input" | ask_for_while "$user_input" "$pattern_to_match" "$error_message" )"
    assert_equal "$user_input" "$result" "ask_for_while__return_the_response_entered"
}

ask_for_while___return_the_response_entered


# should_return_the_correction_of_the_input__in_case_of_a_first_bad_input_of_the_user : the user enter a second input in correction of the first input
 
function ask_for_while___return_the_correction_input()
{
    local user_input="5"
    local correction_user_input="1"
    local pattern_to_match='[123]'
    local error_message="Unkow db type. Please select one of the following : Sqlite[1], InMemory database[2], Sql server[3]"

    result="$( printf "$user_input\n${correction_user_input}" | ask_for_while "$user_input" "$pattern_to_match" "$error_message" )"

    assert_match "$correction_user_input" "$result" "ask_for_while__return_the_correction_input"
}

ask_for_while___return_the_correction_input


#********************** extract_the_match_from : Test **********************

# should_return_a_sub_string_with_the_match

function extract_the_match_from___should_return_a_sub_string_with_the_match()
{
    cd api
    local result=$( extract_the_match_from ${PWD} '[A-Za-z]*[A-Za-z]$' )
    cd ..

    assert_equal api $result
}

extract_the_match_from___should_return_a_sub_string_with_the_match