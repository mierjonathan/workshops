#
# Cookbook:: jmier_mongodb
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

include_recipe 'jmier_mongodb::yum_repo'
include_recipe 'jmier_mongodb::mongodb'
