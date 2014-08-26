dbname = node[:opsworks][:instance][:layers].join("_")

node.set[:zendserver][:dbname] = dbname

include_recipe "sein::zendserver"