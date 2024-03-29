#
# Cookbook Name:: apache2
# Attributes:: apache
#
# Copyright 2008-2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 13.10
  default['apache']['version'] = '2.4'
elsif node['platform'] == 'debian' && node['platform_version'].to_f >= 8.0
  default['apache']['version'] = '2.4'
elsif node['platform'] == 'centos' && node['platform_version'].to_f >= 7.0
  default['apache']['version'] = '2.4'
elsif node['platform'] == 'fedora' && node['platform_version'].to_f >= 18
  default['apache']['version'] = '2.4'
elsif node['platform'] == 'opensuse' && node['platform_version'].to_f >= 13.1
  default['apache']['version'] = '2.4'
else
  default['apache']['version'] = '2.2'
end

default['apache']['root_group'] = 'root'

default['apache']['default_site_name'] = 'default'

# Where the various parts of apache are
case node['platform']
when 'redhat', 'centos', 'scientific', 'fedora', 'amazon', 'oracle'
  default['apache']['package']     = 'httpd'
  default['apache']['perl_pkg']    = 'perl'
  default['apache']['apachectl']   = '/usr/sbin/apachectl'
  default['apache']['dir']         = '/etc/httpd'
  default['apache']['log_dir']     = '/var/log/httpd'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'apache'
  default['apache']['group']       = 'apache'
  default['apache']['binary']      = '/usr/sbin/httpd'
  default['apache']['conf_dir']    = '/etc/httpd/conf'
  default['apache']['docroot_dir'] = '/var/www/html'
  default['apache']['cgibin_dir']  = '/var/www/cgi-bin'
  default['apache']['icondir']     = '/var/www/icons'
  default['apache']['cache_dir']   = '/var/cache/httpd'
  default['apache']['run_dir']     = '/var/run/httpd'
  default['apache']['lock_dir']    = '/var/run/httpd'
  default['apache']['pid_file']    = if node['platform_version'].to_f >= 6
                                       '/var/run/httpd/httpd.pid'
                                     else
                                       '/var/run/httpd.pid'
                                     end
  default['apache']['lib_dir']     = node['kernel']['machine'] =~ /^i[36]86$/ ? '/usr/lib/httpd' : '/usr/lib64/httpd'
  default['apache']['libexec_dir']  = "#{node['apache']['lib_dir']}/modules"
  default['apache']['default_site_enabled'] = false
when 'suse', 'opensuse'
  default['apache']['package']     = 'apache2'
  default['apache']['perl_pkg']    = 'perl'
  default['apache']['apachectl']   = '/usr/sbin/apache2ctl'
  default['apache']['dir']         = '/etc/apache2'
  default['apache']['log_dir']     = '/var/log/apache2'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'wwwrun'
  default['apache']['group']       = 'www'
  default['apache']['binary']      = '/usr/sbin/httpd2'
  default['apache']['docroot_dir'] = '/srv/www/htdocs'
  default['apache']['cgibin_dir']  = '/srv/www/cgi-bin'
  default['apache']['icondir']     = '/usr/share/apache2/icons'
  default['apache']['cache_dir']   = '/var/cache/apache2'
  if node['platform_version'].to_f >= 6
    default['apache']['pid_file']    = '/var/run/httpd/httpd.pid'
  else
    default['apache']['pid_file']    = '/var/run/httpd.pid'
  end
  default['apache']['lib_dir']     = node['kernel']['machine'] =~ /^i[36]86$/ ? '/usr/lib/apache2' : '/usr/lib64/apache2'
  default['apache']['libexec_dir'] = node['apache']['lib_dir']
  default['apache']['default_site_enabled'] = false
when 'debian', 'ubuntu'
  default['apache']['package']     = 'apache2'
  default['apache']['perl_pkg']    = 'perl'
  default['apache']['apachectl']   = '/usr/sbin/apache2ctl'
  default['apache']['dir']         = '/etc/apache2'
  default['apache']['log_dir']     = '/var/log/apache2'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'www-data'
  default['apache']['group']       = 'www-data'
  default['apache']['binary']      = '/usr/sbin/apache2'
  default['apache']['conf_dir']    = '/etc/apache2'
  default['apache']['docroot_dir'] = '/var/www'
  default['apache']['cgibin_dir']  = '/usr/lib/cgi-bin'
  default['apache']['icondir']     = '/usr/share/apache2/icons'
  default['apache']['cache_dir']   = '/var/cache/apache2'
  default['apache']['run_dir']     = '/var/run/apache2'
  default['apache']['lock_dir']    = '/var/lock/apache2'
  # this should use COOK-3917 to educate the initscript of the pid location
  if node['apache']['version'] == '2.4'
    default['apache']['pid_file']    = '/var/run/apache2/apache2.pid'
  else
    default['apache']['pid_file']    = '/var/run/apache2.pid'
  end
  default['apache']['lib_dir']     = '/usr/lib/apache2'
  default['apache']['libexec_dir']  = "#{node['apache']['lib_dir']}/modules"
  default['apache']['default_site_enabled'] = false
  default['apache']['default_site_name'] = '000-default'
when 'arch'
  default['apache']['package']     = 'apache'
  default['apache']['perl_pkg']    = 'perl'
  # default['apache']['apachectl']   = '/usr/sbin/apachectl'
  default['apache']['dir']         = '/etc/httpd'
  default['apache']['log_dir']     = '/var/log/httpd'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'http'
  default['apache']['group']       = 'http'
  default['apache']['binary']      = '/usr/sbin/httpd'
  default['apache']['conf_dir']    = '/etc/httpd'
  default['apache']['docroot_dir'] = '/srv/http'
  default['apache']['cgibin_dir']  = '/usr/share/httpd/cgi-bin'
  default['apache']['icondir']     = '/usr/share/httpd/icons'
  default['apache']['cache_dir']   = '/var/cache/httpd'
  default['apache']['run_dir']     = '/var/run/httpd'
  default['apache']['lock_dir']    = '/var/run/httpd'
  default['apache']['pid_file']    = '/var/run/httpd/httpd.pid'
  default['apache']['lib_dir']     = '/usr/lib/httpd'
  default['apache']['libexec_dir']  = "#{node['apache']['lib_dir']}/modules"
  default['apache']['default_site_enabled'] = false
when 'freebsd'
  if node['apache']['version'] == '2.4'
    default['apache']['package']     = 'apache24'
    default['apache']['dir']         = '/usr/local/etc/apache24'
    default['apache']['conf_dir']    = '/usr/local/etc/apache24'
    default['apache']['docroot_dir'] = '/usr/local/www/apache24/data'
    default['apache']['cgibin_dir']  = '/usr/local/www/apache24/cgi-bin'
    default['apache']['icondir']     = '/usr/local/www/apache24/icons'
    default['apache']['cache_dir']   = '/var/run/apache24'
    default['apache']['run_dir']     = '/var/run/apache24'
    default['apache']['lock_dir']    = '/var/run/apache24'
    default['apache']['lib_dir']     = '/usr/local/libexec/apache24'
  else
    default['apache']['package']     = 'apache22'
    default['apache']['dir']         = '/usr/local/etc/apache22'
    default['apache']['conf_dir']    = '/usr/local/etc/apache22'
    default['apache']['docroot_dir'] = '/usr/local/www/apache22/data'
    default['apache']['cgibin_dir']  = '/usr/local/www/apache22/cgi-bin'
    default['apache']['icondir']     = '/usr/local/www/apache22/icons'
    default['apache']['cache_dir']   = '/var/run/apache22'
    default['apache']['run_dir']     = '/var/run/apache22'
    default['apache']['lock_dir']    = '/var/run/apache22'
    default['apache']['lib_dir']     = '/usr/local/libexec/apache22'
  end
  default['apache']['perl_pkg']    = 'perl5'
  default['apache']['apachectl']   = '/usr/local/sbin/apachectl'
  default['apache']['pid_file']    = '/var/run/httpd.pid'
  default['apache']['log_dir']     = '/var/log'
  default['apache']['error_log']   = 'httpd-error.log'
  default['apache']['access_log']  = 'httpd-access.log'
  default['apache']['root_group']  = 'wheel'
  default['apache']['user']        = 'www'
  default['apache']['group']       = 'www'
  default['apache']['binary']      = '/usr/local/sbin/httpd'
  default['apache']['libexec_dir']  = node['apache']['lib_dir']
  default['apache']['default_site_enabled'] = false
else
  default['apache']['dir']         = '/etc/apache2'
  default['apache']['log_dir']     = '/var/log/apache2'
  default['apache']['error_log']   = 'error.log'
  default['apache']['access_log']  = 'access.log'
  default['apache']['user']        = 'www-data'
  default['apache']['group']       = 'www-data'
  default['apache']['binary']      = '/usr/sbin/apache2'
  default['apache']['docroot_dir'] = '/var/www'
  default['apache']['cgibin_dir']  = '/usr/lib/cgi-bin'
  default['apache']['icondir']     = '/usr/share/apache2/icons'
  default['apache']['cache_dir']   = '/var/cache/apache2'
  default['apache']['run_dir']     = 'logs'
  default['apache']['lock_dir']    = 'logs'
  default['apache']['pid_file']    = 'logs/httpd.pid'
  default['apache']['lib_dir']     = '/usr/lib/apache2'
  default['apache']['libexec_dir']  = "#{node['apache']['lib_dir']}/modules"
  default['apache']['default_site_enabled'] = false
end

###
# These settings need the unless, since we want them to be tunable,
# and we don't want to override the tunings.
###

# General settings
default['apache']['listen_addresses']  = %w(*)
default['apache']['listen_ports']      = %w(80)
default['apache']['contact']           = 'ops@example.com'
default['apache']['timeout']           = 300
default['apache']['keepalive']         = 'On'
default['apache']['keepaliverequests'] = 100
default['apache']['keepalivetimeout']  = 5
default['apache']['sysconfig_additional_params'] = {}

# Security
default['apache']['servertokens']    = 'Prod'
default['apache']['serversignature'] = 'On'
default['apache']['traceenable']     = 'On'

# mod_auth_openids
default['apache']['allowed_openids'] = []

# mod_status Allow list, space seprated list of allowed entries.
default['apache']['status_allow_list'] = '127.0.0.1 ::1'

# mod_status ExtendedStatus, set to 'true' to enable
default['apache']['ext_status'] = false

# mod_info Allow list, space seprated list of allowed entries.
default['apache']['info_allow_list'] = '127.0.0.1 ::1'

default['apache']['mpm'] = 'prefork'
# Prefork Attributes
default['apache']['prefork']['startservers']        = 16
default['apache']['prefork']['minspareservers']     = 16
default['apache']['prefork']['maxspareservers']     = 32
default['apache']['prefork']['serverlimit']         = 400
default['apache']['prefork']['maxclients']          = 400
default['apache']['prefork']['maxrequestsperchild'] = 10_000
default['apache']['prefork']['maxrequestworkers']   = 150
default['apache']['prefork']['maxconnectionsperchild'] = 0

# Worker Attributes
default['apache']['worker']['startservers']        = 4
default['apache']['worker']['serverlimit']         = 16
default['apache']['worker']['maxclients']          = 1024
default['apache']['worker']['minsparethreads']     = 64
default['apache']['worker']['maxsparethreads']     = 192
default['apache']['worker']['threadlimit']         = 192
default['apache']['worker']['threadsperchild']     = 64
default['apache']['worker']['maxrequestsperchild'] = 0
default['apache']['worker']['maxrequestworkers']   = 150
default['apache']['worker']['maxconnectionsperchild'] = 0

# Event Attributes
default['apache']['event']['startservers']        = 4
default['apache']['event']['serverlimit']         = 16
default['apache']['event']['maxclients']          = 1024
default['apache']['event']['minsparethreads']     = 64
default['apache']['event']['maxsparethreads']     = 192
default['apache']['event']['threadlimit']         = 192
default['apache']['event']['threadsperchild']     = 64
default['apache']['event']['maxrequestsperchild'] = 0
default['apache']['event']['maxrequestworkers']   = 150
default['apache']['event']['maxconnectionsperchild'] = 0

# ITK Attributes
default['apache']['itk']['startservers']        = 16
default['apache']['itk']['minspareservers']     = 16
default['apache']['itk']['maxspareservers']     = 32
default['apache']['itk']['maxrequestworkers']   = 150
default['apache']['itk']['maxconnectionsperchild'] = 0

# mod_proxy settings
default['apache']['proxy']['order']      = 'deny,allow'
default['apache']['proxy']['deny_from']  = 'all'
default['apache']['proxy']['allow_from'] = 'none'

# Default modules to enable via include_recipe
default['apache']['default_modules'] = %w(
  status alias auth_basic authn_core authn_file authz_core authz_groupfile
  authz_host authz_user autoindex dir env mime negotiation setenvif
)

%w(log_config logio).each do |log_mod|
  default['apache']['default_modules'] << log_mod if %w(rhel fedora suse arch freebsd).include?(node['platform_family'])
end

if node['apache']['version'] == '2.4'
  %w(unixd).each do |unix_mod|
    default['apache']['default_modules'] << unix_mod if %w(rhel fedora suse arch freebsd).include?(node['platform_family'])
  end
end
