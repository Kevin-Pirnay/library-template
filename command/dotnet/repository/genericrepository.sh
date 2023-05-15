#!/bin/bash
#******************************************************************************
#   * crete a repository directory with the generic repository interface and 
#   * the generic repository class according to the DbContext specify
#******************************************************************************

source $ROOT/auxiliary/current.func.sh
source $ROOT/sys/func.sh

verify_in_the_explorer_the_presence_of '[A-Za-z]+.csproj' 'No project with .cproj detected. You need to be inside a project'

if_not_already_specified_ask_for "What is the DbContext? " $3
DB_CONTEXT=$( GET_RESULT ) 

export DB_CONTEXT=$DB_CONTEXT

if [[ -z $NAMESPACE_REPOSITORY && ${PWD} =~ [A-Za-z._-]*[A-Za-z]$ ]]
    then 
        NAMESPACE_REPOSITORY=$BASH_REMATCH
fi   

export NAMESPACE_REPOSITORY=$NAMESPACE_REPOSITORY

FOLDER_TO_CREATE=Repository

mkdir $FOLDER_TO_CREATE

path_template=$ROOT/code/dotnet/template/repository
envsubst < $path_template/igenericrepository.template > ${PWD}/$FOLDER_TO_CREATE/IGenericRepository.cs
envsubst < $path_template/genericrepository.template > ${PWD}/$FOLDER_TO_CREATE/GenericRepository.cs

echo "Your repository directory is created with the generics repository interface and class"