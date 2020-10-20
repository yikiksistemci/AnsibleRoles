#!/bin/bash
#####################################################################
############### Vagrant + Infra-as-Code + Ansible ###################
## Author: Yunus YASAR <yunus.yasar@pm.me>                         ##
## Licence: GNU GPLv3                                              ##
##                                                                 ##
##                                                                 ##
#####################################################################

usage()
{    
    echo "infra-studio [-m <createvm,listvm> <HostName>] [-p <App Profile>] [-c <CPU>] [-r <RAM>] [-d <DISK>] [-add <IP Address>] "
    echo " -m: Mode --> createvm,listvm "
    echo " -p: App Profile --> Common,Graylog,Zabbix-Server,Docker,Docker-Compose vb."
    echo " -l: list app profile"
}

# add config file 
source infra-studio.conf

if [ "$(id -u)" != "0" ]; then
    echo "Only root may add a user to system"
    exit 2
fi





while getopts "m:l:p:add:" ops; do

    case "${ops}" in

    l) echo "todo";;
    m) echo "todo";;
    p) echo "todo";;
    add) echo "todo";;

    *)
      usage;;

    esac

done






