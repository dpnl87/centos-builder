#!/bin/bash

yum groupinstall 'Development Tools'

yum install -y httpd-devel openssl-devel zlib-devel gcc gcc-c++ curl-devel \
  expat-devel gettext-devel patch readline readline-devel zlib zlib-devel \
  libyaml-devel libffi-devel make bzip2 zlib1g wget

#######################################################
# Build Ruby
#######################################################

# Keep it clean
mkdir /tmp/ruby
cd /tmp/ruby

# Configure libyaml
wget http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz
tar xzvf yaml-0.1.4.tar.gz
cd yaml-0.1.4
./configure --prefix=/usr/local
make
make install
cd /tmp/ruby

# build ruby-1.9.3-p484
wget http://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p484.tar.gz
tar -xzf ruby-1.9.3-p484.tar.gz
cd ruby-1.9.3-p484
./configure && make && make install
cd /tmp/ruby

# install ruby-gems 2.1.11
wget http://production.cf.rubygems.org/rubygems/rubygems-2.1.11.tgz
tar -xzf rubygems-2.1.11.tgz
cd rubygems-2.1.11
ruby setup.rb

# clean up
cd /
rm -rf /tmp/ruby

#######################################################
# Install Puppet
#######################################################
gem install puppet --no-rdoc --no-ri

# add the puppet group
groupadd puppet

#######################################################
# Install Chef
#######################################################
gem install chef ohai --no-ri --no-rdoc

#######################################################
# Turn off un-needed services
#######################################################
chkconfig sendmail off
chkconfig vbox-add-x11 off
chkconfig smartd off
chkconfig ntpd off
chkconfig cupsd off

########################################################
# Cleanup for compression
#######################################################
# Remove ruby build libs
yum -y remove zlib-devel openssl-devel readline-devel

# Cleanup other files we do not need
yum -y groupremove "Dialup Networking Support" Editors "Printing Support" "Additional Development" "E-mail server"

# Clean cache
yum clean all

# Clean out all of the caching dirs
rm -rf /var/cache/* /usr/share/doc/*
