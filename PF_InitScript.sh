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

# Start the services
service nginx restart
service php-fpm restart

