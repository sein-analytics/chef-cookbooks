include_recipe "database::mysql"

#force_reload = node['sein']['deals_database']['force_reload']
#load_db      = node['sein']['deals_database']['load_db']
#dbname 		 = node['sein']['deals_database']['name']
root_user    = node['sein']['database']['root_user']
username     = node['sein']['database']['user']
password     = node['sein']['database']['password']
host 		 = node['sein']['database']['host']

mysql_connection = {
	:host => host, 
	:username => root_user, 
	:password => node[:mysql][:server_root_password]
}

# Grant privileges to the username to create _db_manager_database_
['localhost', '%'].each do |h|
	mysql_database_user username do
	  connection mysql_connection
	  password password
	  database_name '_db_manager_database_%'
	  privileges [:all]
	  host h
	  action :grant
	end
end

