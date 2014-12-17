# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_DOTFILE_PATH'] = "/tmp/vagrant"
Vagrant.configure("2") do |config|
  config.vm.define "ubuntu1204" do |ubuntu1204|
    ubuntu1204.vm.box = "precise64"
    ubuntu1204.vm.synced_folder ".", "/home/vagrant/dotfiles"
    ubuntu1204.vm.provision "shell",
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
touch /var/tmp/.done
fi
cd ~/dotfiles
make clean && make
"
  end

  # 10.{10,9} are the same basically
  osx_cmd = "sudo xcodebuild -license accept
sudo xcode-select -s /Applications/Xcode.app
ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"
export PATH=/usr/local/bin:${PATH}
brew install gcc xstow python
pip install update-dotdee
cd ~/dotfiles
make clean && make
"
  config.vm.define "yosemite" do |yosemite|
    yosemite.vm.box = "yosemite"
    yosemite.vm.synced_folder ".", "/Users/vagrant/dotfiles"
    yosemite.vm.provision "shell", privileged: false, inline: osx_cmd
  end

  config.vm.define "mavericks" do |mavericks|
    mavericks.vm.box = "mavericks"
    mavericks.vm.synced_folder ".", "/Users/vagrant/dotfiles"
    mavericks.vm.provision "shell", privileged: false, inline: osx_cmd
  end
end
