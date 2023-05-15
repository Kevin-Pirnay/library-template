#!/bin/bash
#**********************************************************************************************
#   * crete a dbContext directory with the generic dbContext interface and class 
#   * install and restore the nuget packages needed
#   * insert the namespace reference in the Program.cs file 
#   * and the reference of the interface and the class in the di registration 
#**********************************************************************************************

source $ROOT/command/dotnet/dbcontext/dbcontext.function.sh
source $ROOT/auxiliary/insert_new_line.sh
source $ROOT/sys/func.sh


NAMESPACE_DB_CONTEXT=""
DB_CONTEXT_NAME=""

function creation_of_a_dbContext_directory_with_interface_and_class()
{
   # need to be at the level of a .*\.cproj file
    verify_in_the_explorer_the_presence_of '[A-Za-z]+.csproj' 'No project with .cproj detected. You need to be inside a project'

    get_the_dbContext_name
    export DB_CONTEXT_NAME=$( GET_RESULT )

    get_method_db_provider_and_install_nuget_packages
    export METHOD_PROVIDER=$( GET_RESULT )

    get_the_namespace
    export NAMESPACE_DB_CONTEXT=$( GET_RESULT )


    # create the directory where to insert the class and interface template
    DIRECTORY_TO_CREATE=${DB_CONTEXT_NAME}DbContext
    mkdir $DIRECTORY_TO_CREATE


    # replace the variable in template files by the environment variables and insert files in the directory created
    path_template=$ROOT/code/dotnet/template/dbcontext
    envsubst < $path_template/idbcontext.template > ${PWD}/$DIRECTORY_TO_CREATE/I${DB_CONTEXT_NAME}DbContext.cs
    envsubst < $path_template/dbcontext.template > ${PWD}/$DIRECTORY_TO_CREATE/${DB_CONTEXT_NAME}DbContext.cs
}


function insert_in_the_di_container_registration_and_add_reference_of_the_namespace_into_Program_file()
{
    # need to be at the level of a .*\.cproj file
    verify_in_the_explorer_the_presence_of '[A-Za-z]+.csproj' 'No project with .cproj detected. You need to be inside a project'

    check=$( check_in_the_explorer_the_presence_of 'Program\.cs' )

    if ! [[ $check -eq 0 ]]; then cd .. ; fi

    verify_in_the_explorer_the_presence_of '[A-Za-z]+.sln' 'No .sln detected. If you have multiple .csproj, you should have a sln'

    # the directory that contain the di-registration
    DIR=$( search_file 'Program.cs' * )

    # use file template instead of hard coded what to insert: write a small file with builder.Services.AddScoped<${X}, ${Y}>();
    insert_new_line_before ${PWD}/${DIR}/Program.cs 'builder.Build\(\)' "builder.Services.AddScoped<I${DB_CONTEXT_NAME}DbContext, ${DB_CONTEXT_NAME}DbContext>();"
    # use file template instead of hard coded what to insert: write a small file with using ${X};
    insert_new_line_before ${PWD}/${DIR}/Program.cs  '[A-Za-z]' "using ${NAMESPACE_DB_CONTEXT};"
}


creation_of_a_dbContext_directory_with_interface_and_class

insert_in_the_di_container_registration_and_add_reference_of_the_namespace_into_Program_file



