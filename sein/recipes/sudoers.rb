include_recipe "sudo"

sudo "seinworkers" do
	user "zend"
	runas "root"
	commands ["supervisorctl restart seinworkers:"]
end