#
# Cookbook Name:: lamp
# Recipe:: build-essential
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#

include_recipe 'yum-epel::default'
include_recipe 'yum-remi-chef::remi'

include_recipe 'build-essential::default'

%w{
    libtidy
    libmhash
    httpd-devel
    gcc
    gcc-c++
    libxml2-devel
    openssl-devel
    bzip2-devel
    libxslt-devel
    libicu
    libicu-devel
    readline-devel
    libmcrypt
    libmcrypt-devel
}.each do |pkg|
    package pkg do
        action :install
    end
end

include_recipe 'imagemagick::devel'
