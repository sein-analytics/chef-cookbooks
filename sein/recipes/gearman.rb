include_recipe "zendserver"

apt_repository "gearman" do
        uri "http://ppa.launchpad.net/gearman-developers/ppa/ubuntu"
        distribution node['lsb']['codename']
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

service "gearman-job-server" do
        action :start
end

package "autoconf" do
        action :install
end

package "build-essential" do
        action :install
end