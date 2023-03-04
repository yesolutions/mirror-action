#!/usr/bin/env bash
set -e

GIT_PUSH_ARGS=${INPUT_GIT_PUSH_ARGS:-"--tags --force --prune"}

function mirror {
    if [ $# -lt 3 ]; then
        echo "Parameters: remote_name soruce_repository destination_repository1 destination_repository2 ..."
        return
    fi
    
    echo "-------------------------------------------------------------------"

    index=0
    
    for des_rep in "$@"
    do
        index=`expr $index + 1`
        
        if [ 1 = $index ]; then
            echo "Mirror $index: $des_rep"
            echo "step1: mkdir -p $des_rep"
            mkdir -p $1
            cd $1
            continue
        fi
        if [ 2 = $index ]; then
            echo "step2: git fetch source from $des_re"
            echo "git fetch $des_rep"
            git init > /dev/null
            git remote add origin "$2"
            git fetch --all > /dev/null 2>&1
            continue
        fi

        echo "step`expr $index - 2`: mirror to ${des_rep}"
        echo "git remote add $1_${index} "$des_rep""
        git remote add $1_${index} "$des_rep";
        echo "eval git push ${GIT_PUSH_ARGS} $1_${index} "\"refs/remotes/origin/*:refs/heads/*\"""
        eval git push ${GIT_PUSH_ARGS} $1_${index} "\"refs/remotes/origin/*:refs/heads/*\""

    done

}

# "remote_name soruce_repository destination_repository1 destination_repository2 ..."
rep=("RabbitRemoteControl https://github.com/KangLin/RabbitRemoteControl.git ssh://kl222@git.code.sf.net/p/rabbitremotecontrol/code git@bitbucket.org:kl222/rabbitremotecontrol.git")
rep+=("SerialPortAssistant https://github.com/KangLin/SerialPortAssistant.git ssh://kl222@git.code.sf.net/p/serialportassistant/code git@gitlab.com:kl222/SerialPortAssistant.git")
rep+=("RabbitIm https://github.com/KangLin/RabbitIm.git ssh://kl222@git.code.sf.net/p/rabbitim/code")
rep+=("Calendar https://github.com/KangLin/Calendar.git ssh://kl222@git.code.sf.net/p/rabbitcalendar/code git@gitlab.com:kl222/Calendar.git")
rep+=("LunarCalendar https://github.com/KangLin/LunarCalendar.git ssh://kl222@git.code.sf.net/p/lunarcalendar/code git@gitlab.com:kl222/LunarCalendar.git")
rep+=("chinesechesscontrol https://github.com/KangLin/ChineseChessControl.git ssh://kl222@git.code.sf.net/p/chinesechesscontrol/code git@gitlab.com:kl222/ChineseChessControl.git")
rep+=("RabbitProxyServer https://github.com/KangLin/RabbitProxyServer.git ssh://kl222@git.code.sf.net/p/rabbitproxyserver/code")
rep+=("RabbitCommon https://github.com/KangLin/RabbitCommon.git ssh://kl222@git.code.sf.net/p/rabbitcommon/code")
rep+=("Documents https://github.com/KangLin/Documents.git git@gitlab.com:kl222/Documents.git")

for i in "${rep[@]}";
do
    mirror $i;
done

