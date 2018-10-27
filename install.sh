#!/usr/bin/env bash

# Gregory Norton
# October 26th, 2018

# Run this script as root.
# This script downloads and installs the pebble SDK as
# per the documentation on ubuntu systems.
# This may work on Debian and other Ubuntu-based distros but
# that is untested.

# Steps from https://developer.rebble.io/developer.pebble.com/sdk/install/linux/index.html

DOWNLOAD_DIR=`pwd`
SDK="pebble-sdk-4.5-linux64"

# Download and unpack SDK
wget "https://developer.rebble.io/s3.amazonaws.com/assets.getpebble.com/pebble-tool/$SDK_ARCHIVE.tar.bz2"
mkdir ~/pebble-dev
cd ~/pebble-dev
tar -jxf "$DOWNLOAD_DIR/$SDK_ARCHIVE.tar.bz2"
rm "$DOWNLOAD_DIR/$SDK.tar.bz2"
echo 'export PATH=~/pebble-dev/pebble-sdk-4.5-linux64/bin:$PATH' >> ~/.bash_profile

# Install python and node dependencies
apt install python-pip python2.7-dev npm
pip install virtualenv

# Configure SDK environment
cd ~/pebble-dev/$SDK
virtualenv --no-site-packages .env
source .env/bin/activate
pip install -r requirements.txt
deactivate

# Need to download SDK from backups since original servers are down.
pebble sdk install https://github.com/aveao/PebbleArchive/raw/master/SDKCores/sdk-core-4.3.tar.bz2

echo "Installation is complete"
