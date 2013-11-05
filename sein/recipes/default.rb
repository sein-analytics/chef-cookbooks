#
# Cookbook Name:: sein
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#install igbinary from PECL
zendserver_pear "igbinary" do
  action :install
end

zendserver_pear "gearman" do
  action :install
end
