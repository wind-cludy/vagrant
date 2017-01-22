#
# Cookbook Name:: lamp
# Recipe:: rbenv-user
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#

include_recipe 'ruby_build::default'
include_recipe 'ruby_rbenv::user'
