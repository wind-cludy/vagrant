#
# Cookbook Name:: lamp
# Recipe:: mysql-server
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#


if "#{node['lamp']['mysqld']['version']}" == '5.5' then
  include_recipe 'yum-mysql-community::mysql55'
elsif "#{node['lamp']['mysqld']['version']}" == '5.6' then
  include_recipe 'yum-mysql-community::mysql56'
else
  include_recipe 'yum-mysql-community::mysql57'
end

instance_name = "#{node['lamp']['mysqld']['master']['name']}";
mysql_client "#{instance_name}" do
  version "#{node['lamp']['mysqld']['version']}"
  action [:create]
end
# cliで入るときはmysql -S /var/run/mysql-server/mysqld.sock -u root -pMyPa\$\$wordHasSpecialChars!
mysql_service "#{instance_name}" do
    port "#{node['lamp']['mysqld']['master']['port']}"
    bind_address '0.0.0.0'
    version "#{node['lamp']['mysqld']['version']}"
    initial_root_password "#{node['lamp']['mysqld']['master']['root_password']}"
    charset 'utf8mb4'
    action [:create, :start]
end

mysql_config 'utf8mb4_setting' do
  instance "#{instance_name}"
  source 'mysqld/server_charset.cnf.erb'
  variables(
      :charset => 'utf8mb4',
      :collation => 'utf8mb4_general_ci'
  )
  action :create
  notifies :restart, "mysql_service[#{instance_name}]"
end
mysql_config 'connection_setting' do
  instance "#{instance_name}"
  source 'mysqld/server_common.cnf.erb'
  action :create
  notifies :restart, "mysql_service[#{instance_name}]"
end

package 'mysql-devel'

# https://github.com/sinfomicien/mysql2_chef_gem/issues/5#issuecomment-158498548
mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mysql
  action :install
end

mysql_connection_info = {
  :username => 'root',
  :password => "#{node['lamp']['mysqld']['master']['root_password']}",
  :socket => "/var/run/mysql-#{instance_name}/mysqld.sock"
}
mysql_database_user "#{node['lamp']['mysqld']['super_user']['id']}" do
  connection mysql_connection_info
  password   "#{node['lamp']['mysqld']['super_user']['password']}"
  host       '%'
  privileges [:all]
  grant_option true
  action     [:create,:grant]
end
