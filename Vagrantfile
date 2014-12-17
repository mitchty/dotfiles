# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DOTFILE_PATH'] = "/tmp/vagrant"
Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.provision "shell",
                      privileged: false,
                      inline: "if [ ! -e /var/tmp/.done ]; then
sudo apt-get clean
sudo rm -fr /var/lib/apt/lists
sudo apt-get update
# git 2.N+ instead of ass old git
sudo apt-get install -y -q python-software-properties
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install -y -q xstow python-pip git pax zsh
sudo pip install update-dotdee
sudo usermod -s /bin/zsh vagrant
mkdir /home/vagrant/dotfiles
sudo mount -o bind /vagrant /home/vagrant/dotfiles
touch /var/tmp/.done
fi
cd ~/dotfiles
make ws all
"
end
