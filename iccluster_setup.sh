#!/bin/bash

# update repositories and upgrade packages
apt-get update
apt-get --assume-yes upgrade

# install python and tools
apt-get --assume-yes install nano
apt-get --assume-yes install python python-dev python-pip
apt-get --assume-yes install python3 python3-dev python3-pip

mkdir /home/downloads
cd /home/downloads

# download and install CUDA
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda

# install python packages for machine learning
yes | pip2 install --upgrade pip
yes | pip3 install --upgrade pip
yes | pip2 install pillow matplotlib mpmath jupyter pandas keras sklearn tensorflow tensorflow-gpu
yes | pip3 install pillow matplotlib mpmath jupyter pandas keras sklearn tensorflow tensorflow-gpu

# install pytorch
pip2 install torch torchvision
pip3 install torch torchvision

# set up jupyter (uncomment last line for Python 2.7)
jupyter notebook --allow-root --generate-config
echo "c.NotebookApp.ip = '*'" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.allow_remote_access = True" >> /root/.jupyter/jupyter_notebook_config.py
#python2 -m ipykernel install

# clean up
cd /home
rm -r ./downloads
