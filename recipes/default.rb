# Encoding: utf-8
# Cookbook Name:: s3cmd
# Recipe:: default
#
# Copyright (C) 2013 sumit
#
# All rights reserved - Do Not Redistribute

remote_file '/etc/yum.repos.d/s3tools.repo' do
  source 'http://s3tools.org/repo/RHEL_6/s3tools.repo'
  :create_if_missing
end

package 's3cmd' do
  not_if 'rpm -qa | grep s3cmd'
end

access_key = node.s3cmd['access_key']
secret_key = node.s3cmd['secret_key']

if node.s3cmd['data_bag']
  aws_creds = data_bag_item(:aws, 'credentials')
  access_key = aws_creds['access_key']
  secret_key = aws_creds['secret_key']
end

template '/root/.s3cfg' do
  source 's3cfg.erb'
  owner 'root'
  group 'root'
  mode '400'
  variables(
    access_key: access_key,
    secret_key: secret_key
  )
  :create
end
