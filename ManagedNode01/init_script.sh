#!/bin/bash

systemctl set-hostname ansible-node01

update_package(){
    echo "Update Any Package"
    yum update -y 
    echo "\ndone"
}
install_common_package(){
	echo "Install common packages"
	yum install vim wget git python3 python3-pip net-tools -y 
	echo "\ndone"
}


update_package
install_common_package