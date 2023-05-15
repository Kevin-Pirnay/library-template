#!/bin/bash
#******************************************************************************
#   * crete a repository directory with the generic repository interface and 
#   * the generic repository class according to the DbContext specify
#******************************************************************************
source $ROOT/auxiliary/current.func.sh
source $ROOT/sys/func.sh

verify_in_the_explorer_the_presence_of '[A-Za-z]+.csproj' 'No project with .cproj detected. You need to be inside the test project'
