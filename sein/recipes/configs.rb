COMPOSER_HOME = '/home/vagrant/.composer'

directory "#{node[:sein][:phing][:project_root]}/data/logs" do
	mode 0777
	action :create
	recursive true
end

# create COMPOSER_HOME and set manually 
directory COMPOSER_HOME do
	user "vagrant"
	group "vagrant"
	action :create
end

# ruby_block "build phing" do
# 	block do
	command_phing = lambda {
		command = "/usr/local/zend/bin/phing builddev "
		node[:sein][:phing].each do |name, prop|
		    command += "-D#{name}=\"#{prop}\" " 
 		end

 		return command
 	}

# 	end
# end

# Not using templates to keep process centralized - using Phing for replacements so that CI server can also call task
execute "phing tasks" do
  command command_phing.call
  user "vagrant"
  group "vagrant"
  cwd node[:sein][:phing][:project_root]
  environment ({"COMPOSER_HOME" => COMPOSER_HOME})
end

template "/home/vagrant/.zf.ini" do
	source ".zf.ini.erb"
	user "vagrant"
	group "vagrant"
end