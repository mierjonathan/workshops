#
# Cookbook:: jmier_tomcat
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'jmier_tomcat::default' do
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

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
