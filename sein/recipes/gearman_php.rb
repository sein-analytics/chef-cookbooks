# pecl extension
zendserver_pear "gearman" do
        action :install
end

template "/usr/local/zend/etc/conf.d/gearman.ini" do
        source "gearman.ini.erb"
        user "root"
        group "zend"
        mode 0664
        notifies :restart, 'service[zend-server]', :delayed
end