#!/bin/bash
ansible_version="2.9.13"
hostnamectl set-hostname ansible-control-node
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

install_ansible_package(){
	echo "install ansible"
	python3 -m pip install ansible==$ansible_version 
	mkdir -p /etc/ansible
	cp -a /vagrant/ansible.cfg /etc/ansible
	touch /etc/ansible/hosts
	echo "Ansible version"
	/usr/local/bin/ansible --version
    echo "\ndone"
    
}

add_ansible_node(){
	echo -e "[testMachineHosts]\n192.168.1.22" > /etc/ansible/hosts
	
}

#update_package
install_common_package
install_ansible_package
add_ansible_node

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
systemctl restart sshd
useradd ansadmin
usermod -aG wheel ansadmin
echo -e "ansadminpass\nansadminpass" | passwd ansadmin
setenforce 0 && systemctl stop firewalld && systemctl disable firewalld
mkdir -p /home/ansadmin/.ssh && chmod 700 /home/ansadmin/.ssh && touch /home/ansadmin/.ssh/authorized_keys && chmod 600 /home/ansadmin/.ssh/authorized_keys  && chown -R ansadmin:ansadmin /home/ansadmin/.ssh 
cat /tmp/id_rsa.pub > /home/ansadmin/.ssh/authorized_keys  
cp -a /tmp/id_rsa_manager /home/ansadmin/.ssh/id_rsa && chmod 600 /home/ansadmin/.ssh/id_rsa &&
cp -a /tmp/id_rsa.pub_manager /home/ansadmin/.ssh/id_rsa.pub && chmod 600 /home/ansadmin/.ssh/id_rsa.pub && 
chown -R ansadmin:ansadmin /home/ansadmin/.ssh 
cp -a /tmp/ansadmin /etc/sudoers.d/
pkexec chown root:root /etc/sudoers /etc/sudoers.d -R
### network devices list ####
nmcli con delete "System eth0"
#nmcli con delete "Wired connection 1"
### network config ###
nmcli con mod "System eth1" ipv4.addresses 192.168.1.21/24
nmcli con mod "System eth1" ipv4.gateway 192.168.1.1
nmcli con mod "System eth1" ipv4.dns "8.8.8.8 8.8.4.4"
nmcli con mod "System eth1" ipv4.method manual
nmcli con mod "System eth1" connection.autoconnect yes
nmcli dev disconnect eth1
nmcli dev connect eth1
nmcli con show
systemctl restart NetworkManager
