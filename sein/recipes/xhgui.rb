include_recipe "xhgui"
include_recipe "zendserver"

#add auto_prepend directive
execute "adding auto_prepend for xhprof" do
	command "/usr/local/zend/bin/zs-manage store-directive -d auto_prepend_file -v '#{node[:xhgui][:path]}/external/header.php' -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]}"
	notifies :run, 'execute[restart-api]'
end

#replace config file
template "#{node[:xhgui][:path]}/config/config.php" do
	source "xhgui_conf.php.erb"
end