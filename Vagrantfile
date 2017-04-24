# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"
  
  config.vm.network "private_network", ip: "192.168.33.33"
  config.vm.synced_folder "./public_html", "/var/www/html", type: "nfs"
  
  config.vm.hostname = "cms.dev"
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  
  config.vm.provision "setup", type: "shell", path: "./setup.sh"
end
