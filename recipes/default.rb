#
# Cookbook Name:: company-webapp
# Recipe:: default
#
# Copyright (C) 2015 Jeremy J. Miller
#
# All rights reserved - Do Not Redistribute
#
#
# install git client
include_recipe 'git'
# install nginx server
include_recipe 'nginx'

# create the landing directory
directory node['company-webapp']['docroot'] do
  recursive true
  action :create
end

# grab the code, the current commit hash is used for idempotency
git node['company-webapp']['docroot'] do
   repository node['company-webapp']['gitrepo']
   revision node['company-webapp']['gitbranch']
   action :sync
end

# override the default website with our own
begin
  t = resources("template[#{node['nginx']['dir']}/sites-available/default]")
  t.source 'default-site.erb'
  t.cookbook 'company-webapp'
  t.notifies :reload, 'service[nginx]', :delayed
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn 'Template Override failed: could not find template!'
end
