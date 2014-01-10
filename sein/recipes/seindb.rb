include_recipe "database::mysql"

force_reload = node['sein']['database']['force_reload']
dbname 		 = node['sein']['database']['name']
username     = node['sein']['database']['user']
password     = node['sein']['database']['password']
host 		 = node['sein']['database']['host']

mysql_connection = {
	:host => host, 
	:username => 'root', 
	:password => node[:mysql][:server_root_password]
}

if force_reload
	mysql_database dbname do
		connection mysql_connection
		action 		:drop
	end
end

mysql_database dbname do
  connection mysql_connection
  action 		:create
end

['localhost', '%'].each do |h|
	mysql_database_user username do
	  connection mysql_connection
	  password password
	  database_name dbname
	  privileges [:all]
	  host h
	  action :grant
	end
end

execute 'load database' do
	command "gunzip -c /vagrant_data/devops/resources/data_dump/zfia.sql.gz | mysql -u#{username} -p#{password} -h#{host} #{dbname}"
	only_if {
		force_reload || shell_out("mysql -u root -p#{node[:mysql][:server_root_password]} -e 'SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = \"#{dbname}\"\\G'").stdout.match(/COUNT\(\*\): (?<tables>\d+)/)['tables'].to_i < 0
	}
end
