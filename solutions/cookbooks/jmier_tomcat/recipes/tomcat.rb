#
# Cookbook:: jmier_tomcat
# Recipe:: tomcat
#
# Copyright:: 2021, The Authors, All Rights Reserved.

package node['tomcat_jmier']['package_name']

group 'tomcat' do
  action :create
end

user 'tomcat' do
  action :create
  gid 'tomcat'
  home '/opt/tomcat'
  shell '/bin/nologin'
end

remote_file '/tmp/apache-tomcat-8.5.73.tar.gz' do
  source 'http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz'
  owner 'root'
  group 'tomcat'
  mode '0755'
  action :create
end

# Always resets permissions back to root:tomcat

# archive_file 'untar tomcat' do
#   destination '/opt/tomcat/'
#   path '/tmp/apache-tomcat-8.5.73.tar.gz'
#   strip_components 1
#   owner 'root'
#   group 'tomcat'
#   not_if '[(stat -c %U /opt/tomcat/webapps) = "tomcat"]'
# end

directory '/opt/tomcat' do
  action :create
end

execute 'extract' do
  command 'tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat/ --strip-components=1'
  cwd '/tmp/'
  only_if '[ -z "$(ls -A /opt/tomcat)" ]'
end

execute 'group tomcat everything ' do
  command 'chgrp -R tomcat /opt/tomcat'
  not_if '[ $(stat -c %G /opt/tomcat/)  = "tomcat" ]'
end

execute 'test' do
  command 'chmod -R g+r /opt/tomcat/conf && chmod g+x /opt/tomcat/conf'
  not_if '[ $(stat -c %a /opt/tomcat/conf | awk \'{print substr($1,2,1)}\' ) = "5" ]'
end

%w(webapps work temp logs).each do |dir|
  execute "/opt/tomcat/#{dir}" do
    command "chown -R tomcat /opt/tomcat/#{dir}"
    not_if "[ $(stat -c %U /opt/tomcat/#{dir})  = 'tomcat' ]"
  end
end

execute 'systemctl daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
  notifies :restart, 'service[tomcat]'
end

service 'tomcat' do
  action [:start, :enable]
end
