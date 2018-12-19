# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.define "elk-node1" do |elk_node1|
    elk_node1.vm.box = "ubuntu/xenial64"
    elk_node1.vm.hostname = 'elk-node1'
    elk_node1.vm.box_url = "ubuntu/xenial64"
    elk_node1.vm.network :private_network, ip: "192.168.56.101"
    elk_node1.vm.synced_folder "./", "/vagrant"
    elk_node1.vm.provision "shell", path: "elk_bootstrap.sh"
    #web.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"
  end
  config.vm.define "elk-node2" do |elk_node2|
    elk_node2.vm.box = "ubuntu/xenial64"
    elk_node2.vm.hostname = 'elk-node2'
    elk_node2.vm.box_url = "ubuntu/xenial64"
    elk_node2.vm.network :private_network, ip: "192.168.56.102"
    elk_node2.vm.synced_folder "./", "/vagrant"
    elk_node2.vm.provision "shell", path: "elk_bootstrap.sh"
    elk_node2.vm.network "forwarded_port", host: 5601, guest: 5601
  end
  # config.vm.define "elk-node3" do |elk_node3|
  #   elk_node3.vm.box = "ubuntu/xenial64"
  #   elk_node3.vm.hostname = 'elk-node3'
  #   elk_node3.vm.box_url = "ubuntu/xenial64"
  #   elk_node3.vm.network :private_network, ip: "192.168.56.103"
  #   elk_node3.vm.synced_folder "./", "/vagrant"
  #   elk_node3.vm.provision "shell", path: "elk_bootstrap.sh"
  # end
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false
  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
     vb.memory = "4096"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
