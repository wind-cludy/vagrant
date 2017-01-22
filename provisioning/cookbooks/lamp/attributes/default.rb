default['lamp']['httpd']['version'] = "#{default['httpd']['version']}"
default['lamp']['httpd']['web']['instance_name'] = 'web'
default['lamp']['httpd']['web']['document_root'] = '/var/www/html'
default['lamp']['httpd']['web']['http_port'] = 80
default['lamp']['httpd']['web']['https_port'] = 443
default['lamp']['httpd']['web']['ssl_key_path'] = '/etc/pki/tls/private/localhost.key'
default['lamp']['httpd']['web']['ssl_crt_path'] = '/etc/pki/tls/certs/localhost.crt'
default['lamp']['httpd']['web']['ssl_ca_crt_path'] = ''
default['lamp']['httpd']['web']['owner'] = "#{default['httpd']['run_user']}"
default['lamp']['httpd']['web']['group'] = "#{default['httpd']['run_group']}"
default['lamp']['httpd']['web']['aliases'] = {}
default['lamp']['httpd']['web']['virtualhosts'] = []

default['lamp']['mysqld']['version'] = "5.7"
default['lamp']['mysqld']['super_user']['id'] = 'dbadmin'
default['lamp']['mysqld']['super_user']['password'] = 'MySQLPassw0rd'
default['lamp']['mysqld']['master']['instance_name'] = 'server'
default['lamp']['mysqld']['master']['port'] = '3306'
default['lamp']['mysqld']['master']['root_password'] = 'MySQLPassw0rd'

default['lamp']['nodejs']['npm']['packages'] = %w(gulp bower)
default['lamp']['nodejs']['version'] = '6.9.1'
