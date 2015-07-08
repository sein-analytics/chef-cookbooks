directory "/opt/sein" do
  recursive true
  action :create
end


link "/opt/sein/current" do
    to node[:sein][:phing][:project_root]
    notifies :restart, 'service[supervisor]', :delayed
end
