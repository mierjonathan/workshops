#
# Cookbook:: jmier_mongodb
# Spec:: yum_repo
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'jmier_mongodb::yum_repo' do
  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates yum repository mongodb' do
      expect(chef_run).to create_yum_repository('mongodb')
    end
  end
end
