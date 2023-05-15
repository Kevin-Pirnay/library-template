#!/bin/bash

source $ROOT/auxiliary/current.func.sh

#TODO: refactor

if_not_already_specified_ask_for "What is the name of the new classlib" $3
classlib=$( GET_RESULT ) 

echo "creation of the classlib in progress..."
dotnet new classlib -n $classlib

check_in_the_explorer_the_presence_of '[A-Za-z]+.sln' ' '
sln_exist=$( GET_RESULT )
if [[ $sln_exist == "1" ]]
    then
        echo "No sln detected. Would you like to create one [y]? If a sln exist in your project but you are not at this level please ignore this request [n]"
        read sln
        verify_yes_or_no $sln

        if [[ $sln == "y" ]]
            then
                dotnet new sln
                #TODO: need to be at the level of the sln
                for directory in *
                do  
                    if [[ -d $directory && -f $directory/$directory.csproj ]]
                        then
                            dotnet sln add $directory
                    fi
                done
        fi
fi


dotnet sln add $classlib

echo "Would you add some reference of this project into another project? [y]. Otherwise please respond [n]"
read addreferenceTo
verify_yes_or_no $addreferenceTo

while  [[ $addreferenceTo == "y" ]]
do
    echo "Please enter the name of the project that must contain the reference of this classlib"
    read target
    dotnet add $target reference $classlib

    echo "there is another project that must contain the reference of this classlib? [y] [n] "
    read addreferenceTo

    verify_yes_or_no $addreferenceTo

done

echo "Would you add some reference of another project into this project? [y]. Otherwise please respond [n]"
read addreferenceFrom

verify_yes_or_no $addreferenceFrom


while  [[ $addreferenceFrom == "y" ]]
do
    echo "Please enter the name of the project that must be referenced in this classlib"
    read reference
    dotnet add $classlib reference $reference

    echo "there is another project that must be referenced in this classlib? [y] [n] "
    read addreferenceFrom

    verify_yes_or_no $addreferenceFrom

done
