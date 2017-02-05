#!/bin/sh
echo "Installing libxml2"
./install_zlib.sh

installResources=`pwd`/Resources
scriptResources=$installResources/scripts

read productVersion DSTROOT < "`pwd`/version.txt"

productFolder=/Developer/Cocotron/$productVersion
downloadFolder=$productFolder/Downloads

#PREFIX=`pwd`/../system/i386-mingw32msvc
if [[ "$DSTROOT" == *"../"* ]] ;then
PREFIX=`pwd`/$DSTROOT/
else
PREFIX=$DSTROOT/
fi

$scriptResources/downloadFilesIfNeeded.sh $downloadFolder "http://xmlsoft.org/sources/win32/libxml2-2.7.7.win32.zip ftp://ftp.zlatkovic.com/libxml/iconv-1.9.2.win32.zip"

mkdir -p $PREFIX
cd $PREFIX
unzip -o $downloadFolder/libxml2-2.7.7.win32.zip
unzip -o $downloadFolder/iconv-1.9.2.win32.zip

