#
# Cookbook:: jmier_tomcat
# Recipe:: tomcat
#
# Copyright:: 2021, The Authors, All Rights Reserved.

package node['jmier_tomcat']['package_name'] do
  action :install
end

group node['jmier_tomcat']['group'] do
  action :create
end

user node['jmier_tomcat']['user']['name'] do
  action :create
  node['jmier_tomcat']['group']
  home node['jmier_tomcat']['user']['home']
  shell node['jmier_tomcat']['user']['shell']
  gid node['jmier_tomcat']['group'] 
end

remote_file "/tmp/#{node['jmier_tomcat']['tomcat_tar_file']}" do
  action :create
  source node['jmier_tomcat']['tomcat_tar_url']
  owner 'root'
  group 'tomcat'
  mode '0755'
end

archive_file 'untar tomcat tarball' do
  action :extract
  destination '/opt/tomcat/'
  path "/tmp/#{node['jmier_tomcat']['tomcat_tar_file']}"
  strip_components 1
end

# change group permissions recursively to /opt/tomcat
execute 'change everything in /opt/tomcat to tomcat group' do
  action :run
  command 'chgrp -R tomcat /opt/tomcat'
  not_if '[ $(stat -c %G /opt/tomcat/)  = "tomcat" ]'
end

# add read permissions recursively to /opt/tomcat/conf and execute permissions
execute 'Add group read(recursive)/execute permissions to /opt/tomcat/conf' do
  action :run
  command 'chmod -R g+r /opt/tomcat/conf && chmod g+x /opt/tomcat/conf'
  not_if '[ $(stat -c %a /opt/tomcat/conf | awk \'{print substr($1,2,1)}\' ) = "5" ]'
end

# loop through directories in /opt/tomcat to change ownership to tomcat
node['jmier_tomcat']['tomcat_directories'].each do |dir|
  execute "/opt/tomcat/#{dir}" do
    action :run
    command "chown -R tomcat /opt/tomcat/#{dir}"
    not_if "[ $(stat -c %U /opt/tomcat/#{dir})  = 'tomcat' ]"
  end
end

execute 'systemctl daemon-reload' do
  action :nothing
  command 'systemctl daemon-reload'
end

template '/etc/systemd/system/tomcat.service' do
  action :create
  source 'tomcat.service.erb'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
  notifies :restart, 'service[tomcat]'
end

service 'tomcat' do
  action [:start, :enable]
end
