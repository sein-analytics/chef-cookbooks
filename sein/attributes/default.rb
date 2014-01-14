default[:sein][:project_root]					= '/vagrant_data'
default[:sein][:server_name]					= 'sein.vagrant'
default[:sein][:server_aliases]					= ['sein']

default[:sein][:display_startup_errors] 		= 0
default[:sein][:display_errors] 				= 0
default[:sein][:display_exceptions] 			= 0

# SMTP settings
default[:sein][:smtp_host] 						= "smtp.gmail.com"
default[:sein][:smtp_auth] 						= "login"
default[:sein][:smtp_username] 					= "samuel.okunde@gmail.com"
default[:sein][:smtp_password] 					= "Xd8O$F:/22|)_T"
default[:sein][:smtp_ssl] 						= "ssl"
default[:sein][:smtp_port] 						= "465"

# Default database settings (ZF data table)
default[:sein][:default_db_adapter] 			= 'PDO_MYSQL'
default[:sein][:default_db_host] 				= ''
default[:sein][:default_db_username] 			= ''
default[:sein][:default_db_password] 			= ''
default[:sein][:default_db_name] 				= ''
default[:sein][:default_db_socket] 				= ''

# Deals database
default[:sein][:deal_db_driver] 				= 'pdo_mysql'
default[:sein][:deal_db_host] 					= ''
default[:sein][:deal_db_port] 					= ''
default[:sein][:deal_db_user] 					= ''
default[:sein][:deal_db_password] 				= ''

# Doctrine
default[:sein][:doctrine_db_driver] 			= 'pdo_mysql'
default[:sein][:doctrine_db_name] 				= ''
default[:sein][:doctrine_db_host] 				= ''
default[:sein][:doctrine_db_port] 				= ''
default[:sein][:doctrine_db_user] 				= ''
default[:sein][:doctrine_db_password] 			= ''
default[:sein][:doctrine_db_socket] 			= ''

default[:sein][:doctrine_cache_adapter_class]	= 'Doctrine\Common\Cache\ArrayCache'
default[:sein][:doctrine_autogenerate_classes]  = 'true'