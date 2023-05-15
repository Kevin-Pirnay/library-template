#!/bin/bash
#**********************************************************************************************
#   * command available:
#   * - dbcontext : will create a new folder with interface and class
#   * - genericrepo : will create a new folder with generic repository interface and class
#   * - repository : will create a specific repository class or with the genericrepo if asked
#**********************************************************************************************

LOCATION=$( dirname ${BASH_SOURCE[0]} )

case $2 in

    classlib)
        $LOCATION/classlib/classlib.sh #2>> ./stderr
        ;;

    dbcontext)
        $LOCATION/dbcontext/dbcontext.sh #2>> ./stderr
        ;;

    genericrepo)
        $LOCATION/repository/genericrepository.sh #2>> ./stderr
        ;;

    repository)
        $LOCATION/repository/repository.sh #2>> ./stderr
        ;;

    test)
        $LOCATION/test/test.sh #2>> ./stderr
        ;;

    *)
        echo -n "unknown command: $2"
        ;;
esac
