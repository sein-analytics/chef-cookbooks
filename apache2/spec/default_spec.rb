require 'spec_helper'

# examples at https://github.com/sethvargo/chefspec/tree/master/examples

describe 'apache2::default' do
  before do
    allow(::File).to receive(:symlink?).and_return(false)
  end

  # Test all defaults on all platforms
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::Runner.new(:platform => platform, :version => version) do
          end.converge(described_recipe)
        end
        property = load_platform_properties(:platform => platform, :platform_version => version)

        before do
          stub_command("#{property[:apache][:binary]} -t").and_return(true)
        end

        it "installs package #{property[:apache][:package]}" do
          expect(chef_run).to install_package(property[:apache][:package])
        end

        it "creates #{property[:apache][:log_dir]} directory" do
          expect(chef_run).to create_directory(property[:apache][:log_dir]).with(
            :mode => '0755'
          )

          expect(chef_run).to_not create_directory(property[:apache][:log_dir]).with(
            :mode => '0777'
          )
        end

        it "deletes #{property[:apache][:dir]}/conf.d" do
          expect(chef_run).to delete_directory("#{property[:apache][:dir]}/conf.d").with(:recursive => true)
          expect(chef_run).to_not delete_file("#{property[:apache][:dir]}/conf.d").with(:recursive => false)
        end

        %w(sites-available sites-enabled mods-available mods-enabled conf-enabled conf-available).each do |dir|
          it "creates #{property[:apache][:dir]}/#{dir} directory" do
            expect(chef_run).to create_directory("#{property[:apache][:dir]}/#{dir}").with(
              :mode => '0755',
              :owner => 'root',
              :group => property[:apache][:root_group]
            )

            expect(chef_run).to_not create_directory("#{property[:apache][:dir]}/#{dir}").with(
              :mode => '0777'
            )
          end
        end

        it "installs package #{property[:apache][:perl_pkg]}" do
          expect(chef_run).to install_package(property[:apache][:perl_pkg])
        end

        if %w(redhat centos fedora arch suse freebsd).include?(platform)
          it 'creates /usr/local/bin/apache2_module_conf_generate.pl' do
            expect(chef_run).to create_cookbook_file('/usr/local/bin/apache2_module_conf_generate.pl').with(
              :mode =>  '0755',
              :owner => 'root',
              :group => property[:apache][:root_group]
            )
            expect(chef_run).to_not create_cookbook_file('/usr/bin/apache2_module_conf_generate.pl')
          end

          it 'runs a execute[generate-module-list] with :nothing action' do
            # .with(
            #  command: "/usr/local/bin/apache2_module_conf_generate.pl #{property[:apache][:lib_dir]} #{property[:apache][:dir]}/mods-available"
            # )
            execute = chef_run.execute('generate-module-list')
            expect(execute).to do_nothing
          end

          %w(a2ensite a2dissite a2enmod a2dismod a2enconf a2disconf).each do |modscript|
            it "creates /usr/sbin/#{modscript}" do
              expect(chef_run).to create_template("/usr/sbin/#{modscript}")
            end
          end

          it 'includes the `apache2::mod_deflate` recipe' do
            expect(chef_run).to include_recipe('apache2::mod_deflate')
          end
        end

        it "creates #{property[:apache][:conf]}" do
          expect(chef_run).to create_template(property[:apache][:conf]).with(
            :source => 'apache2.conf.erb',
            :owner => 'root',
            :group => property[:apache][:root_group],
            :mode =>  '0644'
          )
        end

        subject(:apacheconf) { chef_run.template(property[:apache][:conf]) }
        it "notification is triggered by #{property[:apache][:conf]} template to reload service[apache2]" do
          expect(apacheconf).to notify('service[apache2]').to(:reload).delayed
          expect(apacheconf).to_not notify('service[apache2]').to(:reload).immediately
        end

        if %w(debian ubuntu).include?(platform)
          it "creates #{property[:apache][:dir]}/envvars" do
            expect(chef_run).to create_template("#{property[:apache][:dir]}/envvars").with(
              :source => 'envvars.erb',
              :owner => 'root',
              :group => property[:apache][:root_group],
              :mode =>  '0644'
            )
          end

          subject(:envvars) { chef_run.template("#{property[:apache][:dir]}/envvars") }
          it "notification is triggered by #{property[:apache][:dir]}/envvars template to reload service[apache2]" do
            expect(envvars).to notify('service[apache2]').to(:reload).delayed
            expect(envvars).to_not notify('service[apache2]').to(:reload).immediately
          end
        else
          it "does not create #{property[:apache][:dir]}/envvars" do
            expect(chef_run).to_not create_template("#{property[:apache][:dir]}/envvars").with(
              :source => 'envvars.erb',
              :owner => 'root',
              :group => property[:apache][:root_group],
              :mode =>  '0644'
            )
          end
        end

        %w(security charset).each do |config|
          it "deletes #{property[:apache][:dir]}/conf-available/#{config}" do
            expect(chef_run).to delete_file("#{property[:apache][:dir]}/conf-available/#{config}")
          end

          it "creates #{property[:apache][:dir]}/conf-available/#{config}.conf" do
            expect(chef_run).to create_template("#{property[:apache][:dir]}/conf-available/#{config}.conf").with(
              :source => "#{config}.conf.erb",
              :owner => 'root',
              :group => property[:apache][:root_group],
              :mode =>  '0644',
              :backup =>  false
            )
          end

          it " runs a2enconf #{config}.conf" do
            stub_command("/usr/sbin/a2enconf #{config}.conf").and_return(false)
            expect(chef_run).to run_execute("/usr/sbin/a2enconf #{config}.conf")
          end

          subject(:confd) { chef_run.template("#{property[:apache][:dir]}/conf-available/#{config}.conf") }
          it "notification is triggered by #{property[:apache][:dir]}/conf-available/#{config}.conf template to reload service[apache2]" do
            expect(confd).to notify('service[apache2]').to(:reload).delayed
            expect(confd).to_not notify('service[apache2]').to(:reload).immediately
          end
        end

        it "deletes #{property[:apache][:dir]}/ports" do
          expect(chef_run).to delete_file("#{property[:apache][:dir]}/ports")
        end

        it "creates #{property[:apache][:dir]}/ports.conf" do
          expect(chef_run).to create_template("#{property[:apache][:dir]}/ports.conf").with(
            :source => 'ports.conf.erb',
            :owner => 'root',
            :group => property[:apache][:root_group],
            :mode =>  '0644'
          )
        end

        subject(:portsconf) { chef_run.template("#{property[:apache][:dir]}/ports.conf") }
        it "notification is triggered by #{property[:apache][:dir]}/ports.conf template to reload service[apache2]" do
          expect(portsconf).to notify('service[apache2]').to(:reload).delayed
          expect(portsconf).to_not notify('service[apache2]').to(:reload).immediately
        end

        it "creates #{property[:apache][:dir]}/sites-available/default.conf" do
          expect(chef_run).to create_template("#{property[:apache][:dir]}/sites-available/default.conf").with(
            :source => 'default-site.conf.erb',
            :owner => 'root',
            :group => property[:apache][:root_group],
            :mode =>  '0644'
          )
        end

        if %w(redhat centos fedora).include?(platform)
          it 'creates /etc/sysconfig/httpd' do
            expect(chef_run).to create_template('/etc/sysconfig/httpd').with(
              :source => 'etc-sysconfig-httpd.erb',
              :owner => 'root',
              :group => property[:apache][:root_group],
              :mode =>  '0644'
            )
          end
        end

        if platform == 'freebsd'
          it "deletes #{property[:apache][:dir]}/Includes" do
            expect(chef_run).to delete_directory("#{property[:apache][:dir]}/Includes")
          end

          it "deletes #{property[:apache][:dir]}/extra" do
            expect(chef_run).to delete_directory("#{property[:apache][:dir]}/extra")
          end
        end
        %W(
          #{property[:apache][:dir]}/ssl
          #{property[:apache][:cache_dir]}
        ).each do |path|
          it "creates #{path} directory" do
            expect(chef_run).to create_directory(path).with(
              :mode => '0755',
              :owner => 'root',
              :group => property[:apache][:root_group]
            )
          end
        end

        property[:apache][:default_modules].each do |mod|
          module_recipe_name = mod =~ /^mod_/ ? mod : "mod_#{mod}"
          it "includes the `apache2::#{module_recipe_name}` recipe" do
            expect(chef_run).to include_recipe("apache2::#{module_recipe_name}")
          end
        end

        it "deletes #{property[:apache][:dir]}/sites-available/default" do
          expect(chef_run).to delete_file("#{property[:apache][:dir]}/sites-available/default")
        end

        it "deletes #{property[:apache][:dir]}/sites-enabled/000-default" do
          expect(chef_run).to delete_file("#{property[:apache][:dir]}/sites-enabled/000-default")
        end

        context 'with invalid apache configuration' do
          before do
            stub_command("#{property[:apache][:binary]} -t").and_return(false)
          end

          it 'does not enable/start apache2 service' do
            expect(chef_run).to_not enable_service('apache2').with(
              :service_name => property[:apache][:service_name],
              :restart_command => property[:apache][:service_restart_command],
              :reload_command => property[:apache][:service_reload_command],
              :supports => { :start => true, :restart => true, :reload => true, :status => true },
              :action => [:enable, :start]
            )
          end
        end

        it 'enables and starts the apache2 service' do
          expect(chef_run).to enable_service('apache2').with(
            :service_name => property[:apache][:service_name],
            :restart_command => property[:apache][:service_restart_command],
            :reload_command => property[:apache][:service_reload_command],
            :supports => { :start => true, :restart => true, :reload => true, :status => true },
            :action => [:enable, :start]
          )
        end
      end
    end
  end
end