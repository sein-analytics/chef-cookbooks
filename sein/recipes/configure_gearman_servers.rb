include_recipe "awscli"

template "/tmp/extractIp.php"  do
	source "extractIp.php.erb"
end

bash "create_gearman_servers_list" do
	code <<-EOH
aws opsworks describe-instances --layer-id=#{node[:configure_gearman_servers][:layer_id]} | /usr/local/zend/bin/php /tmp/extractIp.php > /etc/gearman_servers
EOH
end
