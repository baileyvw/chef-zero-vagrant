#
# Cookbook Name:: docker_drone
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

docker_installation_package 'default' do
  action :create
end

docker_service_manager_systemd 'default' do
  host 'unix:///var/run/docker.sock'
  action :start
end
