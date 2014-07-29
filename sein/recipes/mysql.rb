include_recipe "mysql::server"

template '/etc/mysql/conf.d/sein.cnf' do
  owner 'mysql'
  owner 'mysql'      
  source 'sein.cnf.erb'
  notifies :restart, 'mysql_service[default]'
end