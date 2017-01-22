#
# Cookbook Name:: lamp
# Recipe:: httpd-vagrant
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#

instance_name = node['lamp']['httpd']['web']['instance_name'];

httpd_config 'httpd config for vagrant' do
    config_name 'vagrant'
    instance "#{instance_name}"
    source 'httpd/vagrant.conf.erb'
    action :create
    notifies :restart, "httpd_service[#{instance_name}]"
end
