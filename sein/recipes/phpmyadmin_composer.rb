include_recipe "composer"

directory "#{node['sein']['phpmyadmin_composer']['home']}" do
	action :create
end

template "/#{node['sein']['phpmyadmin_composer']['home']}/composer.json" do
	source "pma_composer.json.erb"
end

composer_project "#{node['sein']['phpmyadmin_composer']['home']}" do
	dev false
	prefer_dist true
	action :install
end

# update apache conf
web_app "phpmyadmin" do
	template "phpmyadmin_app.erb"
end

template "/#{node['sein']['phpmyadmin_composer']['home']}/vendor/phpmyadmin/phpmyadmin/config.inc.php" do
	source "pma_config.php.erb"
	variables({
		:host => node['sein']['database']['host'],
		:auth_type => 'cookie'
	})
end 