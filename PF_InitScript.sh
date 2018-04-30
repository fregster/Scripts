#!/bin/sh

# To install the Stackdriver monitoring agent:
curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
sudo bash install-monitoring-agent.sh

# To install the Stackdriver logging agent:
curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
sudo bash install-logging-agent.sh

# Add custom repos
sudo yum -y install epel-release
sudo import_epel_key
sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm
sudo rpm --import /etc/pki/rpm-gpg/IUS-COMMUNITY-GPG-KEY

# Update the system
sudo yum update -y

# Install my standard security utils
sudo yum install -y libselinux libselinux-utils libselinux-utils selinux-policy-minimum selinux-policy-mls selinux-policy-targeted policycoreutils

# Install the web tools and required packages
sudo yum install -y yum-cron nginx php72u-fpm php72u-pdo

# Enable the services
sudo systemctl enable nginx.service
sudo systemctl enable php-fpm.service

# Install default tooling
sudo yum install -y nano wget unzip

# Download healthcheck and enable
cd ~
wget https://github.com/fregster/PHPHealthcheck/archive/master.zip
rm -rf ~/healthcheck
mkdir healthcheck
mv ./master.zip ./healthcheck
sudo rm -rf /usr/share/nginx/html/PHPHealthcheck-master/
cd healthcheck && unzip master.zip && sudo chown -R php-fpm:php-fpm ./PHPHealthcheck-master/ && sudo mv PHPHealthcheck-master/ /usr/share/nginx/html/
cd ~

# Config the webserver

sudo rm /etc/nginx/default.d/php.conf
sudo wget https://raw.githubusercontent.com/fregster/Scripts/master/php.conf
sudo mv php.conf /etc/nginx/default.d/

sudo chcon -R -t httpd_user_content_t /usr/share/nginx/html/

# For testing only disable SELinux
sudo setenforce 0

# Start the services
sudo systemctl restart nginx
sudo systemctl restart php-fpm
