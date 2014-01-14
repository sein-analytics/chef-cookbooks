include_recipe "phpmyadmin"

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