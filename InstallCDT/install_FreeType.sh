#!/bin/sh
./install_zlib.sh

installResources=`pwd`/Resources
scriptResources=$installResources/scripts
read productVersion DSTROOT < "`pwd`/version.txt"
productFolder=/Developer/Cocotron/$productVersion
downloadFolder=$productFolder/Downloads

#PREFIX=`pwd`/../system/i386-mingw32msvc/freetype-2.3.5
if [[ "$DSTROOT" == *"../"* ]] ;then
PREFIX=`pwd`/$DSTROOT/freetype-2.3.5
else
PREFIX=$DSTROOT/freetype-2.3.5
fi

$scriptResources/downloadFilesIfNeeded.sh $downloadFolder "http://downloads.sourceforge.net/gnuwin32/freetype-2.3.5-1-bin.zip"

mkdir -p $PREFIX
cd $PREFIX

unzip -o $downloadFolder/freetype-2.3.5-1-bin.zip
