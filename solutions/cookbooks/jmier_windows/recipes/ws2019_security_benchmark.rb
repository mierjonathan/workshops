#
# Cookbook:: jmier_windows
# Recipe:: ws2019_security_benchmark
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Useful links
# https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/user-rights-assignment
# https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/security-identifiers
# https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsTimeService::W32TIME_POLICY_ENABLE_NTPCLIENT

# x = registry_get_values('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System')
# log 'test' do
#   message x.to_s
#   level :info
# end

# loops through windows_user_privilege attribue to set user policies
node['jmier_windows']['windows_user_privilege'].each do |key, values|
  windows_user_privilege key do
    privilege      key
    users          values['users']
    action         values['action']
  end
end

# loops through windows_security_policy attribue to set security policies
node['jmier_windows']['windows_security_policy'].each do |key, values|
  windows_security_policy key do
    secoption      key
    secvalue       values['secvalue']
    action         values['action']
  end
end

# loops through registry_key attribue to set registry keys
node['jmier_windows']['registry_key'].each do |key_, values_|
  registry_key key_ do
    key key_
    values values_['values']
  end
end
