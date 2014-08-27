include_recipe "sein::synapse"

dbname = node[:opsworks][:instance][:layers].join("_")

node.set[:zendserver][:dbname] = dbname

include_recipe "zendserver::unjoincluster"