# jmier_windows

Cookbook to set user and security policies as well as registry keys using attributes. 

## Recipes

#### deafult.rb 
Calls ws2019_security_benchmark.rb and mongobd.rb.
#### Calls ws2019_security_benchmark.rb
set user and security policies as well as registry keys using attributes. 

## Attributes 
```
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

```

To add a windows_user_privilege resource add a entry under 
```
default['jmier_windows'] = {
  'windows_user_privilege' => {
      'Constant Name' => {
          'users' => ['BUILTIN\Example'],
          'action' => :set,
      }

  }
}
```

To add a windows_security_policy resource add a entry under 
```
default['jmier_windows'] = {
  'windows_security_policy' => {
      'secoption' => {
          'secvalue' => '0',
          'action' => :set,
      }
  }
}
```

To add a registry_key resource add entry under
```
default['jmier_windows'] = {
  'registry_key' => {
      'regestry_key_path' => {
          'values' => => [{
            name: 'Enabled',
          type: :dword,
          data: 0,
         }],
      }
  }
}
```

## Running cookbook on nodes
#### At bootstrap:
`knife bootstrap ...... -r 'recipe[jmier_windows::default]'`
#### Using knife :

Add `jmier_windows::default` to runlist via knife with `knife node run_list add <nodename> recipe['jmier_windows::default']`

## Testing cookbook
```
chef-client -z -r "recipe[jmier_windows::default]"
```
