#
# Cookbook Name:: lamp
# Recipe:: php
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#

include_recipe 'yum-remi-chef::remi-php70'


include_recipe 'php::default'

yum_package ['php-pecl-zip', 'php-pecl-imagick']

include_recipe 'composer::install'
