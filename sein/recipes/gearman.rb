apt_repository "gearman" do
        uri "http://ppa.launchpad.net/gearman-developers/ppa/ubuntu"
        # distribution node['lsb']['codename']
        distribution "raring" # At time of writing, ppa gearman does not have a trusty variant
        components ["main"]
        keyserver "keyserver.ubuntu.com"
        key "1C73E014"
        action :add
end

package "gearman" do
        action :install
end

package "gearman-job-server" do
        action :install
end

package "gearman-tools" do
        action :install
end

package "libgearman-dev" do
        action :install
end

bash "replace listen address" do
    code <<-EOH
sudo sed -i 's/"--listen=.*"/"--listen=0.0.0.0"/' /etc/default/gearman-job-server
EOH
end

service "gearman-job-server" do
    provider Chef::Provider::Service::Upstart
    action :restart
end