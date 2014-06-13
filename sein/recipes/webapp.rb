include_recipe "apache2"

web_app "sein" do
  server_name node['sein']['server_name']
  server_aliases node['sein']['server_aliases']
  docroot "#{node['sein']['phing']['project_root']}/public"
  allow_override 'all'
end

service 'apache2' do
	action :restart
end