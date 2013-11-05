#
# Cookbook Name:: sein
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "automake" do
  action :install
end

#install igbinary from PECL
zendserver_pear "igbinary" do
  action :install
end

apt_repository "gearman" do
  uri "http://ppa.launchpad.net/gearman-developers/ppa/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "1C73E014"
end

package "libgearman-dev" do
  action :install
end

package "gearman" do
  action :install
end

zendserver_pear "gearman" do
  action :install
end
