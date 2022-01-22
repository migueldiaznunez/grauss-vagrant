
Vagrant.configure("2") do |config|
    config.vm.box = "fedora/32-cloud-base"
    config.vm.box_version = "32.20200422.0"
    
    config.vm.network "private_network", type: "dhcp"

    config.ssh.forward_agent="true"
    config.ssh.forward_x11="true"

    # config.vm.network "forwarded_port", guest: 9001, host: 9001

    config.ssh.username="vagrant"
    config.ssh.password="vagrant"

    config.vm.synced_folder "./data", "/vagrant"

    config.vbguest.auto_update = false
    config.vbguest.no_remote = true
    
    # VirtualBox specific settings
    config.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.cpus = 2
      vb.memory = "4096"
    end

    config.vm.provision "shell", path: "provision/install.sh"

end