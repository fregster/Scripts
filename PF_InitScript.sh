#!/bin/sh

# To install the Stackdriver monitoring agent:
curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
sudo bash install-monitoring-agent.sh

# To install the Stackdriver logging agent:
curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
sudo bash install-logging-agent.sh

# Update the system
yum update -y

# Install my standard security utils
yum install -y libselinux libselinux-utils libselinux-utils selinux-policy-minimum selinux-policy-mls selinux-policy-targeted policycoreutils

# Install the web tools and required packages
yum install -y yum-cron nginx php70-fpm php70-pecl-yaml

# Enable the services
chkconfig nginx on
chkconfig php-fpm on

# Download healthcheck and enable
curl -sSO https://github.com/fregster/PHPHealthcheck/archive/master.zip
mkdir healthcheck && mv ./master.zip ./healthcheck
cd healthcheck && unzip master.zip
cd ~


# Start the services
systemctl nginx restart
systemctl php-fpm restart

