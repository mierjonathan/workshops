#
# Cookbook:: jmier_mongodb
# Recipe:: yum_repo
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Creates Yum repo for mongodb 
yum_repository node['jmier_mongodb']['yum_repo']['repo_id'] do
  baseurl node['jmier_mongodb']['yum_repo']['baseurl']
  gpgcheck node['jmier_mongodb']['yum_repo']['gpgcheck']
  enabled node['jmier_mongodb']['yum_repo']['enabled']
end
