#
# Cookbook Name:: lamp
# Recipe:: httpd-php
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#


instance_name = node['lamp']['httpd']['web']['instance_name'];


httpd_module 'php' do
    instance "#{instance_name}"
    module_name 'php7'
    package_name 'mod_php'
    filename 'libphp7.so'
    action :create
    notifies :restart, "httpd_service[#{instance_name}]"
end

httpd_config 'mod_php config' do
    config_name 'php'
    instance "#{instance_name}"
    source 'httpd/php.conf.erb'
    action :create
    notifies :restart, "httpd_service[#{instance_name}]"
end
