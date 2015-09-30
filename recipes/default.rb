#
# Cookbook Name:: company-webapp
# Recipe:: default
#
# Copyright (C) 2015 Jeremy J. Miller
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe 'git'
include_recipe 'nginx'

directory node['company-webapp']['docroot'] do
  recursive true
  action :create
end

git node['company-webapp']['docroot'] do
   repository node['company-webapp']['gitrepo']
   revision node['company-webapp']['gitbranch']
   action :sync
end

begin
  t = resources("template[#{node['nginx']['dir']}/sites-available/default]")
  t.source 'default-site.erb'
  #t.cookbook #{cookbook_name}
  t.cookbook 'company-webapp'
  t.notifies :reload, 'service[nginx]', :delayed
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn 'Template Override failed: could not find template!'
end
