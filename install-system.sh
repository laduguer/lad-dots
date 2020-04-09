#!/usr/bin/env bash

# clean pre-installed junk
rm -rf \
	~/Videos \
  ~/Music \
	~/Templates \
	~/Public

# install libs
sudo add-apt-repository universe
sudo apt update
sudo apt install -y \
	snapd \
	vim \
	chromium \
	maven \
	xclip \
	bash-completion

sudo apt upgrade -y

sudo snap install teams-for-linux

sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/ColinDuquesnoy/xUbuntu_19.10/ /' > /etc/apt/sources.list.d/mellowplayer.list"
wget -nv https://download.opensuse.org/repositories/home:ColinDuquesnoy/xUbuntu_19.10/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt update
sudo apt install mellowplayer
rm Release.key

export PATH="/snap/bin:$PATH"

# docker
# allow https repositories
sudo apt install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD8

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo groupadd docker
sudo usermod -aG docker "${USER}"

# az cli
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt update
sudo apt install azure-cli -y

# kubectl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt get update
sudo apt-get install -y kubectl

# make good dirs
echo 'renaming uppercase dirs..'
[[ -f ~/Documents ]] && mv ~/Documents ~/documents
[[ -f ~/Downloads ]] && mv ~/Downloads ~/downloads
[[ -f ~/Pictures ]] && mv ~/Pictures ~/pictures
[[ -f ~/Public ]] && mv ~/Public ~/public
echo '..done renaming uppercase dirs'

echo 'creating projects dirs..'
[[ -f ~/projects ]] && mkdir ~/projects
echo '..done creating projects dirs'

echo 'executing git setup..'
./git.sh
echo '..done executing git setup'

echo 'installing bash profile..'
cp ./.bash_profile ~/.bash_profile
source ~/.bash_profile
echo "source ~/.bash_profile" >> ~./bashrc
echo '..done installing bash profile'