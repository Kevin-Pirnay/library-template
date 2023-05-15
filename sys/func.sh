#!/bin/bash
#source $ROOT/sys/result.sh

GET_RESULT()
{
    source $ROOT/sys/result.sh
    
    while ! [[ $RESULT =~ .* ]]
    do  
        echo ""
    done
    echo $RESULT
    echo "RESULT=" > $ROOT/sys/result.sh
}

sys_result()
{
    echo "RESULT=$1" > $ROOT/sys/result.sh
}