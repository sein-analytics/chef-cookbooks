include_recipe "sein::synapse"

dbname = node[:opsworks][:instance][:layers].join("_")

node.set[:zendserver][:dbname] = dbname

# Do restart if service exists - this is to avoid issues where GUI times out when IP address is changed.
service "zend-server" do
	action :restart
	ignore_failure true
end

include_recipe "sein::zendserver"