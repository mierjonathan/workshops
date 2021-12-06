default['jmier_mongodb'] = {
  'yum_repo' => {
    'repo_id' => 'mongodb',
    'baseurl' => 'https://repo.mongodb.org/yum/redhat/7/mongodb-org/5.0/x86_64',
    'gpgcheck' => false,
    'enabled' => true,
  },
  'mongodb' => {
    'package_name' => 'mongodb-org',
    'service_name' => 'mongod',
  },
}
