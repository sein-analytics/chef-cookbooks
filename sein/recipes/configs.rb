COMPOSER_HOME = '/home/vagrant/.composer'

directory "#{node[:sein][:project_root]}/data/logs" do
	mode 0777
	action :create
	recursive true
end

# create COMPOSER_HOME and set manually 
directory COMPOSER_HOME do
	user "vagrant"
	group "vagrant"
	action :create
end

# Not using templates to keep process centralized - using Phing for replacements so that CI server can also call task
execute "phing tasks" do
  command %Q{
  	/usr/local/zend/bin/phing builddev \
-Dphp.path="/usr/local/zend/bin/" \
-Dapplication.display_startup_errors="#{node[:sein][:display_startup_errors]}" \
-Dapplication.display_errors="#{node[:sein][:display_errors]}" \
-Dapplication.display_exceptions="#{node[:sein][:display_exceptions]}" \
-Dapplication.smtp_host="#{node[:sein][:smtp_host]}" \
-Dapplication.smtp_auth="#{node[:sein][:smtp_auth]}" \
-Dapplication.smtp_username="#{node[:sein][:smtp_username]}" \
-Dapplication.smtp_password="#{node[:sein][:smtp_password]}" \
-Dapplication.smtp_ssl="#{node[:sein][:smtp_ssl]}" \
-Dapplication.smtp_port="#{node[:sein][:smtp_port]}" \
-Dapplication.default_db_adapter="#{node[:sein][:default_db_adapter]}" \
-Dapplication.default_db_host="#{node[:sein][:default_db_host]}" \
-Dapplication.default_db_username="#{node[:sein][:default_db_username]}" \
-Dapplication.default_db_password="#{node[:sein][:default_db_password]}" \
-Dapplication.default_db_name="#{node[:sein][:default_db_name]}" \
-Dapplication.default_db_socket="#{node[:sein][:default_db_socket]}" \
-Dapplication.deal_db_driver="#{node[:sein][:deal_db_driver]}" \
-Dapplication.deal_db_host="#{node[:sein][:deal_db_host]}" \
-Dapplication.deal_db_port="#{node[:sein][:deal_db_port]}" \
-Dapplication.default_db_socket="#{node[:sein][:default_db_socket]}" \
-Dapplication.deal_db_user="#{node[:sein][:deal_db_user]}" \
-Dapplication.deal_db_password="#{node[:sein][:deal_db_password]}" \
-Dapplication.doctrine_db_driver="#{node[:sein][:doctrine_db_driver]}" \
-Dapplication.doctrine_db_name="#{node[:sein][:doctrine_db_name]}" \
-Dapplication.doctrine_db_host="#{node[:sein][:doctrine_db_host]}" \
-Dapplication.doctrine_db_port="#{node[:sein][:doctrine_db_port]}" \
-Dapplication.doctrine_db_user="#{node[:sein][:doctrine_db_user]}" \
-Dapplication.doctrine_db_password="#{node[:sein][:doctrine_db_password]}" \
-Dapplication.doctrine_db_socket="#{node[:sein][:doctrine_db_socket]}" \
-Dapplication.doctrine_cache_adapter_class="#{node[:sein][:doctrine_cache_adapter_class]}" \
-Dapplication.doctrine_autogenerate_classes="#{node[:sein][:doctrine_autogenerate_classes]}" \
-Dapplication.mongodb_host="#{node[:sein][:mongodb_host]}" \
-Dapplication.mongodb_port="#{node[:sein][:mongodb_port]}" \
-Dapplication.mongodb_db="#{node[:sein][:mongodb_db]}" \
-Dapplication.mongodb_user="#{node[:sein][:mongodb_user]}" \
-Dapplication.mongodb_pass="#{node[:sein][:mongodb_pass]}" \
-Dapplication.mongodb_pass="#{node[:sein][:gearman_servers]}" 
}
  user "vagrant"
  group "vagrant"
  cwd node[:sein][:project_root]
  environment ({"COMPOSER_HOME" => COMPOSER_HOME})
end

template "/home/vagrant/.zf.ini" do
	source ".zf.ini.erb"
	user "vagrant"
	group "vagrant"
end