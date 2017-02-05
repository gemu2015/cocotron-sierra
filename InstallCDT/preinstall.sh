#!/bin/sh

/bin/echo "installing cocotron prerequisites, this may cattake a long time"
/bin/echo "installing home-brew"


ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew -v install homebrew/versions/gcc49

cd /usr/bin

rm /usr/local/bin/gcc

# this line must be adapted to the current version of home-brew
sudo ln -s /usr/local/Cellar/gcc@4.9/4.9.3_1/bin/gcc-4.9 /usr/local/bin/gcc

/bin/echo "done with home-brew"


# make specs and writable
sudo mkdir -p "/Library/Application Support/Developer/Shared/Xcode/Specifications"
sudo chmod 775 "/Library/Application Support/Developer/Shared/Xcode/Specifications"
