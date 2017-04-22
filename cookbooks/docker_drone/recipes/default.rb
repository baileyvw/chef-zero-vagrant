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

docker_image 'drone/drone' do
  action :pull
end

directory "/drone" do
  mode '0755'
  owner 'root'
  group 'root'
  action :create
  recursive true
end 

# Run container exposing ports
docker_container 'drone-server' do
  repo 'drone/drone'
  port '80:8000'
  volumes [ '/drone:/var/lib/drone/' ]
  restart_policy 'always'
  env ['DRONE_OPEN=true', 'DRONE_GITHUB=true', 'DRONE_GITHUB_CLIENT=1a', 'DRONE_GITHUB_SECRET=1a2b3c', 'DRONE_SECRET=123']
end

docker_container 'drone-agent' do
  repo 'drone/drone'
  volumes [ '/var/run/docker.sock:/var/run/docker.sock' ]
  command 'agent'
  restart_policy 'always'
  env ['DRONE_SERVER=ws://drone-server:8000/ws/broker', 'DRONE_SECRET=123']
end