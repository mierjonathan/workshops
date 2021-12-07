# jmier_tomcat

Cookbook to install tomcat

## Recipes

#### deafult.rb 
Calls tomcat.rb recipe
#### tomcat.rb
Configures and installs tomcat

## Attributes 
```
default['jmier_tomcat'] = {
    'package_name' => 'java-1.7.0-openjdk-devel',
    'user' => {
      'name' => 'tomcat',
      'home' => '/opt/tomcat',
      'shell' => '/bin/nologin',
    },
    'group' => 'tomcat',
    'tomcat_tar_url' => 'http://apache.cs.utah.edu/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73.tar.gz',
    'tomcat_tar_file' => 'apache-tomcat-8.5.73.tar.gz',
    'tomcat_directories' => %w(webapps work temp logs),
  }
```
## Running cookbook on nodes
#### At bootstrap:
`knife bootstrap ...... -r 'recipe[jmier_tomcat::default]'`
#### Using knife :

Add `jmier_tomcat::default` to runlist via knife with `knife node run_list add <nodename> recipe['jmier_tomcat::default']`

## Testing cookbook
`kitchen.yml` is configured to use the Vagrant driver. 
```
# To view available suites 
$ kitchen list
Instance                Driver   Provisioner  Verifier  Transport  Last Action    Last Error
jmier-tomcat-centos-7  Vagrant  ChefZero     Inspec    Ssh        <Not Created>  <None>

# To deploy vm and run cookbook on vm
$ kitchen-converge jmier-tomcat-centos-7
```
