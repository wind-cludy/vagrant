#
# Cookbook Name:: lamp
# Recipe:: httpd-web
#
# Copyright 2016, tyrellsystems
#
# MIT Lisence
#


instance_name = node['lamp']['httpd']['web']['instance_name'];


httpd_service "#{instance_name}" do
    version node['lamp']['httpd']['version']
    mpm 'prefork'
    run_user node['lamp']['httpd']['web']['owner']
    run_group node['lamp']['httpd']['web']['group']
    listen_ports %W(#{node['lamp']['httpd']['web']['http_port']} #{node['lamp']['httpd']['web']['https_port']})
    action [:create, :start]
end

%w(
  access_compat
  actions
  alias
  allowmethods
  auth_basic
  auth_digest
  authn_anon
  authn_core
  authn_dbd
  authn_dbm
  authn_file
  authn_socache
  authz_core
  authz_dbd
  authz_dbm
  authz_groupfile
  authz_host
  authz_owner
  authz_user
  autoindex
  cache
  cache_disk
  cache_socache
  data
  dbd
  dir
  dumpio
  echo
  env
  expires
  ext_filter
  filter
  headers
  include
  info
  log_config
  logio
  macro
  mime_magic
  mime
  negotiation
  proxy
  remoteip
  reqtimeout
  request
  rewrite
  setenvif
  slotmem_plain
  slotmem_shm
  socache_dbm
  socache_memcache
  ssl
  status
  substitute
  suexec
  unixd
  userdir
  version
  vhost_alias
  watchdog
).each do |httpd_module_name|
  httpd_module httpd_module_name do
      instance "#{instance_name}"
      action :create
      notifies :restart, "httpd_service[#{instance_name}]"
  end
end


if node['lamp']['httpd']['version'] != '2.2' then
  httpd_module 'socache_shmcb' do
    instance "#{instance_name}"
    action :create
    notifies :restart, "httpd_service[#{instance_name}]"
  end
end




httpd_config 'mime-types' do
    instance "#{instance_name}"
    source 'httpd/mime-types.erb'
    action :create
    notifies :restart, "httpd_service[#{instance_name}]"
end

httpd_config 'common' do
    instance "#{instance_name}"
    source 'httpd/common.conf.erb'
    action :create
    notifies :restart, "httpd_service[#{instance_name}]"
end

httpd_config "web" do
    instance "#{instance_name}"
    source 'httpd/web.conf.erb'
    variables ({
        'httpd_version' => node['lamp']['httpd']['version'],
        'web_server_name' => "#{instance_name}",
        'virtualhosts' => node['lamp']['httpd']['web']['virtualhosts'],
        'web_document_root' => node['lamp']['httpd']['web']['document_root'],
        'web_http_port' => node['lamp']['httpd']['web']['http_port'],
        'aliases' => node['lamp']['httpd']['web']['aliases'],
        
        'web_https_port' => node['lamp']['httpd']['web']['https_port'],
        'ssl_certificate_file' => node['lamp']['httpd']['web']['ssl_crt_path'],
        'ssl_certificate_key_file' => node['lamp']['httpd']['web']['ssl_key_path']
    })
    action :create
    notifies :restart, "httpd_service[#{instance_name}]"
end
