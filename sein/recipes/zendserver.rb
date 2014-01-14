include_recipe "zendserver::single"

# install xhprof extension
zendserver_pear "xhprof" do
  action :install
  preferred_state "beta"
  notifies :restart, 'service[zend-server]'
end

zendserver_pear "xdebug" do
  action :install
  notifies :restart, 'service[zend-server]'
end

template "/usr/local/zend/etc/conf.d/zend_extension_manager.ini" do
  source "xdebug_zem.ini.erb"
  notifies :run, 'execute[restart-api]'
end

zendserver_extension "mongo" do
  action :enable
  notifies :run, 'execute[restart-api]'
end

execute "enable error display" do
  command "/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d display_errors -v 1"
  notifies :run, 'execute[restart-api]'
end

# log("/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d memory_limit -v 1024M")
execute "increase php memory" do
  command "/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d memory_limit -v 1024M"
  notifies :run, 'execute[restart-api]'
end

# log("/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d max_execution_time -v 3600")
execute "increase php max exec time" do
  command "/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d max_execution_time -v 3600"
  notifies :run, 'execute[restart-api]'
end