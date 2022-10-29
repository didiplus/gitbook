#!/bin/bash
#
#*********************************************
#Author     didiplus
#Description: 多主机基于 ssh key 互相验证
#
#**********************************************


#当前用户密码
PASS=""
#设置网段最小和最大的地址的尾数
BEGIN=3
END=254
IP=`ip a s ens32 | awk -F'[ /]+' 'NR==3{print $3}'`
NET=${IP%.*}.

. /etc/os-release

color() {
    RES_COL=60
    MOVE_TO_COL="echo -en \\033[{RES_COL}G"
    SETCOLOR_SUCCESS="echo -en \\033[1;32m"
    SETCOLOR_FAILURE="echo -en \\033[1;31m"
    SETCOLOR_WARNING="echo -en \\033[1;33m"
    SETCOLOR_NORMAL="echo -en \E[0m"
    echo -n "1"&&${MOVE_TO_COL}
    echo -n "["
    if $2 ="success"-o $2 ="0";then
        ${SETCOLOR_SUCCESS}
        echo -n $" OK "
    elif $2 "failure" -o $2 = "1";then
        ${SETCOLOR_FAILURE}
        echo -n $"FAILED"
    else
        ${SETCOLOR_WARNING}
        echo -n $"WARNING"
    fi
        ${SETCOLOR_NORMAL}
        echo -n"]"
        echo
}


#安装sshpass
install_sshpass () {
    if [[ $ID =~ centos|rocky|rhel ]];then
        rpm -q sshpass &> /dev/null || yum -y install sshpass
    else
       dpkg -l sshpass &> /dev/null || { sudo apt update;sudo apt -y install sshpass; }
    fi
    if [ $? -ne 0 ];then
       color '安装 sshpass 失败！' 1
       exit 1
    fi
}

scan_host() {
    [ -e ./SCANIP.log ] && rm -rf SCANIP.log
    for (( i=$BEGIN;i<="$END";i++));do
       ping -c 1 -w 1 ${NET}$i &> /dev/null && echo "${NET}$i" >> SCANIP.log &
    done
    wait
}

push_ssh_key(){
    #生成ssh key
    [ -e ~/.ssh/id_rsa ] || ssh-keygen -p "" -f ~/.ssh/id_rsa
    sshpass -p $PASS ssh-copy-id -o StrictHostKeyChecking=no ${USER}@$IP &> /dev/null

    ip_list = `sort -t . -k 4 -n SCANIP.log`
    for ip in ${ip_list[*]};do
       sshpass -p $PASS scp -o StrictHostKeyChecking=no  -f ~/.ssh ${USER}@$IP: &>/dev/null
    done

    #把.ssh/known_hosts拷贝到所有主机、使他们第一次互相访问是不需要输入yes
    for ip in ${ip_list[*]};do
        scp ~/.ssh/known_hosts ${USER}@$IP:.ssh/ &>/dev/null
        color "$ip" 0
    done
}
scan_host