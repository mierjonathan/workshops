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
