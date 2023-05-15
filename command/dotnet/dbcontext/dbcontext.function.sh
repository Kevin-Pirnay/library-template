#!/bin/bash

source $ROOT/auxiliary/current.func.sh
source $ROOT/sys/func.sh


function get_method_db_provider_and_install_nuget_packages()
{
    # need to be at the level of a .*\.cproj file
    verify_in_the_explorer_the_presence_of '[A-Za-z]+.csproj' 'No project with .cproj detected. You need to be inside a project'

    if_not_already_specified_ask_for 'What is the db that you would use? Sqlite[1], InMemory database[2], Sql server[3]' $4 
    db_type=$( GET_RESULT )

    # verify that the input of the user match with an existing type of db before going on
    ask_for_while $db_type '[123]' 'Unkow db type. Please select one of the following : Sqlite[1], InMemory database[2], Sql server[3]'
    db_type=$( GET_RESULT )

    echo "Installation nuget packages in progress..."
    # use the right provider, install the right packages and then restore
    case $db_type in

        1)
            method_provider="UseSqlite"
            dotnet add package Microsoft.EntityFrameworkCore.Sqlite
            ;;

        2)
            method_provider="UseInMemoryDatabase"
            dotnet add package Microsoft.EntityFrameworkCore.InMemory
            ;;

        3)
            method_provider="UseSqlServer"
            dotnet add package Microsoft.EntityFrameworkCore.SqlServer
            ;;

        *)
        echo "sothing went wrong!"
        exit 1
            ;;
    esac

    dotnet add package Microsoft.EntityFrameworkCore
    dotnet add package Microsoft.EntityFrameworkCore.Design
    dotnet restore # maybe at the level up?

    sys_result $method_provider
}


function get_the_dbContext_name()
{
    # the name that will be use to name the directory and files. DbContext will be added automatically at the end
    if_not_already_specified_ask_for 'What is the DbContext name?' $3
    dbContext_name=$( GET_RESULT )
    sys_result $dbContext_name
}


function get_the_namespace()
{
    # need to be at the level of a .*\.cproj file
    verify_in_the_explorer_the_presence_of '[A-Za-z]+.csproj' 'No project with .cproj detected. You need to be inside a project'

    # extract the last element from PWD path to put that as namespace
    namespace_dbContext=$( extract_the_match_from ${PWD} '[A-Za-z]*[A-Za-z]$' )
    sys_result $namespace_dbContext
}