#
# Cookbook:: jmier_mongodb
# Recipe:: mongodb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Installs mongodb package
package node['jmier_mongodb']['mongodb']['package_name'] do
  action :install
end

# Enables and starts mongodb service
service node['jmier_mongodb']['mongodb']['service_name'] do
  action [:start, :enable]
end
