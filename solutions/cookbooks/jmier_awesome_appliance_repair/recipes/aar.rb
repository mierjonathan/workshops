#
# Cookbook:: jmier_awesome_appliance_repair
# Recipe:: aar
#
# Copyright:: 2021, The Authors, All Rights Reserved.

directory '/var/www/AAR' do
  owner 'www-data'
  group 'www-data'
  action :create
  recursive true
end

package %w(apache2 python2) do
    action :install
end
