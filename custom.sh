#!/bin/bash
#the coomand custom has been added to the directory /usr/local/bin

LOCATION=$( dirname ${BASH_SOURCE[0]} )
export ROOT=$LOCATION

case $1 in

angular)
    source $LOCATION/command/angular/root.sh
    ;;

dotnet)
    source $LOCATION/command/dotnet/root.sh
    ;;

*)
    echo -n "unknown command: $1"
    ;;
esac

