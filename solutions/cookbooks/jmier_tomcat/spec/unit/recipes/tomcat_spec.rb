#
# Cookbook:: jmier_tomcat
# Spec:: tomcat
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'jmier_tomcat::tomcat' do
  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'

    before do
      stub_command('[ $(stat -c %G /opt/tomcat/)  = "tomcat" ]').and_return(false)
      stub_command("[ $(stat -c %a /opt/tomcat/conf | awk \'{print substr($1,2,1)}\' ) = \"5\" ]").and_return(false)
      stub_command("[ $(stat -c %U /opt/tomcat/webapps)  = 'tomcat' ]").and_return(false)
      stub_command("[ $(stat -c %U /opt/tomcat/work)  = 'tomcat' ]").and_return(false)
      stub_command("[ $(stat -c %U /opt/tomcat/temp)  = 'tomcat' ]").and_return(false)
      stub_command("[ $(stat -c %U /opt/tomcat/logs)  = 'tomcat' ]").and_return(false)
    end

    # it 'converges successfully' do
    #   expect { chef_run }.to_not raise_error
    # end

    it 'installs java openjdk' do
      expect(chef_run).to install_package('java-1.7.0-openjdk-devel')
    end

    it 'create group tomcat' do
      expect(chef_run).to create_group('tomcat')
    end

    it 'create user tomcat' do
      expect(chef_run).to create_user('tomcat').with(
        gid: 'tomcat',
        home: '/opt/tomcat',
        shell: '/bin/nologin'
      )
    end

    it 'create file /tmp/apache-tomcat-8.5.73.tar.gz' do
      expect(chef_run).to create_remote_file('/tmp/apache-tomcat-8.5.73.tar.gz')
    end

    it 'change everything in /opt/tomcat to tomcat group' do
      expect(chef_run).to run_execute('change everything in /opt/tomcat to tomcat group')
    end

    it 'Add group read(recursive)/execute permissions to /opt/tomcat/conf' do
      expect(chef_run).to run_execute('Add group read(recursive)/execute permissions to /opt/tomcat/conf')
    end

    it 'make tomcat owner of /opt/tomcat/webapps' do
      expect(chef_run).to run_execute('make tomcat owner of /opt/tomcat/webapps')
    end

    it 'make tomcat owner of /opt/tomcat/work' do
      expect(chef_run).to run_execute('make tomcat owner of /opt/tomcat/work')
    end

    it 'make tomcat owner of /opt/tomcat/temp' do
      expect(chef_run).to run_execute('make tomcat owner of /opt/tomcat/temp')
    end

    it 'make tomcat owner of /opt/tomcat/logs' do
      expect(chef_run).to run_execute('make tomcat owner of /opt/tomcat/logs')
    end

    it 'create file /etc/systemd/system/tomcat.service' do
      expect(chef_run).to create_template('/etc/systemd/system/tomcat.service')
    end

    it 'start and enable tomcat service' do
      expect(chef_run).to start_service('tomcat')
      expect(chef_run).to enable_service('tomcat')
    end
  end
end
