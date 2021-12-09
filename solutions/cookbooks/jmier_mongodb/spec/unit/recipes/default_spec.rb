#
# Cookbook:: jmier_mongodb
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'jmier_mongodb::default' do
  context 'When all attributes are default, on CentOS 7' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'centos', '7'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes recipes yum_repo and mongodb' do
      expect(chef_run).to include_recipe('jmier_mongodb::yum_repo')
      expect(chef_run).to include_recipe('jmier_mongodb::mongodb')
    end
  end
end
