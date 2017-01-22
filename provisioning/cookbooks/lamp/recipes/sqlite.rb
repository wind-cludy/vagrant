#
# Cookbook Name:: lamp
# Recipe:: sqlite
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#

case node['platform_family']
when 'debian'

  package 'sqlite3'
  package 'sqlite3-doc'
  package 'libsqlite3-dev'

when 'rhel', 'fedora'

  package 'sqlite-devel'

end
