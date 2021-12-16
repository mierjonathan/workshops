# InSpec test for recipe jmier_tomcat::tomcat

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe package('java-1.7.0-openjdk-devel') do
  it { should be_installed }
end

describe group('tomcat') do
  it { should exist }
end

describe user('tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
  its('home') { should eq '/opt/tomcat' }
  its('shell') { should eq '/bin/nologin' }
end

describe file('/tmp/apache-tomcat-8.5.73.tar.gz') do
  it { should exist }
end

describe directory('/opt/tomcat') do
  it { should exist }
  its('group') { should eq 'tomcat' }
end

describe directory('/opt/tomcat/conf') do
  it { should exist }
  its('group') { should eq 'tomcat' }
  its('mode') { should cmp '0750' }
end

%w(webapps work temp logs).each do |dir|
  describe directory("/opt/tomcat/#{dir}") do
    it { should exist }
    its('owner') { should eq 'tomcat' }
  end
end

describe file('/etc/systemd/system/tomcat.service') do
  it { should exist }
end

describe service('tomcat') do
  it { should be_enabled }
  it { should be_running }
end

describe command('curl http://localhost:8080') do
  its('exit_status') { should eq 0 }
end
