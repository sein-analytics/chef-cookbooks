include_recipe "apache2::default"

begin
  t = resources(:template => "#{node['apache']['dir']}/sites-available/default")
  t.source "default-site-zs.erb"
  t.cookbook "sein"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template #{node['apache']['dir']}/sites-available/default to modify"
end