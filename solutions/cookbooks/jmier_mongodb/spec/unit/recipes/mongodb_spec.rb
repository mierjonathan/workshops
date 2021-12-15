#
# Cookbook:: jmier_mongodb
# Spec:: mongodb
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'jmier_mongodb::mongodb' do
  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'
    # let(:chef_run) do
    #   runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7')
    #   runner.converge(described_recipe)
    # end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs package mongodb-org' do
      expect(chef_run).to install_package('mongodb-org')
    end

    it 'starts and enables mongod service' do
      expect(chef_run).to start_service('mongod')
      expect(chef_run).to enable_service('mongod')
    end
  end
end
