
# override default cache path, b/c AWS doesn't allow writing by non root in cache folder
temp_path = Chef::Config[:file_cache_path]
Chef::Config[:file_cache_path] = "/tmp"

include_recipe "phpmyadmin"

Chef::Config[:file_cache_path] = temp_path

phpmyadmin_db 'MainDB' do
    host node['sein']['database']['host']
    port 3306
    username 'root'
    password node['sein']['database']['root_password']
    hide_dbs %w{ information_schema mysql phpmyadmin performance_schema }
end

# update apache conf
web_app "phpmyadmin" do
	template "phpmyadmin_app.erb"
end