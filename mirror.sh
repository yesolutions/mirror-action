#!/usr/bin/env bash
set -e

GIT_PUSH_ARGS=${INPUT_GIT_PUSH_ARGS:-"--tags --force --prune"}

function mirror {
    if [ $# -lt 3 ]; then
        echo "Parameters: remote_name soruce_repository destination_repository1 destination_repository2 ..."
        return
    fi

    index=0
    for des_rep in "$@"
    do
        index=`expr $index + 1 `
        echo "var${index}:${des_rep}"
        if [ 1 = $index ]; then
            echo "mkdir -p $des_rep"
            mkdir -p $1
            cd $1
            continue
        fi
        if [ 2 = $index ]; then
            echo "git fetch $des_rep"
            git init > /dev/null
            git remote add origin "$2"
            git fetch --all > /dev/null 2>&1
            continue
        fi
        
        echo "git remote add $1_${index} "$des_rep""
        git remote add $1_${index} "$des_rep";
        echo "eval git push ${GIT_PUSH_ARGS} $1_${index} "\"refs/remotes/origin/*:refs/heads/*\"""
        eval git push ${GIT_PUSH_ARGS} $1_${index} "\"refs/remotes/origin/*:refs/heads/*\""

    done

}

# "remote_name soruce_repository destination_repository1 destination_repository2 ..."
rep=("RabbitRemoteControl https://github.com/KangLin/RabbitRemoteControl.git ssh://kl222@git.code.sf.net/p/rabbitremotecontrol/code git@bitbucket.org:kl222/rabbitremotecontrol.git")
rep+=("SerialPortAssistant https://github.com/KangLin/SerialPortAssistant.git ssh://kl222@git.code.sf.net/p/serialportassistant/code")
rep+=("RabbitIm https://github.com/KangLin/RabbitIm.git ssh://kl222@git.code.sf.net/p/rabbitim/code")
rep+=("Calendar https://github.com/KangLin/Calendar.git ssh://kl222@git.code.sf.net/p/rabbitcalendar/code")


for i in "${rep[@]}";
do
    mirror $i;
done
