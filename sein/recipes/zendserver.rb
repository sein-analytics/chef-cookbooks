include_recipe "zendserver::single"
include_recipe "zendserver::restart"

zendserver_pear "mongo" do
  action :install
  notifies :restart, 'service[zend-server]'
end

execute "remove original mongo ext" do
  command "sed -i '/php_extensions\\/mongo.so/d' /usr/local/zend/etc/conf.d/mongo.ini"
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

execute "increase max post size" do
  command "/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d post_max_size -v 2048M"
  notifies :run, 'execute[restart-api]'
end

execute "increase max uplaod file size" do
  command "/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d upload_max_filesize -v 2048M"
  notifies :run, 'execute[restart-api]'
end

# log("/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d max_execution_time -v 3600")
execute "increase php max exec time" do
  command "/usr/local/zend/bin/zs-manage store-directive -N #{node[:zendserver][:apikeyname]} -K #{node[:zendserver][:apikeysecret]} -d max_execution_time -v 3600"
  notifies :run, 'execute[restart-api]'
end

link "/usr/bin/php" do
  to "/usr/local/zend/bin/php"
end