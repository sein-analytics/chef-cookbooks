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

file "/usr/local/zend/etc/conf.d/xdebug.ini" do
  action :delete
end

template "/usr/local/zend/etc/conf.d/zend_extension_manager.ini" do
  source "xdebug_zem.ini.erb"
  notifies :run, 'execute[restart-api]'
end
