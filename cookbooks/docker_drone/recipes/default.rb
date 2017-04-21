#
# Cookbook Name:: docker_drone
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_repository 'docker' do
  baseurl 'https://yum.dockerproject.org/repo/main/centos/7/'
  description 'Docker Repository'
  enabled true
  gpgcheck true
  gpgkey 'https://yum.dockerproject.org/gpg'
end

docker_installation_package 'default' do
  action :create
end

docker_service_manager_systemd 'default' do
  host 'unix:///var/run/docker.sock'
  action :start
end