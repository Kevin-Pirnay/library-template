#!/bin/bash
#******************************************************************************
#   * create a specific repository file at the current location
#   * if you don't specify the name or the type of the repo it will be asked
#   * if you don't have already a Repository directory it will be asked if
#   * you want create one with the generic interface and class
#   * if you have already a directory it will go inside the repo to create the file
#******************************************************************************

source $ROOT/auxiliary/current.func.sh

if_not_already_specified_ask_for "How would you like name your repository?" $3
NAME_REPOSITORY=$( GET_RESULT )

if_not_already_specified_ask_for "What is the type of your repository? " $4
TYPE_REPOSITORY=$( GET_RESULT ) 

NAMESPACE_REPOSITORY=$( extract_the_match_from ${PWD} '[A-Za-z]*[A-Za-z]$' )

# Enter in the right repository if it exists, otherwise ask to create one
repository_folder=$( ls )

if [[ $repository_folder =~ [A-Za-z0-9._-]*[Rr]epo[A-Za-z0-9._-]* && -d $BASH_REMATCH ]]
    then
        cd $BASH_REMATCH
    else
        echo "A repository directory was not detected. Would you like to create one with the generic interface and class [y]? If you are already inside the repository directory or you don't want create one please press [n]"
        read RESPONSE
        if [[ $RESPONSE == "y" ]] 
            then
                custom dotnet genericrepo 2>> ./stderr
                cd Repository
        fi  
fi

export NAMESPACE_REPOSITORY=$NAMESPACE_REPOSITORY
export NAME_REPOSITORY=$NAME_REPOSITORY
export TYPE_REPOSITORY=$TYPE_REPOSITORY

path_template=$ROOT/code/dotnet/template/repository
envsubst < $path_template/repository.template > ${PWD}/${NAME_REPOSITORY}Repository.cs

echo "Your repository ${NAME_REPOSITORY}Repository.cs was created at ${PWD}."