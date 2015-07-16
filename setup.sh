#!/bin/sh

mkdir -p rpi-sdk
cd rpi-sdk

#get cross compiler tool chain for raspberrypi
echo ""
echo "##############################"
echo "#    Get Cross Toolchain     #"
echo "##############################"
echo ""
mkdir -p toolchain
cd toolchain
git clone https://github.com/raspberrypi/tools.git ./
cd ../

#create staging dir for raspberrypi
echo ""
echo "##############################"
echo "#     Create RPi Staging     #"
echo "##############################"
echo ""
mkdir -p staging
cd staging
#wget tar file
wget https://dl.dropboxusercontent.com/u/63484953/rpi-staging-raspbian-wheezy.tar.bz
tar xpjf rpi-staging-raspbian-wheezy.tar.bz ./
cd ../

cd ../
