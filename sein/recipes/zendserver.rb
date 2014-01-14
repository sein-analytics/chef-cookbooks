include_recipe "zendserver::single"

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