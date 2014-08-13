include_recipe "zendserver"

package "supervisor" do
	action :install
end

service "supervisor" do
	action :nothing
end

directory "/opt/sein/" do
	action :create
	owner "zend"
	group "zend"
end

template "/etc/supervisor/conf.d/seinworkers.conf" do
	source "seinworkers.conf.erb"
	notifies :restart, 'service[supervisor]', :delayed
end