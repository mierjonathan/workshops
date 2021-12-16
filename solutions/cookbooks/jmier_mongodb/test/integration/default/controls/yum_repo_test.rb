# InSpec test for recipe jmier_mongodb::yum_repo

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe yum.repo('mongodb') do
  it { should exist }
  it { should be_enabled }
end
