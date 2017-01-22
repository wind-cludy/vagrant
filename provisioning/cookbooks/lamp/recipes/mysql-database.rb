#
# Cookbook Name:: lamp
# Recipe:: mysql-database
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#

require 'shellwords'

instance_name = "#{node['lamp']['mysqld']['master']['name']}";

package 'mysql-devel'

# https://github.com/sinfomicien/mysql2_chef_gem/issues/5#issuecomment-158498548
mysql2_chef_gem 'default' do
  provider Chef::Provider::Mysql2ChefGem::Mysql
  action :install
end

mysql_connection_info = {
    :port     => "#{node['lamp']['mysqld']['master']['port']}",
    :host     => "#{node['lamp']['mysqld']['master']['host']}",
    :username => "#{node['lamp']['mysqld']['super_user']['id']}",
    :password => "#{node['lamp']['mysqld']['super_user']['password']}"
}

# Create a mysql database
node['lamp']['mysqld']['db'].each do |name, database_name|

    # Create a mysql database
    mysql_database "#{database_name}" do
        connection mysql_connection_info
        encoding 'utf8mb4'
        collation 'utf8mb4_unicode_ci'
        action :create
    end
    
    # Grant all privileges
    mysql_database_user "#{node['lamp']['mysqld']['user']['id']}" do
        connection    mysql_connection_info
        password      "#{node['lamp']['mysqld']['user']['password']}"
        database_name "#{database_name}"
        host          '%'
        privileges    [:all]
        action        :grant
    end
end
