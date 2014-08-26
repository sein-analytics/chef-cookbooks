default[:sein][:server_name]					= 'sein.vagrant'
default[:sein][:server_aliases]					= ['sein']
default[:sein][:zend_server][:cluster]			= false

default[:sein][:phing][:project_root]					= '/vagrant_data'

default[:sein][:phing][:display_startup_errors] 		= 0
default[:sein][:phing][:display_errors] 				= 0
default[:sein][:phing][:display_exceptions] 			= 0

# SMTP settings
default[:sein][:phing][:smtp_host] 						= "smtp.gmail.com"
default[:sein][:phing][:smtp_auth] 						= "login"
default[:sein][:phing][:smtp_username] 					= "samuel.okunde@gmail.com"
default[:sein][:phing][:smtp_password] 					= "Xd8O$F:/22|)_T"
default[:sein][:phing][:smtp_ssl] 						= "ssl"
default[:sein][:phing][:smtp_port] 						= "465"

# Default database settings (ZF data table)
default[:sein][:phing][:default_db_adapter] 			= 'PDO_MYSQL'
default[:sein][:phing][:default_db_host] 				= ''
default[:sein][:phing][:default_db_username] 			= ''
default[:sein][:phing][:default_db_password] 			= ''
default[:sein][:phing][:default_db_name] 				= ''
default[:sein][:phing][:default_db_socket] 				= ''

# Deals database
default[:sein][:phing][:deal_db_driver] 				= 'pdo_mysql'
default[:sein][:phing][:deal_db_host] 					= ''
default[:sein][:phing][:deal_db_port] 					= ''
default[:sein][:phing][:deal_db_user] 					= ''
default[:sein][:phing][:deal_db_password] 				= ''

# Doctrine
default[:sein][:phing][:doctrine_db_driver] 			= 'pdo_mysql'
default[:sein][:phing][:doctrine_db_name] 				= ''
default[:sein][:phing][:doctrine_db_host] 				= ''
default[:sein][:phing][:doctrine_db_port] 				= ''
default[:sein][:phing][:doctrine_db_user] 				= ''
default[:sein][:phing][:doctrine_db_password] 			= ''
default[:sein][:phing][:doctrine_db_socket] 			= ''

default[:sein][:phing][:mongodb_host] 					= ''
default[:sein][:phing][:mongodb_port] 					= ''
default[:sein][:phing][:mongodb_db] 					= ''
default[:sein][:phing][:mongodb_user] 					= ''
default[:sein][:phing][:mongodb_pass] 					= ''

default[:sein][:phing][:gearman_servers]				= '127.0.0.1:4730'

default[:sein][:phing][:doctrine_cache_adapter_class]	= 'Doctrine\Common\Cache\ArrayCache'
default[:sein][:phing][:doctrine_autogenerate_classes]  = 'true'

default[:sein][:phpmyadmin_composer][:home] = "/opt/phpmyadmin"