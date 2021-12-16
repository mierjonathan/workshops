default['jmier_windows'] = {
  'windows_user_privilege' => {
    'SeInteractiveLogonRight' => {
        'users' => ['BUILTIN\Administrators'],
        'action' => :set,
    },
    'SeNetworkLogonRight' => {
        'users' => ['BUILTIN\Administrators', 'BUILTIN\Remote Desktop Users'],
        'action' => :set,
    },
  },
  'windows_security_policy' => {
     'EnableAdminAccount' => {
         'secvalue' => '0',
         'action' => :set,
     },
  },
  'registry_key' => {
    'HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System' => {
        'values' => [{
            name: 'disablecad',
          type: :dword,
          data: 0,
         }],
    },
    'HKEY_LOCAL_MACHINE\\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient' => {
        'values' => [{
            name: 'Enabled',
          type: :dword,
          data: 1,
         }],
    },
    'HKEY_LOCAL_MACHINE\\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer' => {
        'values' => [{
            name: 'Enabled',
          type: :dword,
          data: 0,
         }],
    },
  },
}
