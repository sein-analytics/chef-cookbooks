include_recipe "sudo"

sudo "seinworkers" do
	user "zend"
	runas "root"
	nopasswd true
	commands ["/usr/bin/supervisorctl restart seinworkers\\:"]
end