# Useful links
# https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/user-rights-assignment
# https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/security-identifiers

describe security_policy do
  its('SeInteractiveLogonRight') { should eq ['S-1-5-32-544'] }
end

describe security_policy do
  its('SeNetworkLogonRight') { should eq ['S-1-5-32-544', 'S-1-5-32-555'] }
end

describe security_policy do
  its('EnableAdminAccount') { should eq '0' }
end

describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System') do
  it { should exist }
  it { should have_property 'DisableCAD' }
  its('DisableCAD') { should eq 0 }
end

describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient') do
  it { should exist }
  it { should have_property 'Enabled' }
  its('Enabled') { should eq 1 }
end

describe registry_key('HKEY_LOCAL_MACHINE\\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer') do
  it { should exist }
  it { should have_property 'Enabled' }
  its('Enabled') { should eq 0 }
end
