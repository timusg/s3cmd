#
# Cookbook Name:: s3cmd
# Recipe:: default
#
# Copyright (C) 2013 sumit
# 
# All rights reserved - Do Not Redistribute
#


#TODO encrypt data bags

remote_file "/etc/yum.repos.d/s3tools.repo" do
  source "http://s3tools.org/repo/RHEL_6/s3tools.repo"
  :create_if_missing
end

package "s3cmd" do
  not_if "rpm -qa | grep s3cmd"
end

aws_creds = data_bag_item(:aws, "credentials")
template "/root/.s3cfg" do
  source "s3cfg.erb"
  owner "root"
  group "root"
  mode "400"
  variables(:access_key=>aws_creds['access_key'], :secret_key=>aws_creds['secret_key'])
  :create
end

