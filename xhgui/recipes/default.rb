#
# Cookbook Name:: xhgui
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git node[:xhgui][:path] do
	repository "https://github.com/perftools/xhgui.git"
	action "sync"
	user node[:apache2][:user]
	group node[:apache2][:group]
end

directory "#{node[:xhgui][:path]}/cache" do
	mode 00777
end

if node[:xhgui][:webservers].include?('apache2')
	include_recipe 'apache2'

	web_app "xhgui" do
		server_name node['hostname']
		server_aliases [node['hostname']]
		server_port "81"
		docroot "#{node[:xhgui][:path]}/webroot/"
		template "apache2.conf.erb"
		allow_override ["All"]
	end
end
# Add condition for Nginx

# template for mongodb user/password if required

#run installer script

execute "run xhgui installer" do
	cwd node[:xhgui][:path]
	environment({"PATH" => "$PATH:#{node[:xhgui][:php_path]}"}) if !node[:xhgui][:php_path].empty?
	command "php install.php"
end