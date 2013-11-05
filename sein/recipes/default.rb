#
# Cookbook Name:: sein
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#install igbinary from PECL
php_pear "igbinary" do
  action :install
end

php_pear "gearman" do
  action :install
end
