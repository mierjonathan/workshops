# jmier_mongodb

Cookbook to configure yum repo for mongodb as well as installing mongodb.

## Recipes

#### deafult.rb 
Calls yum_repo.rb and mongobd.rb.
#### yum_repo.rb
Configures yum repos for mongodb package installation. 
#### mongodb.rb
Installs mongodb package needed for installation as well as starting and enabling the mongod service. 

## Attributes 
```
default['jmier_mongodb'] = {
  # Used by yum_repo.rb recipe to configure mongodb repo
  'yum_repo' => {

    'repo_id' => 'mongodb',

    'baseurl' => 'https://repo.mongodb.org/yum/redhat/7/mongodb-org/5.0/x86_64',

    'gpgcheck' => false,

    'enabled' => true,

  },
  # Used by mongodb.rb recipe to install and start/enable mongodb service
  'mongodb' => {

    'package_name' => 'mongodb-org',

    'service_name' => 'mongod',

  },
}
```
## Running cookbook on nodes
#### At bootstrap:
`knife bootstrap ...... -r 'recipe[jmier_mongodb::default]'`
#### Using knife :

Add `jmier_mongodb::default` to runlist via knife with `knife node run_list add <nodename> recipe['jmier_mongodb::default']`

## Testing cookbook
`kitchen.yml` is configured to use the Vagrant driver. 
```
# To view available suites 
$ kitchen list
Instance                Driver   Provisioner  Verifier  Transport  Last Action    Last Error
jmier-mongobd-centos-7  Vagrant  ChefZero     Inspec    Ssh        <Not Created>  <None>

# To deploy vm and run cookbook on vm
$ kitchen-converge jmier-mongobd-centos-7
```
