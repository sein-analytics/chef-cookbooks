include_recipe "zendserver"

zendserver_pear_channel "pear.phing.info" do
	action :discover
end

zendserver_pear "phing" do
	channel "pear.phing.info"
	action :install
end