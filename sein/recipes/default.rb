#
# Cookbook Name:: sein
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "autoconf" do
        action :install
end

package "automake" do
  action :install
end

package "build-essential" do
  action :install
end

#install igbinary from PECL
#zendserver_pear "igbinary" do
#  action :install
#end

package "git" do
  action :install
end
