#!/bin/bash
# Initialise the Kali instance

sudo adduser --shell /bin/bash -m user
echo "user:Automation123" | sudo chpasswd
#
sudo yum install expect -y
#
sudo curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
sudo chmod 755 msfinstall
sudo ./msfinstall
#
sudo curl https://raw.githubusercontent.com/jamesholland-uk/scripts/master/metasploit-initialise-db.sh > metasploit-initialise-db.sh
sudo chmod 755 metasploit-initialise-db.sh
su -c "./metasploit-initialise-db.sh" -s /bin/sh user
#
sudo touch /home/user/.bashrc
sudo echo "/opt/metasploit-framework/bin/msfconsole" >> /home/user/.bashrc
#
sudo sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config
echo "PasswordAuthentication yes" | sudo tee -a /etc/ssh/sshd_config
sudo service sshd restart
